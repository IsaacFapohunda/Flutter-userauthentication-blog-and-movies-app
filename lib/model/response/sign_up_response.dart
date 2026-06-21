

import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

class SignUpResponse {
  bool? success;
  String? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  SignUpResponse(
      {this.success,
        this.responseCode,
        this.responseMessage,
        this.responseData});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    responseData = json['responseData'] != null
        ? new ResponseData.fromJson(json['responseData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['responseCode'] = responseCode;
    data['responseMessage'] = responseMessage;
    if (responseData != null) {
      data['responseData'] = responseData!.toJson();
    }
    return data;
  }
}

class ResponseData {
  String? id;
  String? email;
  String? firstName;
  List<dynamic>? roles;
  bool? enabled;
  int? otp;

  ResponseData({this.id, this.email, this.firstName, this.roles, this.enabled, this.otp});

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    email = json['email'] ?? '';
    firstName = json['firstName'] ?? '';
    if (json['roles'] != null) {
      roles = <dynamic>[];
      json['roles'].forEach((v) {
        roles!.add(roles);
      });
    }
    enabled = json['enabled'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['firstName'] = firstName;
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    data['enabled'] = enabled;
    data['otp'] = otp;
    return data;
  }
}