class LoginRequest{


  LoginRequest({required this.email, required this.password});

  final String email;
  final String password;

  @override

  Map<String, dynamic> toJson(){
    return {
      'email': email,
      'password': password,

    };
  }
}