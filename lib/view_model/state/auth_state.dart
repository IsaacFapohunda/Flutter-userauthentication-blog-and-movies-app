import 'package:springboot_flutter_bloggingapp/model/general_services/api_result.dart';

class AuthState{
  final ApiResult<bool> request;
  final bool firstNameError;
  final bool emailError;
  final bool passwordError;
  final bool confirmPasswordError;
  final String errorMessage;
  final bool wrongOtpCodeError;


  const AuthState({
    required this.request,
    this.firstNameError = false,
    this.emailError = false,
    this.passwordError = false,
    this.confirmPasswordError = false,
    this.errorMessage = '',
    this.wrongOtpCodeError = false,
});

  factory AuthState.initial(){
    return AuthState(request: ApiResult.idle(),);
  }

  AuthState copyWith({
    ApiResult<bool>? request,
    bool? firstNameError,
    bool? emailError,
    bool? passwordError,
    bool? confirmPasswordError,
    String? errorMessage,
    bool? wrongOtpCodeError,
}) {
    return AuthState(
        request: request ?? this.request,
      firstNameError: firstNameError ?? this.firstNameError,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      confirmPasswordError:
      confirmPasswordError ?? this.confirmPasswordError,
      errorMessage: errorMessage ?? this.errorMessage,
      wrongOtpCodeError: wrongOtpCodeError ?? this.wrongOtpCodeError

    );
}

}