import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:springboot_flutter_bloggingapp/main.dart';
//import 'package:springboot_flutter_bloggingapp/model/services/endpoints_url.dart';
//import 'package:springboot_flutter_bloggingapp/model/services/exceptions.dart';
import 'package:springboot_flutter_bloggingapp/model/requests/login_request.dart';
import 'package:either_dart/either.dart';
import 'package:springboot_flutter_bloggingapp/model/response/sign_up_response.dart';
import 'api_client.dart';
import 'endpoints_url.dart';
import '../requests/signup_request.dart';
import '../response/login_response.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

import 'exceptions.dart';



abstract class AuthApi{
  Future<Either<ApiException, LoginResponse>> login(LoginRequest loginRequest);
  Future<Either<ApiException, SignUpResponse>> signUp(SignUpRequest signUpRequest);

}
class AuthAPiImpl extends AuthApi{

  AuthAPiImpl(this.client);
  final ApiClient client;

  //final TokenRepository _tokenRepository = Get.find();


  @override
  Future<Either<ApiException, LoginResponse>> login(LoginRequest loginRequest) async{

    try{
      // String message = 'Something went wrong';
      //final url = Uri.parse(Endpoints.baseUrl+Endpoints.login);
      final httpResponse = await client.post(Endpoints.login, data: loginRequest.toJson());
      debugPrint("token ${httpResponse.data}");
    final response = LoginResponse.fromJson(httpResponse.data);
    //i will use mixpanel, a real time tracking sdk
    // to monitor the amount of people logged into the app.
    //this gives me info to better work on

    // mixpanel.track("USER LOGGED IN SUCCESSFULLY", properties: {
    // "url": httpResponse.requestOptions.uri,
    // "method": httpResponse.requestOptions.method,
    // "status code": httpResponse.statusCode,
    // "status message": httpResponse.statusMessage,
    // });
    return Right(response);
    } catch(e){
    debugPrint(e.toString());
    //note debugprint prints additional information to the console
    // mixpanel.track("USER UNABLE TO LOG IN", properties: {
    // "url": Endpoints.login,
    // "error": e,
    // });
    return Left(ApiException(e.toString()));
    }
  }



  @override
  Future<Either<ApiException, SignUpResponse>> signUp(
      SignUpRequest signUpRequest) async {
    print('here in auth_api');
    try {
      final httpResponse =
      await client.post(Endpoints.signup, data: signUpRequest.toJson());
      print(httpResponse);
      debugPrint(" response: ${jsonEncode(httpResponse.data)}");
      final response = signUpResponseFromJson(jsonEncode(httpResponse.data));
      debugPrint("res ${response.responseData}");

     // lets not track data now
      // mixpanel.track("USER SIGNED UP SUCCESSFULLY", properties: {
      //   "url": httpResponse.requestOptions.uri,
      //   "method": httpResponse.requestOptions.method,
      //   "status code": httpResponse.statusCode,
      //   "status message": httpResponse.statusMessage,
      // });
      return Right(response);
    } catch (err) {
      debugPrint(err.toString());

      // mixpanel.track("USER UNABLE TO SIGN UP", properties: {
      //   "url": Endpoints.signup,
      //   "error": err,
      // });
      return Left(ApiException(err.toString()));
    }
  }





}