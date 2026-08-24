import 'package:springboot_flutter_bloggingapp/model/response/sign_up_response.dart';

class UserCredentials {
  UserCredentials(
      {required this.accessToken, required this.user, required this.refreshToken});
  final String? accessToken;
  final SignUpResponse? user;
  final String? refreshToken;

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'user': user?.toJson(),
      'refreshToken': refreshToken
    };
  }

  factory UserCredentials.fromJson(Map<String, dynamic> json) {
    return UserCredentials(
      accessToken: json['accessToken'],
      refreshToken: json["refreshToken"],
      user: json['user'] == null
          ? null
          : SignUpResponse.fromJson(
        json['user'],
      ),
    );
  }

  UserCredentials copyWithToken(String? accessToken, String? refreshToken) {
    return UserCredentials(
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: user,
    );
  }

  UserCredentials copyWithUser(SignUpResponse? user) {
    return UserCredentials(
        accessToken: accessToken, user: user, refreshToken: refreshToken);
  }
}