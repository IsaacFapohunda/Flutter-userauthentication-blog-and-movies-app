class SignUpRequest{


  SignUpRequest({required this.email, required this.password, required this.firstName});

  final String email;
  final String password;
  final String firstName;

  @override

  Map<String, dynamic> toJson(){
    return {
      'email': email,
      'password': password,
      'firstName': firstName
    };
  }
}