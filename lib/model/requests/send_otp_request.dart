class OtpRequest{

  OtpRequest({required this.otp, required this.email});

  final int otp;

  final String email;

  Map<String, dynamic> toJson(){
    return {
      'otp': otp,
      'email': email
    };
  }

}