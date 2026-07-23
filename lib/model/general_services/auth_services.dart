import 'dart:convert';
import 'dart:developer';

import 'package:either_dart/either.dart';

import 'package:springboot_flutter_bloggingapp/model/data/token_repository.dart';
import 'package:springboot_flutter_bloggingapp/model/response/sign_up_response.dart';
//import 'package:springboot_flutter_bloggingapp/model/services/auth_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../requests/login_request.dart';
import '../requests/send_otp_request.dart';
import '../requests/sign_up_request.dart';
import 'api_client.dart';
import 'auth_api.dart';
import 'exceptions.dart';


final authServiceProvider = Provider<AuthServiceImpl>((ref) {
  final tokenRepository = TokenRepositoryImpl();
  final client = ApiClient(tokenRepository: tokenRepository) ;
  final authApi = AuthAPiImpl(client);
  return AuthServiceImpl(authApi: authApi, tokenRepository: tokenRepository);

});


///this is our blueprint like job description. What to expect in the class and doesnt write the code
abstract class AuthService {
  Future<Either<ApiException, bool>> login(LoginRequest loginRequest);
  Future<Either<ApiException, bool>> signup(SignUpRequest signUpRequest);
  Future<Either<ApiException, bool>> verifyOtp(OtpRequest otpRequest);

}

///return raw string
class AuthServiceImpl extends AuthService{

  final AuthApi authApi;
  final TokenRepository tokenRepository;
  AuthServiceImpl({required this.authApi, required this.tokenRepository});


  @override
  Future<Either<ApiException, bool>> login(LoginRequest loginRequest) async{
    final response = await authApi.login(loginRequest);
    return response.fold((failure) {
      //now when we communicate with the server it might throw and uncontrollable exception
      //but when its successful response gotten, theres no error or exception anymore
      //but to perform other services within our app, we might have to deal with our own custom exception called failure.
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
      final loginResponse = await authApi.login(
        LoginRequest(email: signUpRequest.email, password: signUpRequest.password,),);
      return loginResponse.fold((failure){
        return Left(failure);
      }, (loginResponse) async{
        await tokenRepository.saveUserCredentials(
            loginResponse.accessToken!,
            signUpResponseFromJson(jsonEncode(signUpResponse)),
            loginResponse.refreshToken!);
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
      if(verifyOtpResponse == 'Confirmed') {
        return const Right(true);
      } else{
        return Left(ApiException(verifyOtpResponse));
      }
    }
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