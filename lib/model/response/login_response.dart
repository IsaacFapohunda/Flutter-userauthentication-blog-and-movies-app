import 'dart:convert';
// success": true,
// "responseCode": "200",
// "responseMessage: "Successful Login",
class LoginResponse{
  LoginResponse({this.refreshToken, this.accessToken});

  String? refreshToken;
  String? accessToken;


  factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    refreshToken: json['responseData']['refresh_token'],
    accessToken: json['responseData']["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "refresh_token": refreshToken,
    "access_token": accessToken,
  };

}