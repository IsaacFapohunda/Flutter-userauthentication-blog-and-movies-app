import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:springboot_flutter_bloggingapp/model/general_services/api_result.dart';
import 'package:springboot_flutter_bloggingapp/model/general_services/auth_exports.dart';

import '../requests/send_otp_request.dart';
import '../requests/sign_up_request.dart';
import 'package:springboot_flutter_bloggingapp/model/state/signup_state.dart';

final signUpProvider = StateNotifierProvider<SignUpNotifier, SignupState>((ref){
  return SignUpNotifier(ref.read(authServiceProvider));
});

class SignUpNotifier extends StateNotifier<SignupState>{
   final AuthService authService;

   SignUpNotifier(this.authService) : super(SignupState.initial());


   bool isValidEmail(String email) {
     final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
     return emailRegex.hasMatch(email);
   }

   void resetValidation(){
     state = state.copyWith(
       firstNameError: false,
       emailError: false,
       passwordError: false,
       confirmPasswordError: false,
       errorMessage: '',
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

     //Api exception already handle this
     // if(!hasInternet){
     //   state = state.copyWith(
     //     request: ApiResult.error("No internet connection"),
     //   );
     //   return;
     // }
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


     Future<void> verifyOtp(OtpRequest request) async{
     state = state.copyWith(
       request: ApiResult.loading("Verifying Otp"),
     );
     final response = await authService.verifyOtp(request);
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


   void resetRequestState(){
     state = state.copyWith(
       request: ApiResult.idle(),
     );
   }



}