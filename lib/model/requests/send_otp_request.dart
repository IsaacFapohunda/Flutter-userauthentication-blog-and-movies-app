class OtpRequest{

  OtpRequest({required this.otp});

  final int otp;

  Map<String, dynamic> toJson(){
    return {
      'otp': otp,
    };
  }

}