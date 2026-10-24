import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ExternalApiClient {
  late final Dio _dio;

  ExternalApiClient({
    required String baseUrl,
    required String? accessToken
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
       // contentType: 'application/json',
        headers: {
          'accept': 'application/json',
          if(accessToken != null && accessToken.isNotEmpty)
            'Authorization': 'Bearer $accessToken',
        },
        validateStatus: _validateStatus,
      ),
    );


    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          requestHeader: false,
          responseBody: true,
          error: true,
        ),
      );
    }
  }


  Future<Response> get(
      String path, {
        String? accessToken,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,

      }) {
    return _dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
        ),
      );
  }



  Future<Response> post(
      String path, {
        String? accessToken,
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'accept': 'application/json',
          }
      ),
    );
  }



  Future<Response> put(
      String path, {
        String? accessToken,
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) {
    return _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'accept': 'application/json',
          }
      ),
    );
  }



}

bool _validateStatus(int? status) {
  return status != null && status >= 200 && status < 300;
}