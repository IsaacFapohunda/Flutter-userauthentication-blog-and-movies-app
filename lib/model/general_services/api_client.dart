import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:springboot_flutter_bloggingapp/model/data/token_repository.dart';
import '../../main.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  final tokenRepository = ref.watch(tokenRepositoryProvider);
  return ApiClient(
    tokenRepository: tokenRepository,);
});


class ApiClient {
  final TokenRepository tokenRepository;

  late final Dio _dio;

  ApiClient({
    required this.tokenRepository,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl.toString(),
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        contentType: 'application/json',
        validateStatus: _validateStatus,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = getToken();
          if (kDebugMode) {
            print("???????????????????????????????????????????Sending token: $token");

          }


          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          handler.next(options);
        },

        onError: (error, handler) async {
          if (error.response?.statusCode == 401 ||
              error.response?.statusCode == 403) {
            final handled = await _refreshAndRetry(error);

            if (handled != null) {
              return handler.resolve(handled);
            }
          }

          handler.next(error);
        },
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
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) {
    return _dio.get(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }


  Future<Response> post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }



  Future<Response> put(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) {
    return _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }



  Future<Response> patch(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) {
    return _dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }



  Future<Response> delete(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) {
    return _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }



  String? getToken() {
    return tokenRepository.getUserCredentials().accessToken;
  }



  Future<Response?> _refreshAndRetry(
      DioException error,
      ) async {
    final credentials = tokenRepository.getUserCredentials();

    final refreshToken = credentials.refreshToken;

    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }

    try {
      final refreshDio = Dio(
        BaseOptions(
          baseUrl: baseUrl.toString(),
          contentType: 'application/json',
          validateStatus: _validateStatus,
        ),
      );

      final response = await refreshDio.post(
        '/token/refresh/',
        data: {
          'refresh': refreshToken,
        },
      );

      final newAccessToken = response.data['access_token'];
      final newRefreshToken = response.data['refresh_token'];

      if (newAccessToken == null) {
        return null;
      }

      await tokenRepository.updateUserCredentials(
        credentials.copyWithToken(
          newAccessToken,
          newRefreshToken,
        ),
      );

      final requestOptions = error.requestOptions;

      requestOptions.headers['Authorization'] =
      'Bearer $newAccessToken';

      return await _dio.fetch(requestOptions);
    } on DioException {
      return null;
    }
  }
}

// Accept all successful HTTP responses.
bool _validateStatus(int? status) {
  return status != null && status >= 200 && status < 300;
}

extension ResponseExtension on Response {
  bool get isSuccess {
    final status = statusCode;

    return status != null &&
        status >= 200 &&
        status < 300;
  }
}