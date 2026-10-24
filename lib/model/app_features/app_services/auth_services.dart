import 'dart:convert';
import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:springboot_flutter_bloggingapp/model/response/sign_up_response.dart';
//import 'package:springboot_flutter_bloggingapp/model/services/auth_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../main.dart';
import '../../repository/token_repository.dart';
import '../../requests/login_request.dart';
import '../../requests/send_otp_request.dart';
import '../../requests/sign_up_request.dart';
import '../../general_services/api_client.dart';
import '../interceptor/auth_interceptor.dart';
import '../../general_services/exceptions.dart';


final authServiceProvider = Provider<AuthServiceImpl>((ref) {
  final tokenRepository = TokenRepositoryImpl();
  final client = ApiClient(tokenRepository: tokenRepository) ;
  final authApi = AuthAPiImpl(client);
  return AuthServiceImpl(authApi: authApi, tokenRepository: tokenRepository);
});




///Blueprint
abstract class AuthService {
  Future<Either<ApiException, bool>> login(LoginRequest loginRequest);
  Future<Either<ApiException, bool>> signup(SignUpRequest signUpRequest);
  Future<Either<ApiException, bool>> verifyOtp(OtpRequest otpRequest);

}


class AuthServiceImpl extends AuthService{

  final AuthApi authApi;
  final TokenRepository tokenRepository;
  AuthServiceImpl({required this.authApi, required this.tokenRepository});


  @override
  Future<Either<ApiException, bool>> login(LoginRequest loginRequest) async{
    final response = await authApi.login(loginRequest);
    return response.fold((failure) {
       return Left(failure);
    }, (loginResponse) async {

      await tokenRepository.saveUserCredentials(
          loginResponse.accessToken!, null, loginResponse.refreshToken!);
      // log("access token: ${loginResponse.accessToken!}");
      // final response = await authApi.getUserData();
      return response.fold((failure) {
        return Left(failure);
      }, (getUserDataResponse) async {
        await tokenRepository.saveUserCredentials(
            loginResponse.accessToken!,
            null,
            loginResponse.refreshToken!);

        return const Right(true);
      });
    });
  }

  @override
  Future<Either<ApiException, bool>> signup(SignUpRequest signUpRequest) async{
    final response = await authApi.signUp(signUpRequest);
    return response.fold((failure){
      return Left(failure);
    }, (signUpResponse) async{
    log("user: ${signUpResponse.toJson()}");
    final otp = signUpResponse.responseData?.otp;
    prefs.remove("otp");
    prefs.setInt("otp", otp!);
    //prefs.setString('otp', response.responseData?.otp as String);
      final loginResponse = await authApi.login(
        LoginRequest(email: signUpRequest.email, password: signUpRequest.password,),);
      return loginResponse.fold((failure){
        return Left(failure);
      }, (loginResponse) async{
        await tokenRepository.saveUserCredentials(
            loginResponse.accessToken!,
            signUpResponseFromJson(jsonEncode(signUpResponse)),
            loginResponse.refreshToken!);
        log("Signing up and sending accessToken: ${tokenRepository.getUserCredentials().accessToken}");
        return const Right(true);
      });
    });
  }

  @override
  Future<Either<ApiException, bool>> verifyOtp(OtpRequest otpRequest) async{
    final response = await authApi.verifyOtp(otpRequest);
    return response.fold((failure){
      return Left(failure);
    }, (verifyOtpResponse) async{

      log("verifyOtpResponse: $verifyOtpResponse");
      return const Right(true);
    }
    //         (verifyOtpResponse) async{
    //   log("verifyOtpResponse: $verifyOtpResponse");
    //   if(verifyOtpResponse == 'Confirmed') {
    //     return const Right(true);
    //   } else{
    //     return Left(ApiException(verifyOtpResponse));
    //   }
    // }
    );
  }}




// Future addProfilePic(email, profilePic) async {
//   String message = '';
//   final url =
//   Uri.parse('https://myroute-aqn5.onrender.com/api/v1/users/update-account');
//   final response = await http.patch(
//     url,
//     headers: {
//       'Content-Type': 'application/json',
//     },
//     body: jsonEncode({
//       'email': email,
//       'profilePic':profilePic
//
//     }),
//   );
//   if (response.statusCode == 200) {
//     message = 'updated';
//     return message;
//   }
//   else {
//     message = response.body;
//     return message;
//   }
// }