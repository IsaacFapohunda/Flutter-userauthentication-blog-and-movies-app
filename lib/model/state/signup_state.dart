import 'package:springboot_flutter_bloggingapp/model/general_services/api_result.dart';

class SignupState{
  final ApiResult<bool> request;
  final bool firstNameError;
  final bool emailError;
  final bool passwordError;
  final bool confirmPasswordError;
  final String errorMessage;

  const SignupState({
    required this.request,
    this.firstNameError = false,
    this.emailError = false,
    this.passwordError = false,
    this.confirmPasswordError = false,
    this.errorMessage = ''
});

  factory SignupState.initial(){
    return SignupState(request: ApiResult.idle(),);
  }

  SignupState copyWith({
    ApiResult<bool>? request,
    bool? firstNameError,
    bool? emailError,
    bool? passwordError,
    bool? confirmPasswordError,
    String? errorMessage,
}) {
    return SignupState(
        request: request ?? this.request,
      firstNameError: firstNameError ?? this.firstNameError,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      confirmPasswordError:
      confirmPasswordError ?? this.confirmPasswordError,
      errorMessage: errorMessage ?? this.errorMessage,

    );
}

}