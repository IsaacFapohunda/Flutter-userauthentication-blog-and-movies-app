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

    //we will have _dio taking care of all our timeouts now replacing conditions and catches of http, instead of our conventional http

    //we could even do alternative as
   // _dio.options.connectTimeout = Duration(milliseconds: 60000);


    var cache = <Uri, Response>{};
    //a function not returning anything yet, we will declare it later

    //what is cache.
    //stores http response temporarily, so when you call same request without hitting api, you have the response faster
    //reduces network calls and speeds up response
    //save bandwidths. Avoids redundant data downloads
    // allows app to work with previously fetched data when offline
    //dio dont have inbuilt cache, you design it yourself



    //now we will set our headers globally
    // using a custom header we will call presetHeaders

    final presetHeaders = <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
    };

    _dio.options.headers = presetHeaders;
    //for advanced cases, setting headers dynamically, we can use interceptors for dynamic presetheaders
    //e.g adding auth token from shared pref
    //it dynamically adds request to all requests before they are sent.

    _dio.interceptors.addAll([
       InterceptorsWrapper(
           onRequest: (options, handler){
             final token = getToken();
             if(token != null){
             print("inside the api client");
             options.headers["Authorization"] =  "Bearer $token";
             }
             return handler.next(options);
           }, onResponse: (Response response, handler){
             cache[response.requestOptions.uri] = response;
             return handler.resolve(response);
       }, onError: (err, handler) async{
             var userCredentials = tokenRepository.getUserCredentials();
             if (err.response?.statusCode == 204) {
               return handler.resolve(
                   Response(requestOptions: RequestOptions(path: baseUrl!)));
             }
             if (err.response?.statusCode == 202) {
               return handler.resolve(err.response!);
             }
             if(err.response?.statusCode == 401 ||
                 err.response?.statusCode == 403){
               print("token expired");

               var options = err.response!.requestOptions;

               if(userCredentials.refreshToken == null){
                 return handler.reject(err);
               }

               try{
                 //here we are trying to refresh token
                 //update user credentials
                 //clone the response
                 print("refreshing token");
                 final response = await Dio().post(
                   '${baseUrl}/token/refresh/',
                   data: {"refresh": userCredentials.refreshToken},
                   //that is the data  ()refresh token) we pass to it in order to get a new access token
                   //is the refresh token stored in the usercredentials
                 );

                 // mixpanel.track("API CALL", properties: {
                 //   "url": response.requestOptions.uri,
                 //   "method": response.requestOptions.method,
                 //   "status code": response.statusCode,
                 //   "status message": response.statusMessage,
                 // });

                 if(_validateStatus(response.statusCode)){
                   await tokenRepository.updateUserCredentials(
                       userCredentials.copyWithToken(
                           response.data['access_token'], response.data['refresh_token']));
                   try{
                     final opts = Options(
                       method: options.method,
                       headers: options.headers,
                       contentType: options.contentType);
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
               var cachedResponse = cache[err.requestOptions.uri];
               if (cachedResponse != null) {
                 return cachedResponse.data;
               }
             }

             return handler.reject(err);

           }),
       LogInterceptor(
         requestBody: true,
         requestHeader: false,
         responseBody: true,
         error: true,
       )
     ]);

  }


  void setAuthCookie(){
    final token = getToken();
    //cookies or sometimes authenticationToken are small piece of data  stored by client and sent with
    //requests to server
    //cookies are used for authentication
    //receive cookies from server or send cookies
    if(token != null){
      _dio.options.headers['cookie'] = getToken();
    }
  }



  Future<Response> get(
      String uri,{
        Map<String, dynamic>? queryParameters,
  }) async{
    try{
      setAuthCookie();
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
      setAuthCookie();
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
      setAuthCookie();

      final response = await _dio.put(
        uri,
        data: data ?? formData,
        queryParameters: queryParameters,
      ).catchError((err){
        if (formData != null) {
          _dio.options.contentType = "application/json";
        }
        // mixpanel.track("USER ENCOUNTERED AN ERROR WHILE RUNNING REQUEST", properties: {
        //   "url": uri,
        //   "method":'PUT',
        //   "error": ApiException.getException(err).message,
        //   'erroCode': err.toString(),
        //   if (queryParameters != null)'queryParameters': queryParameters,
        //   if (extraHeaders != null) 'extraHeaders': extraHeaders,
        // });
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
      setAuthCookie();
      final response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
      ).catchError((err){
        // mixpanel.track("USER ENCOUNTERED AN ERROR WHILE RUNNING REQUEST", properties: {
        //   "url": uri,
        //   "method":'PATCH',
        //   "error": ApiException.getException(err).message,
        //   'erroCode': err.toString(),
        //   if (queryParameters != null)'queryParameters': queryParameters,
        // });
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
      setAuthCookie();
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
        // mixpanel.track("USER ENCOUNTERED AN ERROR WHILE RUNNING REQUEST", properties: {
        //   "url": uri,
        //   "method":'DELETE',
        //   "error": ApiException.getException(err).message,
        //   'errorCode': err.toString(),
        //   if (queryParameters != null)'queryParameters': queryParameters,
        //   if (extraHeaders != null) 'extraHeaders': extraHeaders,
        // });
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