// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// // import 'package:myroute/flows/registration/Add_ProficPic/views/add_profile_pic.dart';
// // import 'package:myroute/flows/registration/Reg_global_File/globalFile.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import '../../../../constants/app_color.dart';
// // import '../../../../constants/app_image.dart';
// // import '../../../../constants/textstyle.dart';
// // import '../../../../services/user_authentication.dart';
// // import '../../AddPayment/views/addPayment.dart';
// import '../utilities/app_button.dart';
// import '../utilities/app_color.dart';
// import '../utilities/back_button.dart';
// import '../utilities/textstyle.dart';
//
// class VerificationScreen extends ConsumerStatefulWidget {
//   final String email;
//   const VerificationScreen({super.key, required this.email});
//
//   @override
//   ConsumerState<VerificationScreen> createState() =>
//       _VerificationScreenConsumerState();
// }
//
//
// class _VerificationScreenConsumerState
//     extends ConsumerState<VerificationScreen> {
//   int countdown = 59;
//   late Timer timer;
//   bool coountDownOver = false;
//   @override
//   void initState() {
//     super.initState();
//     startCountdown();
//   }
//
//
//   void startCountdown() {
//     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (countdown > 0) {
//         setState(() {
//           countdown--;
//         });
//       } else {
//         setState(() {
//           coountDownOver = true;
//         });
//         timer.cancel();
//       }
//     });
//   }
//
//   String code ='';
//   String wrongCode = '';
//   bool isLoading = false;
//   String accessCode = "1255";
//
//   @override
//   Widget build(BuildContext context) {
//     final verificationref = ref.watch(userAuthProvider);
//     return Scaffold(
//       appBar: AppBar(
//         leading: AppBackButton(),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         centerTitle: true,
//         title: Image.asset(
//           appLogo2,
//           width: 120,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Verify your new account ",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Text("Enter the 6-digit code sent to you at ${widget.email}"),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: grey5,
//                     ),
//                     width: 50,
//                     child: Center(
//                         child: TextFormField(
//                           onChanged: (value) {
//                             setState(() {
//                               String nevalue = ("$code$value");
//                               code = nevalue;
//                             });
//                             if (value.length == 1) {
//                               FocusScope.of(context).nextFocus();
//                             }
//                           },
//                           decoration: const InputDecoration(
//                             border: InputBorder.none,
//                           ),
//                           textAlign: TextAlign.center,
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(1),
//                             FilteringTextInputFormatter.digitsOnly
//                           ],
//                         )),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: grey5,
//                     ),
//                     width: 50,
//                     child: Center(
//                         child: TextFormField(
//                           onChanged: (value) {
//                             setState(() {
//                               String nevalue = ("$code$value");
//
//                               code = nevalue;
//                             });
//                             if (value.length == 1) {
//                               FocusScope.of(context).nextFocus();
//                             } else {
//                               if (value.isEmpty) {
//                                 FocusScope.of(context).previousFocus();
//                               }
//                             }
//                           },
//                           onSaved: (newValue3) {},
//                           decoration: const InputDecoration(
//                             border: InputBorder.none,
//                           ),
//                           textAlign: TextAlign.center,
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(1),
//                             FilteringTextInputFormatter.digitsOnly
//                           ],
//                         )),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: grey5,
//                     ),
//                     width: 50,
//                     child: Center(
//                         child: TextFormField(
//                           onChanged: (value) {
//                             setState(() {
//                               String nevalue = ("$code$value");
//
//                               code = nevalue;
//                             });
//                             if (value.length == 1) {
//                               FocusScope.of(context).nextFocus();
//                             } else {
//                               if (value.isEmpty) {
//                                 FocusScope.of(context).previousFocus();
//                               }
//                             }
//                           },
//                           onSaved: (newValue3) {},
//                           decoration: const InputDecoration(
//                             border: InputBorder.none,
//                           ),
//                           textAlign: TextAlign.center,
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(1),
//                             FilteringTextInputFormatter.digitsOnly
//                           ],
//                         )),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: grey5,
//                     ),
//                     width: 50,
//                     child: Center(
//                         child: TextFormField(
//                           onChanged: (value) {
//                             setState(() {
//                               String nevalue = ("$code$value");
//
//                               code = nevalue;
//                             });
//                             if (value.length == 1) {
//                               FocusScope.of(context).nextFocus();
//                             } else {
//                               if (value.isEmpty) {
//                                 FocusScope.of(context).previousFocus();
//                               }
//                             }
//                           },
//                           onSaved: (newValue3) {},
//                           decoration: const InputDecoration(
//                             border: InputBorder.none,
//                           ),
//                           textAlign: TextAlign.center,
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(1),
//                             FilteringTextInputFormatter.digitsOnly
//                           ],
//                         )),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: grey5,
//                     ),
//                     width: 50,
//                     child: Center(
//                         child: TextFormField(
//                           onChanged: (value) {
//                             setState(() {
//                               String nevalue = ("$code$value");
//
//                               code = nevalue;
//                             });
//                             if (value.length == 1) {
//                               FocusScope.of(context).nextFocus();
//                             } else {
//                               if (value.isEmpty) {
//                                 FocusScope.of(context).previousFocus();
//                               }
//                             }
//                           },
//                           onSaved: (newValue3) {},
//                           decoration: const InputDecoration(
//                             border: InputBorder.none,
//                           ),
//                           textAlign: TextAlign.center,
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(1),
//                             FilteringTextInputFormatter.digitsOnly
//                           ],
//                         )),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: grey5,
//                     ),
//                     width: 50,
//                     child: Center(
//                         child: TextFormField(
//                           onChanged: (value) {
//                             setState(() {
//                               String nevalue = ("$code$value");
//                               code = nevalue;
//                             });
//                             if (value.length == 1) {
//                               FocusScope.of(context).nextFocus();
//                             } else {
//                               if (value.isEmpty) {
//                                 FocusScope.of(context).previousFocus();
//                               }
//                             }
//                           },
//                           onSaved: (newValue3) {},
//                           decoration: const InputDecoration(
//                             border: InputBorder.none,
//                           ),
//                           textAlign: TextAlign.center,
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(1),
//                             FilteringTextInputFormatter.digitsOnly
//                           ],
//                         )),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(
//                 height: 8,
//               ),
//               Text(
//                 wrongCode,
//                 style: body4(errorColor, TextDecoration.none),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               isLoading
//                   ? Center(
//                   child: LoadingAnimationWidget.inkDrop(
//                       color: primaryColor, size: 25))
//                   : AppButton(
//                 textColor: kWhite,
//                 onPressed: () async {
//                   code = code.replaceAll('null', '');
//                   print('VerificationCode = $code');
//                   setState(() {
//                     isLoading = true;
//                   });
//                   int coded = int.parse(code);
//                   String message = await verificationref.verifyUser(
//                     //widget.email,
//                       coded);
//                   if (message == 'verified') {
//                     setState(() {
//                       isLoading = false;
//                     });
//
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //     builder: (context) => const AppPayment(),
//                     //   ),
//                     // );
//
//                     // Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //       builder: (context) =>
//                     //           AddProfilePic(email: widget.email),
//                     //     ));
//                   } else {
//                     setState(() {
//                       isLoading = false;
//                       wrongCode = 'Wrong code';
//                     });
//                   }
//                 },
//                 label: "Confirm",
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               coountDownOver
//                   ? GestureDetector(
//                   onTap: () async {
//                     setState(() {
//                       isLoading = false;
//                       code = '';
//                     });
//                     print(code);
//                     // await verificationref
//                     //     .resendVerificationCode(widget.email);
//                     startCountdown();
//
//                   },
//                   child: const Center(child: Text("Resend SMS code")))
//                   : Center(child: Text("Resend SMS code ($countdown secs)"))
//             ]),
//       ),
//     );
//   }
// }