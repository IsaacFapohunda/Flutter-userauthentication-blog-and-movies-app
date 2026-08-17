import 'dart:convert';

class VerifyOtpResponse{
  VerifyOtpResponse({this.success, this.message});

  bool? success;
  String? message;


  factory VerifyOtpResponse.fromRawJson(String str) => VerifyOtpResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) => VerifyOtpResponse(
    success: json['success'],
    message: json['message'],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };

}