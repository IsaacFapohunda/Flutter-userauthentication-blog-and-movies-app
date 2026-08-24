import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:springboot_flutter_bloggingapp/model/general_services/api_result.dart';
import 'package:springboot_flutter_bloggingapp/model/general_services/auth_exports.dart';
import 'package:springboot_flutter_bloggingapp/model/requests/login_request.dart';

import '../requests/send_otp_request.dart';
import '../requests/sign_up_request.dart';
import 'package:springboot_flutter_bloggingapp/model/state/auth_state.dart';


///better use async provider tho

//this class handles all auth notifier and state
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref){
  return AuthNotifier(ref.read(authServiceProvider));
});

class AuthNotifier extends StateNotifier<AuthState>{
   final AuthService authService;

   AuthNotifier(this.authService) : super(AuthState.initial());


   bool isValidEmail(String email) {
     final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
     return emailRegex.hasMatch(email);
   }


   int countdown = 59;
   late Timer timer;
   bool coountDownOver = false;



   void startCountdown() {
     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
       if (countdown > 0) {
         countdown--;
       } else {
         coountDownOver = true;
         timer.cancel();
       }
     });
   }


   void resetValidation(){
     state = state.copyWith(
       firstNameError: false,
       emailError: false,
       passwordError: false,
       confirmPasswordError: false,
       errorMessage: '',
       wrongOtpCodeError: false,
     );
   }



   Future<void> signUp({
     required String firstName,
     required String email,
     required String password,
     required String confirmPassword,
     //required bool hasInternet
}) async{

     resetValidation();

     if(firstName.trim().isEmpty){
       state = state.copyWith(
         firstNameError: true,
       );
       return;
     }
     if(password.isEmpty){
       state =state.copyWith(
         passwordError: true,
       );
       return;
     }
     if(password != confirmPassword){
       state = state.copyWith(
         confirmPasswordError: true,
       );
       return;
     }
     if(!isValidEmail(email.trim())){
       state = state.copyWith(
         emailError: true,
       );
       return;
     }

     state = state.copyWith(
       request: ApiResult.loading("Signing up..."),
     );


     final response = await authService.signup(
       SignUpRequest(
           email: email.trim(),
           password: password.trim(),
           firstName: firstName.trim()));

     response.fold(
             (failure){
               state = state.copyWith(
                 request: ApiResult.error(failure.message),
               );

     },
             (success){
               state = state.copyWith(
                 request: ApiResult.success(success),
               );
         }
     );

     }


     Future<void> verifyOtp({required int? otp,
       required String email}) async{
     resetValidation();

     if(otp == null){
       state = state.copyWith(
         wrongOtpCodeError: true,
       );
       return;
     }

     state = state.copyWith(
       request: ApiResult.loading("Verifying Otp"),
     );
     final response = await authService.verifyOtp(OtpRequest(otp: otp, email: email));
     response.fold((failure){
       state = state.copyWith(
         request: ApiResult.error(failure.message),
       );
     }, (success){
       state = state.copyWith(
         request: ApiResult.success(success),
       );
     });

     }


   Future<void> logIn({
     required String email,
     required String password,
   }) async{

     resetValidation();

     if(password.isEmpty){
       state =state.copyWith(
         passwordError: true,
       );
       return;
     }

     if(!isValidEmail(email.trim())){
       state = state.copyWith(
         emailError: true,
       );
       return;
     }

     state = state.copyWith(
       request: ApiResult.loading("Logging in..."),
     );

     final response = await authService.login(

         LoginRequest(
             email: email.trim(),
             password: password.trim(),
         ));

     response.fold(
             (failure){
           state = state.copyWith(
             request: ApiResult.error(failure.message),
           );

         },
             (success){
           state = state.copyWith(
             request: ApiResult.success(success),
           );
         }
     );

   }



   void resetRequestState(){
     state = state.copyWith(
       request: ApiResult.idle(),
     );
   }



}