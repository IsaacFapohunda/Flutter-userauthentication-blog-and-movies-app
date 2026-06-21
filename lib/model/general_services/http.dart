// import 'dart:convert';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// final userAuthProvider = Provider<UserAuth>((ref) => UserAuth());
//
// class UserAuth {
//   userSignUp(email, password, firstName) async {
//     String message = 'Something went wrong';
//     final url =
//     Uri.parse('https://ca48-197-210-55-100.ngrok-free.app/api/v1/role_base/auth/create');
//
//     https://myroute-server-side.onrender.com/api/v1/auth/register
//
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'email': email,
//         'password': password,
//         'firstName': firstName,
//
//         //'ninDocument': ninDoc
//       }),
//
//     );
//     if (response.statusCode == 200) {
//       message = 'Sign Up Successful';
//
//       final responseData = json.decode(response.body);
//       print(responseData);
//
//       return message;
//     }
//     if (response.statusCode == 403) {
//       message = 'This Email has been registered';
//       return message;
//     } else {
//       message = response.body;
//
//       return message;
//     }
//   }
//
// }