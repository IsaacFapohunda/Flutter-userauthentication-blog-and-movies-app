import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

const kInternetConnectionError = 'No internet connection, try again.';
const kTimeOutError = 'Please check your internet conenction.';
const kServerError = 'Something went wrong, try again.';
const kFormatError = 'Unable to process data at this time.';
const kUnAuthorizedError = 'Session expired, please login to proceed.';
const kDefaultError = 'Oops something went wrong!';
const kBadRequestError = 'Bad request, please try again.';
const kNotFoundError = 'An error occured, please try again.';
const kRequestCancelledError = 'Request to server was cancelled.';




class ApiException implements Exception{
  final String message;

  ApiException(this.message);

  static ApiException getException(error){
    debugPrint('DioError: ${(error as DioException).message}');
    debugPrint("DioError: ${error.response!.data}");
    switch(error.type){
      //if the request was cancelled
      case DioExceptionType.cancel:
        return OtherExceptions(kRequestCancelledError);

        //timeout errors
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return InternetConnectException(kTimeOutError);

      case DioExceptionType.badCertificate:
      // TODO: Handle this case.


      case DioExceptionType.unknown:
        if(error.error is FormatException){
          return FormatException();
        }

        //socket exception
    if(error.error is SocketException){
      return InternetConnectException("No internet connection. Try again");
    }
    break;
      case DioExceptionType.badResponse:

        try{
          //be it thirdparty api data or our app api data, django, spring, it covers everything
          final data = error.response?.data;
          final statusCode = error.response?.statusCode;

          if(data != null && data is Map) {
            String serverResponse = data['responseMessage']
                ?? data['message'] ?? data['detail'] ?? data['error'];

            return OtherExceptions(serverResponse.toString());

          }
           if(data['errors'] is List){
             return OtherExceptions((data['errors'] as List).join(', '));
           }

          else{
            // IF THERE IS NO PAYLOAD, we check for respective status codes and assign them fit error messages
            switch (error.response?.statusCode) {

              case 500:
                return InternalServerException();

              case 404:
              case 502:
                return OtherExceptions(kNotFoundError);
              case 400:
                return OtherExceptions(kBadRequestError);
              case 403:
              case 401:
                return UnAuthorizedException();


              default:
              // default exception error message
                return OtherExceptions(kDefaultError);
            }
          }
        } catch(e){
          log("error: $e");
          return OtherExceptions(kDefaultError);
        }

    }

    return OtherExceptions(kDefaultError);
  }

}



class OtherExceptions implements ApiException{
  OtherExceptions(this.newMessage);

  final String newMessage;

  @override
  String toString() => message;

  @override
  String get message => newMessage;

}

class FormatException implements ApiException {
  @override
  String toString() => message;

  @override
  String get message => kFormatError;
}

class InternetConnectException implements ApiException {
  InternetConnectException(this.newMessage);

  final String newMessage;

  @override
  String toString() => message;

  @override
  String get message => newMessage;
}

class InternalServerException implements ApiException {
  @override
  String toString() {
    return message;
  }

  @override
  String get message => kServerError;
}

class UnAuthorizedException implements ApiException {
  @override
  String toString() {
    return message;
  }

  @override
  String get message => kUnAuthorizedError;
}

class CacheException implements Exception {
  CacheException(this.message) : super();

  String message;

  @override
  String toString() {
    return message;
  }
}