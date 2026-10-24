import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:springboot_flutter_bloggingapp/main.dart';
//import 'package:springboot_flutter_bloggingapp/model/services/endpoints_url.dart';
//import 'package:springboot_flutter_bloggingapp/model/services/exceptions.dart';
import 'package:springboot_flutter_bloggingapp/model/requests/login_request.dart';
import 'package:either_dart/either.dart';
import 'package:springboot_flutter_bloggingapp/model/requests/send_otp_request.dart';
import 'package:springboot_flutter_bloggingapp/model/requests/uploadDp_request.dart';
import 'package:springboot_flutter_bloggingapp/model/response/sign_up_response.dart';
import '../../general_services/Endpoints_url.dart';
import '../../response/verify_otp_response.dart';
import '../../general_services/api_client.dart';
import '../../requests/sign_up_request.dart';
import '../../response/login_response.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

import '../../general_services/exceptions.dart';






///talk to http as app backend guy, handles network errors and all backend shiled
///returns the data or error but no app business logic


abstract class AuthApi{
  Future<Either<ApiException, LoginResponse>> login(LoginRequest loginRequest);
  Future<Either<ApiException, SignUpResponse>> signUp(SignUpRequest signUpRequest);
  Future<Either<ApiException, VerifyOtpResponse>> verifyOtp(OtpRequest otpRequest);
  ///well this upload dp mighnt need be in the authentication api class
  //Future<Either<ApiException, String>> uploadDp(UploadDpRequest uploadDpRequest);
}
class AuthAPiImpl extends AuthApi{

  AuthAPiImpl(this.apiClient);
  final ApiClient apiClient;



  @override
  Future<Either<ApiException, LoginResponse>> login(LoginRequest loginRequest) async{

    try{

      final httpResponse = await apiClient.post(Endpoints.login, data: loginRequest.toJson());
      debugPrint("token ${httpResponse.data}");
    final response = LoginResponse.fromJson(httpResponse.data);

    // mixpanel.track("USER LOGGED IN SUCCESSFULLY", properties: {
    // "url": httpResponse.requestOptions.uri,
    // "method": httpResponse.requestOptions.method,
    // "status code": httpResponse.statusCode,
    // "status message": httpResponse.statusMessage,
    // });
    return Right(response);
    } catch (err) {
      if(err is DioException){
        return Left(ApiException.getException(err));
      }
      return Left(ApiException(err.toString()));
    }
  }



  @override
  Future<Either<ApiException, SignUpResponse>> signUp(
      SignUpRequest signUpRequest) async {
    try {
      final httpResponse =
      await apiClient.post(Endpoints.signup,
          data: signUpRequest.toJson());
      final response = signUpResponseFromJson(jsonEncode(httpResponse.data));
      return Right(response);
    } catch (err) {
      if(err is DioException){
       ///error from api
        return Left(ApiException.getException(err));
      }
      ///error from our configuration
      return Left(ApiException(err.toString()));
    }
  }

  @override
  Future<Either<ApiException, VerifyOtpResponse>> verifyOtp(OtpRequest otpRequest) async{
    try{
      final httpResponse = await apiClient.post(
          Endpoints.verifyAuthOtp,
        data: otpRequest.toJson());
      final response = VerifyOtpResponse.fromJson(httpResponse.data);
      print('httpResponse.data : ${httpResponse.data}');
        return Right(response);

    } catch(err){
      if(err is DioException){
        return Left(ApiException.getException(err));
      }
      debugPrint('This is the OTP Error: $err');
      return Left(ApiException(err.toString()));
    }
    
  }

  // @override
  // Future<Either<ApiException, String>> uploadDp(UploadDpRequest uploadDpRequest) async{
  //   try{
  //     final httpResponse = await apiClient.post(Endpoints.uploadDp,
  //         data: uploadDpRequest.toJson());
  //
  //   } catch(){
  //
  //   }
  }