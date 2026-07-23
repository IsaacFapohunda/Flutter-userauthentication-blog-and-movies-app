import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:springboot_flutter_bloggingapp/main.dart';
import '../response/sign_up_response.dart';
import '../response/user_credentials.dart';
import 'dart:convert';


final tokenRepositoryProvider = Provider<TokenRepository>((ref) => TokenRepositoryImpl());

abstract class TokenRepository{

  UserCredentials getUserCredentials();

  Future<void> saveUserCredentials(
      String accessToken, SignUpResponse? user, String refreshToken);

  Future<void> deleteUserCredentials();

  Future<void> updateUserCredentials(UserCredentials accessToken);

}




class TokenRepositoryImpl implements TokenRepository{


  @override
  UserCredentials getUserCredentials() {
    return _getTokenObjectFromPrefs();
  }


  @override
  Future<void> saveUserCredentials(String accessToken, SignUpResponse? user, String refreshToken) async{
    final userCredentials = UserCredentials(user:user, refreshToken:refreshToken, accessToken: accessToken);
    String encodeUserCredentials = json.encode(userCredentials);
    await prefs.setString("userCredentials", encodeUserCredentials);
  }


  UserCredentials  _getTokenObjectFromPrefs() {

    try{
      final encodedUserCredentials = prefs.getString('userCredentials');
      if(encodedUserCredentials == null){
        return UserCredentials(user: null, refreshToken: null, accessToken: '');
      }
      final userCredentials = UserCredentials.fromJson(const JsonDecoder().convert(encodedUserCredentials));
      return userCredentials;
    } catch(err, stack){
      log(err.toString());
      log(stack.toString());
      return UserCredentials(accessToken: null, user: null, refreshToken: null);

    }
  }

  @override
  Future<void> deleteUserCredentials()async {
   prefs.remove('userCredentials');
  }



  /* to retrieve
  String enc... = prefs.getString("usercred");
  Map<String, dynamic> decodedToMap =  json.decode(enc..)

   */

  @override
  Future<void> updateUserCredentials(UserCredentials userCredentials) async {
    prefs.setString('userCredentials', const JsonEncoder().convert(userCredentials.toJson()));
  }


  // Future<void> updateUser(SignUpResponse getUserDataResponse) async {
  //   final userCred = _userCredentials.copyWithUser(getUserDataResponse);
  //   await tokenRepository.updateUserCredentials(userCred);
  // }
  //
  // Future<void> logout() async {
  //   await tokenRepository
  //       .updateUserCredentials(_userCredentials.copyWithToken(null, null));
  //   await tokenRepository.deleteUserCredentials();
  //   // await refreshUser();
  //   mixpanel.track("USER LOGGED OUT", properties: {});
  //   Get.offAll(() => const LoginScreen());
  // }

}