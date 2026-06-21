// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:springboot_flutter_bloggingapp/view/screens/Signup_screen.dart';
// import 'package:springboot_flutter_bloggingapp/view/utilities/app_image.dart';
// import 'package:springboot_flutter_bloggingapp/view/utilities/app_color.dart';
// import 'package:springboot_flutter_bloggingapp/view/utilities/textstyle.dart';
//
// import '../../model/general_services/http.dart';
// import '../../model/internet/internet.dart';
// import '../utilities/app_button.dart';
// import '../widgets/custom_text_field.dart';
// import 'Forgot_password_screen.dart';
//
//
//
//
//
//
// class LoginScreen extends ConsumerStatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   ConsumerState<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends ConsumerState<LoginScreen> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordCcontroller = TextEditingController();
//   bool isLoading = false;
//   bool emailError = false;
//   bool passwordError = false;
//   String firstName = '';
//   String lastName = '';
//   String token = '';
//   String isVerified = '';
//
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordCcontroller.dispose();
//     super.dispose();
//   }
//
//   void initState() {
//     super.initState();
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final connectivityState = ref.watch(internetProvider);
//     Size size = MediaQuery.of(context).size;
//     Size height = MediaQuery.of(context).size;
//
//     final loginref = ref.watch(userAuthProvider);
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//                 height: 250,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: const BoxDecoration(
//                     color: kPrimaryColor,
//                     image: DecorationImage(
//                       image: AssetImage(
//                         kHumanresources,
//                       ),
//                     )),
//                 child: Center(
//                   child: Image.asset(
//                     kHumanresources,
//                     width: 100,
//                     height: 100,
//                   ),
//                 )),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   Text(
//                     "Welcome back, Jennifer",
//                     style: kTextStyle1(height),
//                   ),
//                   const Text('Please log in to continue'),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   mytextField.CustomTextFieldd(
//                       errorCondition: emailError,
//                       error: 'Enter a valid email',
//                       controller: emailController,
//                       label: "Email"),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   mytextField.CustomTextFieldd(
//                     errorCondition: passwordError,
//                     error: 'Incorrect password',
//                     label: "Password",
//                     isobsure: true,
//                     controller: passwordCcontroller,
//                     ispassword: true,
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const ForgetPassword(),
//                           ));
//                     },
//                     child: Container(
//                       alignment: Alignment.bottomRight,
//                       child: const Text(
//                         "Forgot password?",
//                         style: TextStyle(
//                           fontSize: 15,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   isLoading
//                       ? Center(
//                       child: LoadingAnimationWidget.inkDrop(
//                           color: kPrimaryColor, size: 25))
//                       : AppButton(
//                     label: "Login",
//                     onPressed: () async {
//                       print("££33");
//                       if (connectivityState.status ==
//                           ConnectivityStatus.disconnected) {
//                         WidgetsBinding.instance.addPostFrameCallback((_) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text('No internet connection'),
//                             ),
//                           );
//                         });
//                       } else {
//                         setState(() {
//                           isLoading = true;
//                         });
//                         if (emailController.text.isNotEmpty &&
//                             passwordCcontroller.text.isNotEmpty) {
//                           String message = await loginref.userLogin(
//                               emailController.text,
//                               passwordCcontroller.text);
//
//                           if (message == 'LoggedIn') {
//                             setState(() {
//                               isLoading = false;
//                             });
//                             SharedPreferences prefs =
//                             await SharedPreferences.getInstance();
//
//                             setState(() {
//                               firstName = prefs.getString('firstName')!;
//                               lastName = prefs.getString('lastName')!;
//                               token = prefs.getString('token')!;
//                               //isVerified = prefs.getString('isVerified')!;
//                             });
//                             final String name = '$firstName $lastName';
//                             if (isVerified == false) {
//                               if (kDebugMode) {
//                                 print('Not verified yet');
//                               }
//                               // Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //       builder: (context) =>
//                               //           VerificationScreen(
//                               //               email: emailController.text),
//                               //     ));
//                               setState(() {
//                                 isLoading = false;
//                               });
//                             }
//                             else {
//                               // Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //       builder: (context) =>
//                               //          // CarDetailsReg(),
//                               //     ));
//
//
//                               // Navigator.pushReplacement(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //       builder: (context) =>
//                               //            PassengerHomeScreen(name:name),
//                               //     ));
//
//                               setState(() {
//                                 isLoading = false;
//                               });
//                             }
//                           } else {
//                             WidgetsBinding.instance
//                                 .addPostFrameCallback((_) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       backgroundColor: Colors.red,
//                                       content: Text(message,
//                                           textAlign: TextAlign.center,
//                                           style: const TextStyle(
//                                               fontSize: 16))));
//                             });
//                             setState(() {
//                               isLoading = false;
//                             });
//                           }
//                         } else {
//                           setState(() {
//                             isLoading = false;
//                           });
//                           WidgetsBinding.instance
//                               .addPostFrameCallback((_) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 backgroundColor: Colors.red,
//                                 content: Text(
//                                   'Fill up all fields',
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             );
//                           });
//                         }
//                       }
//                     },
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Divider(),
//                       Text("Or Log In with"),
//                       Divider(
//                         thickness: 10,
//                         height: 10,
//                         color: Colors.black,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Don’t have an account?"),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const SignupScreen(),
//                           ));
//                         },
//                         child: const Text(
//                           " Sign up",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }