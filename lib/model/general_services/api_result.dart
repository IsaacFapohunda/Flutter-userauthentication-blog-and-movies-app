import 'package:flutter/material.dart';

enum Status { idle, loading, success, error }

class ApiResult<T> {
  ApiResult({
    this.message = 'Unknown error occurred',
    this.data,
    this.status,
  });

  ApiResult.idle() : status = Status.idle;
  ApiResult.loading(this.message) : status = Status.loading;
  ApiResult.success(this.data) : status = Status.success;
  ApiResult.error(this.message) : status = Status.error;


  Status? status;
  T? data;
  String message = '';

  bool isInitialState() => !(status == Status.success && data != null);

  @override
  String toString() {
    return 'Status : $status \n Message : $message \n Data : $data';
  }

  bool get isIdle => status == Status.idle;
  bool get isLoading => status == Status.loading;
  bool get isSuccess => status == Status.success;
  bool get isError => status == Status.error;

  Widget when({
    required Widget Function(T data) done,
    required Widget Function(String message) error,
    required Widget Function() loading,
  }) {
    switch (status) {
      case Status.idle:
        {
          return const SizedBox.shrink();
        }
      case Status.loading:
        {
          return loading();
        }
      case Status.success:
        {
          return done(data as T);
        }
      case Status.error:
        {
          return error(message);
        }
      default:
        return const SizedBox.shrink();
    }
  }
}

class GenericResponse {
  GenericResponse({
    required this.status,
    required this.message,
  });

  GenericResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  late final String status;
  late final String message;
}