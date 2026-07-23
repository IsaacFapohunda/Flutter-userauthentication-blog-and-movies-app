// import 'package:flutter/material.dart';
// import 'package:myroute/constants/app_image.dart';
// import '../../../../constants/app_color.dart';
// import '../../SignUp/views/Sign_up.dart';
// import 'package:myroute/flows/registration/Reg_global_File/custom_text_field.dart';
// import 'package:myroute/flows/registration/Reg_global_File/App_button.dart';
// import 'package:myroute/flows/registration/Reg_global_File/back_button.dart';
//
// class ForgetPassword extends StatefulWidget {
//   ForgetPassword({super.key});
//
//   @override
//   State<ForgetPassword> createState() => _ForgetPasswordState();
// }
//
// class _ForgetPasswordState extends State<ForgetPassword> {
//
//   bool emailError = false;
//   TextEditingController emailController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: SafeArea(
//             child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             const SizedBox(
//               height: 30,
//             ),
//
//
//             Container(
//               height: 40,
//               width: 261,
//               child: Row(
//                 children: [
//
//                   AppBackButton(),
//                   const SizedBox(
//                     width: 75,
//                   ),
//                   Image.asset(appLogo2,
//                     height: 25,
//                   ),
//
//
//                 ],
//               ),
//             ),
//
//
//             const SizedBox(
//               height: 20,
//             ),
//
//             const Text(
//               "Reset Password",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Text("Enter your registered E-mail to receive a rest link"),
//             const SizedBox(
//               height: 30,
//             ),
//             mytextField(controller: emailController, label: "E-mail", error: 'Enter a valid email', ispassword: false, errorCondition: emailError,),
//
//             const SizedBox(
//               height: 30,
//             ),
//             AppButton(textColor: white,
//               onPressed: () {},
//               label: "Reset",
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//              Center(
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const SignUpScreen(),
//                       ));
//                 },
//                 child: RichText(
//                     text: const TextSpan(
//                       children: [
//                         TextSpan(
//                           text: 'Or ',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black,
//                           ),
//                         ),
//
//                         TextSpan(
//                           text: 'create a new account',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                             decoration: TextDecoration.underline
//                           )
//                         )
//                       ]
//                     )),
//               ),
//
//             ),
//           ],
//         ),),
//       ),
//     );
//   }
// }