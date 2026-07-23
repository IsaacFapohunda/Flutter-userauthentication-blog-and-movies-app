import 'dart:developer';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:springboot_flutter_bloggingapp/model/general_services/api_result.dart';
import 'package:springboot_flutter_bloggingapp/model/provider/navigation_bar_provider.dart';
import 'package:springboot_flutter_bloggingapp/model/provider/signup_notifier.dart';
import 'package:springboot_flutter_bloggingapp/model/requests/login_request.dart';
import 'package:springboot_flutter_bloggingapp/model/requests/sign_up_request.dart';
import 'package:springboot_flutter_bloggingapp/model/theme/change_theme_button_widget.dart';
import 'package:springboot_flutter_bloggingapp/view/screens/verification_screen.dart';
import 'package:springboot_flutter_bloggingapp/view/utilities/app_button.dart';
import 'package:springboot_flutter_bloggingapp/view/utilities/app_color.dart';

import '../../model/gen/assets.gen.dart';
import '../../model/general_services/auth_services.dart';
import '../../model/internet/internet.dart';
import '../../model/state/signup_state.dart';
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


  void submit(){
    final hasInternet = ref.read(internetProvider).status == ConnectivityStatus.connected;
    ref.read(signUpProvider.notifier).signUp(
        firstName: firstNameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: passwordController2.text,
        hasInternet: hasInternet);
  }

  @override
  Widget build(BuildContext context) {
    height: MediaQuery.of(context).size.height;
    final signupState = ref.watch(signUpProvider);



    ref.listen<SignupState>(signUpProvider, (previous, next) {
      if (next.request.isSuccess) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const VerificationScreen(email: '',)));

      }

      if (next.request.isError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.request.message),
          ),
        );
      }
    });


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
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,),
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
                   errorCondition: signupState.firstNameError,
                   controller: firstNameController,
                   label: "First Name"),
               const SizedBox(
                 height: 20,
               ),
               customTextField(
                 errorCondition: signupState.emailError,
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
                 errorCondition: signupState.passwordError,
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
                 errorCondition: signupState.confirmPasswordError,
                 isobsure: true,
                 label: "Password",
                 controller: passwordController2,
                 ispassword: true,
                 focusNode: passwordFocusNode,
               ),

               const SizedBox(
                 height: 20,
               ),


           signupState.request.when(
               idle: (){
                 return AppButton(onPressed: submit,
                     label: "Sign Up",);
               },
               success: (_){
                 return AppButton(
                   onPressed: submit,
                   label: 'Sign up',
                 );
               },
               error: (message){
                 return Column(
                   children: [
                     Text(
                       message,
                       style: const TextStyle(color: Colors.red),
                     ),
                     AppButton(
                       onPressed: submit,
                       label: 'Try agaIN',
                     ),
                   ],
                 );
               },
               loading: (){
                 return Center(
                     child: LoadingAnimationWidget.inkDrop(
                     color: Theme.of(context).brightness == Brightness.dark
                      ? kWhite
                     : kBlack, size: 25));
               }),


             ],
           ),
           ),
         ],
        )
      ),
    );
  }
}


// AppButton(onPressed: () async {
//   if (internetState.status ==
//       ConnectivityStatus.disconnected) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             CustomStrings.noInternet1,
//             textAlign: TextAlign.center,
//           ),),
//       );