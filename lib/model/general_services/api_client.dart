import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:springboot_flutter_bloggingapp/model/data/token_repository.dart';
//import 'package:springboot_flutter_bloggingapp/model/services/exceptions.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import '../../main.dart';
import '../../view/utilities/constants.dart';
import 'exceptions.dart';





class ApiClient{

  final TokenRepository tokenRepository;

  late Dio _dio;

  ApiClient({required this.tokenRepository}) {



    final options = BaseOptions(
      baseUrl: baseUrl.toString(),
      connectTimeout: const Duration(milliseconds: 60000),
      receiveTimeout: const Duration(milliseconds: 60000),
      contentType: 'application/json',
      validateStatus: _validateStatus
    );

    _dio = Dio(options);


    var cache = <Uri, Response>{};
    //check cache when uri needed instead calling network


    final presetHeaders = <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
    };

    _dio.options.headers = presetHeaders;

    _dio.interceptors.addAll([
       InterceptorsWrapper(
           onRequest: (options, handler){
             if(cache.containsKey(options.uri)){
               return handler.resolve(cache[options.uri]!);
             }
             final token = getToken();
             if(token != null){
             print("inside the api client");
             options.headers["Authorization"] =  "Bearer $token";
             }
             return handler.next(options);
           },
           onResponse: (Response response, handler){
             cache[response.requestOptions.uri] = response;
             //save to cache with key (url)

             return handler.resolve(response);
       }, onError: (err, handler) async{
             var userCredentials = tokenRepository.getUserCredentials();
             if (err.response?.statusCode == 204) {
               //content
               return handler.resolve(
                   Response(requestOptions: RequestOptions(path: baseUrl!)));
               //fake success
             }
             if (err.response?.statusCode == 202) {
               return handler.resolve(err.response!);
               //pass
             }
             if(err.response?.statusCode == 401 ||
                 err.response?.statusCode == 403){
               print("token expired");

               var options = err.response!.requestOptions;
               //get the request that failed

               if(userCredentials.refreshToken == null){
                 return handler.reject(err);
               }

               try{

                 print("refreshing token");
                 //given a refresh token api
                 final response = await Dio().post(
                   '$baseUrl/token/refresh/',
                   data: {"refresh": userCredentials.refreshToken},
                 );


                 if(_validateStatus(response.statusCode)){
                   await tokenRepository.updateUserCredentials(
                       userCredentials.copyWithToken(
                           response.data['access_token'], response.data['refresh_token']));
                   try{

                     final opts = Options(
                       method: options.method,
                       headers: options.headers,
                       contentType: options.contentType);

                     //retry the failed request with a new token
                     final cloneResponse = await _dio.request(options.path,
                         options: opts,
                         data: options.data,
                         queryParameters: options.queryParameters);
                     if (cloneResponse != null) {
                       return handler.resolve(cloneResponse);
                     } else {
                       return;
                     }
                   } on DioException catch (err) {
                     return handler.reject(err);
                   }

                 } else{
                   return handler.reject(err); //handle with custom error something went wrong
                 }
               } on DioException catch (err) {
                 if (kDebugMode) {
                   print("error of other request");
                 }
                 return handler
                     .reject(err); //handle with custom error something went wrong
               }
             } else if (err.type == DioExceptionType.connectionTimeout) {
               //'no internet' backup....prob. show last data in store
               var cachedResponse = cache[err.requestOptions.uri];
               if (cachedResponse != null) {
                 return cachedResponse.data;
               }
             }

             return handler.reject(err);

           }),

       //remove or set all to false for production release
       LogInterceptor(
         requestBody: true,
         requestHeader: false,
         responseBody: true,
         error: true,
       )
     ]);

  }


  Future<Response> get(
      String uri,{
        Map<String, dynamic>? queryParameters,
  }) async{
    try{
      final response = await _dio.get(
        uri,
        queryParameters: queryParameters,
      ).catchError((err){
        throw err as DioException;
      });
      return response;
    } catch(e){
      throw ApiException(e.toString());
    //  throw ApiException.getException(e);
    }
  }


  Future<Response> post(
    String uri, {
      Map<String, dynamic>? data,
      FormData? formData,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? extraHeaders,

      }) async{
    try{
      if (extraHeaders != null){
        _dio.options.headers.addAll(extraHeaders);
      } if(data != null){
        _dio.options.contentType = "application/json";
      }
      if (formData != null) {
        _dio.options.contentType = "multipart/form-data";
      }

      final response = await _dio.post(
        uri,
        data: data ?? formData,
          //that is if data is null, then it will be formdata
        queryParameters: queryParameters,
      ).catchError((err){
        if (formData != null){
          _dio.options.contentType = "application/json";
        }

        // mixpanel.track("USER ENCOUNTERED AN ERROR WHILE RUNNING REQUEST", properties: {
        //   "url": uri,
        //   "method":'POST',
        //   "error": ApiException.getException(err).message,
        //   'erroCode': err.toString(),
        //   if (queryParameters != null)'queryParameters': queryParameters,
        //   if (extraHeaders != null) 'extraHeaders': extraHeaders,
        // });
        throw err as DioException;
      });
      return response;

    } catch(e){
      if (formData != null) {
        _dio.options.contentType = "application/json";
      }
      throw ApiException(e.toString());
     // throw ApiException.getException(e);
    }

  }


  Future<Response> put(
      String uri, {
        Map<String, dynamic>? data,
        FormData? formData,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? extraHeaders,
  }) async{
    try{

      final response = await _dio.put(
        uri,
        data: data ?? formData,
        queryParameters: queryParameters,
      ).catchError((err){
        if (formData != null) {
          _dio.options.contentType = "application/json";
        }

        throw err as DioException;
      });
      return response;
    }  catch (e) {
      if (formData != null) {
        _dio.options.contentType = "application/json";
      }
      throw ApiException(e.toString());
     // throw ApiException.getException(e);
    }
  }


  Future<Response> patch(
  String uri, {
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  }) async{
    try{

      final response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
      ).catchError((err){

        throw err as DioException;
      });
      return response;
    } catch (e) {
      throw ApiException(e.toString());
     // throw ApiException.getException(e);
    }

  }

  Future<Response> delete(
      String uri, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? extraHeaders,
      }) async {
    try {
      if (extraHeaders != null) {
        _dio.options.headers.addAll(extraHeaders);
      }
      if (data != null) {
        _dio.options.contentType = "application/json";
      }
      final response = await _dio!.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
      ).catchError((err){

        throw err as DioException;
      });

      return response;
    } catch (e) {
      throw ApiException(e.toString());
     // throw ApiException.getException(e);
    }
  }

  String? getToken(){
    return tokenRepository.getUserCredentials().accessToken;
  }

}



bool _validateStatus(int? status){
  return status! == 200 || status == 201;
}

extension ResponseExtension on Response {
  bool get isSuccess {
    final is200 = statusCode == HttpStatus.ok;
    final is201 = statusCode == HttpStatus.created;
    return is200 || is201;
  }
}