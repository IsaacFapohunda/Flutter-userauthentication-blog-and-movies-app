
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:springboot_flutter_bloggingapp/model/general_services/api_result.dart';
import 'package:springboot_flutter_bloggingapp/model/requests/login_request.dart';
import 'package:springboot_flutter_bloggingapp/model/requests/sign_up_request.dart';
import 'package:springboot_flutter_bloggingapp/model/theme/change_theme_button_widget.dart';
import 'package:springboot_flutter_bloggingapp/view/screens/HomeScreen.dart';
import 'package:springboot_flutter_bloggingapp/view/screens/Signup_screen.dart';
import 'package:springboot_flutter_bloggingapp/view/screens/verification_screen.dart';
import 'package:springboot_flutter_bloggingapp/model/theme/app_color.dart';

import '../../main.dart';
import '../../model/gen/assets.gen.dart';
import '../../model/internet/internet.dart';
import '../../view_model/notifier/auth_notifier.dart';
import '../../view_model/state/auth_state.dart';
import '../constants/strings.dart';
import '../widgets/app_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends ConsumerState<LoginScreen> with TickerProviderStateMixin{


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //api exception already does this aiit
  //BUT WHEN THERE IS NO CALL
  Future<bool> noInternet() async{
    final connectivity = ref.read(internetProvider);
    if(connectivity.status == ConnectivityStatus.disconnected){
      WidgetsBinding.instance.addPostFrameCallback((_){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(
              CustomStrings.noInternet1,
              textAlign: TextAlign.center,
            ))
        );
      });
      return true;
    }
    return false;
  }






  void submit() async{
    if(await noInternet()) return;
    ref.read(authProvider.notifier).logIn(
      email: emailController.text,
      password: passwordController.text,
      //hasInternet: hasInternet
    );
  }

  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;
    final internetState = ref.watch(internetProvider);
    final loginState = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (previous, next) {

      if (next.request.isSuccess) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }

      if (next.request.isError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.request.message),
          ),
        );
      }
    });


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Align(
          alignment: Alignment.topLeft,
          child: Text("Welcome"),
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
                      errorCondition: loginState.emailError,
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
                      errorCondition: loginState.passwordError,
                      isobsure: true,
                      label: "Password",
                      controller: passwordController,
                      ispassword: true,
                    ),

                    const SizedBox(
                      height: 20,
                    ),


                    loginState.request.when(
                        idle: (){
                          return AppButton(onPressed: submit,
                            label: "Login",);
                        },
                        success: (_){
                          return AppButton(
                            onPressed: submit,
                            label: 'Login',
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
                                label: 'Try again',
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



                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context) => const SignupScreen()));

                    }, child: const Text('Don\'t have an account?'))


                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}