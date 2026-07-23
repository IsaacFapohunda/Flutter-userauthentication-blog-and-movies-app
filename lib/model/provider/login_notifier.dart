import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:springboot_flutter_bloggingapp/model/general_services/api_result.dart';
import 'package:springboot_flutter_bloggingapp/model/general_services/auth_exports.dart';
import 'package:springboot_flutter_bloggingapp/model/general_services/endpoints_url.dart';
import 'package:springboot_flutter_bloggingapp/model/requests/login_request.dart';

//this is to create stateNotifier for the api result alone, therefore different demands
final loginProvider = StateNotifierProvider<LoginNotifier, ApiResult<bool>>((ref){
  return LoginNotifier(ref.read(authServiceProvider));
});

class LoginNotifier extends StateNotifier<ApiResult<bool>>{
  final AuthService authService;

  LoginNotifier(this.authService) : super(ApiResult.idle());

  Future<void> login(LoginRequest request) async{
    state = ApiResult.loading("Signing in...");

    final response = await authService.login(request);
    response.fold((failure){
      state = ApiResult.error(failure.message);
    },
        (success){
      state = ApiResult.success(success);
        }
    );
  }
}