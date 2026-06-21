import 'dart:convert';

class LoginResponse{
  LoginResponse({this.refreshToken, this.accessToken});

  String? refreshToken;
  String? accessToken;


  factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    refreshToken: json["refresh"],
    accessToken: json["access"],
  );

  Map<String, dynamic> toJson() => {
    "refresh_token": refreshToken,
    "access_token": accessToken,
  };

}