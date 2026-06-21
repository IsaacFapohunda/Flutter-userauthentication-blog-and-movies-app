import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:springboot_flutter_bloggingapp/model/provider/navigation_bar_provider.dart';
import 'package:springboot_flutter_bloggingapp/model/requests/login_request.dart';
import 'package:springboot_flutter_bloggingapp/model/requests/signup_request.dart';
import 'package:springboot_flutter_bloggingapp/model/theme/change_theme_button_widget.dart';
import 'package:springboot_flutter_bloggingapp/view/utilities/app_button.dart';
import 'package:springboot_flutter_bloggingapp/view/utilities/app_color.dart';

import '../../model/gen/assets.gen.dart';
import '../../model/general_services/auth_services.dart';
import '../../model/internet/internet.dart';
import '../utilities/constants.dart';
import '../utilities/custom_text_field.dart';
import '../utilities/screen_util.dart';
import '../utilities/strings.dart';

class SignupScreen extends ConsumerStatefulWidget {

  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();

}

class _SignupScreenState extends ConsumerState<SignupScreen> with TickerProviderStateMixin{



  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  bool firstNameError = false;
  bool emailError = false;
  bool passwordError = false;
  bool passwordMismatch = false;
  bool isLoading = false;

  var errorMessage = "";

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  late AnimationController idleAnimation;
  late AnimationController onSelectedAnimation;
  late AnimationController onChangedAnimation;
  Duration animationDuration = const Duration(milliseconds: 700);
  late AppLifecycleListener _appLifecycleListener;
  late AnimationController navigationContainerAnimationController =
  AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );



  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  @override
   initState() {
    // TODO: implement initState
    super.initState();


    idleAnimation = AnimationController(vsync: this);
    onSelectedAnimation =
        AnimationController(vsync: this, duration: animationDuration);
    onChangedAnimation =
        AnimationController(vsync: this, duration: animationDuration);

    late AnimationController navigationContainerAnimationController =
    AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

  }


  @override
  void dispose() {
    // TODO: implement dispose
    idleAnimation.dispose();
    onSelectedAnimation.dispose();
    onChangedAnimation.dispose();
    navigationContainerAnimationController.dispose();
    firstNameController.dispose();

    emailController.dispose();
    passwordController.dispose();
    passwordController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
 //final userProvider = ref.watch(userAuthProvider);
    height: MediaQuery.of(context).size.height;
    final internetState = ref.watch(internetProvider);
    final authServiceState = ref.watch(authServiceProvider);


    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent, // Theme.of(context).cardColor,
    //     statusBarBrightness: Theme.of(context).brightness == Brightness.dark
    //         ? Brightness.dark
    //         : Brightness.light,
    //     statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
    //         ? Brightness.light
    //         : Brightness.dark,
    //   ),
    //);


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Align(
          alignment: Alignment.topLeft,
          child: Text("Title"),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,

          ),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
         children: [

          const ChangeThemeButtonWidget(),

           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20),
           child: Column(
             children: [
               const SizedBox(
                 height: 15,
               ),


               const Text(
              "Welcome",
                 style: TextStyle(
                   fontSize: 18,
                   fontWeight: FontWeight.w600,
                 ),
               ),
               customTextField(
                   error: 'Enter a valid name',
                   errorCondition: firstNameError,
                   controller: firstNameController,
                   label: "First Name"),
               const SizedBox(
                 height: 20,
               ),
               customTextField(
                 errorCondition: emailError,
                 focusNode: emailFocusNode,
                 controller: emailController,
                 label: "E-mail",
                 error: 'Enter a valid email address',
               ),

               const SizedBox(
                 height: 20,
               ),

               customTextField(
                 error: '',
                 errorCondition: passwordMismatch,
                 isobsure: true,
                 label: "Password",
                 controller: passwordController,
                 ispassword: true,
               ),

               const SizedBox(
                 height: 20,
               ),
               customTextField(
                 error: 'Passwords do not match',
                 errorCondition: passwordMismatch,
                 isobsure: true,
                 label: "Password",
                 controller: passwordController2,
                 ispassword: true,
                 focusNode: passwordFocusNode,
               ),

               const SizedBox(
                 height: 20,
               ),

               // GestureDetector(
               //   onTap: () {
               //     // Navigator.push(
               //     //     context,
               //     //     MaterialPageRoute(
               //     //       builder: (context) => ForgetPassword(),
               //     //     ));
               //   },
               //   child: Container(
               //     alignment: Alignment.bottomLeft,
               //     child: const Text(
               //       "By signing up, you accept our T&Cs and Privacy Policy. ",
               //       style: TextStyle(
               //         fontSize: 13,
               //       ),
               //     ),
               //   ),
               // ),

               isLoading ?
                   Center(
                     child: LoadingAnimationWidget.inkDrop(
                         color: Theme.of(context).brightness == Brightness.dark
                         ? kWhite
                         : kBlack, size: 25),
                   ) :

               AppButton(onPressed: () async {
                 if (internetState.status ==
                     ConnectivityStatus.disconnected) {
                   WidgetsBinding.instance.addPostFrameCallback((_) {
                     ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                         content: Text(
                           CustomStrings.noInternet1,
                           textAlign: TextAlign.center,
                         ),),
                     );
                   });
                 } else{
                   setState(() {
                     isLoading =  true;
                   });
                   if (firstNameController.text.isEmpty) {
                     setState(() {
                       firstNameError = true;
                       isLoading = false;
                     });
                   }
                   if (passwordController.text !=
                       passwordController2.text ||
                       passwordController.text.isEmpty ||
                       passwordController2.text.isEmpty) {
                     setState(() {
                       passwordMismatch = true;
                       isLoading = false;
                     });
                   }

                   if (!isValidEmail(emailController.text)) {
                     setState(() {
                       emailError = true;
                       isLoading = false;
                     });
                   }

                   if(isLoading = true){
                      // final response = await userProvider.userSignUp(emailController.text, passwordController.text, firstNameController.text) ;
                      // print(response);

                      final response = await authServiceState.signup(
                         SignUpRequest(email: emailController.text.toLowerCase().trim(),
                             password: passwordController.text.trim(), firstName: firstNameController.text.trim()));
                 print('udddddddddddddddddddddddddddddd');
                     print(response.toString());

                   return response.fold((failure){
                    errorMessage = failure.message;
                    print('$errorMessage  + 777777777777');

                     if (kDebugMode) {
                       print('$response + 224444' );
                     }

                   }, (r){
                     print('$r + 00000000000');
                     return true;
                   });


                     // final response = await authServiceState.login(LoginRequest(email: emailController.text.trim(), password: passwordController.text.trim(), otp: ''));
                     // return response.fold((failure){
                     //   errorMessage = failure.errorMessage;
                     //
                     // }, (r){
                     //   if (kDebugMode) {
                     //     print(response);
                     //   }
                     //   return true;
                     // });



                   }
                 }
               }, label: 'Sign Up')


             ],
           ),
           ),

         ],
        )

      ),
    );
  }





}