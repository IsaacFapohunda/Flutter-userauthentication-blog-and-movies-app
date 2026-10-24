import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../main.dart';
import '../../view_model/notifier/auth_notifier.dart';
import '../../view_model/state/auth_state.dart';
import '../../model/theme/app_color.dart';

import '../constants/textstyle.dart';
import '../widgets/app_button.dart';
import '../widgets/back_button.dart';
import 'HomeScreen.dart';
import 'movie_screen.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  final String email;
  const VerificationScreen({super.key, required this.email});

  @override
  ConsumerState<VerificationScreen> createState() =>
      _VerificationScreenConsumerState();
}


class _VerificationScreenConsumerState
    extends ConsumerState<VerificationScreen> {
  int countdown = 59;
  late Timer timer;
  bool coountDownOver = false;
  @override



  void initState() {
    super.initState();
    startCountdown();

  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        setState(() {
          coountDownOver = true;
        });
        timer.cancel();
      }
    });
  }



  String code ='';
  String wrongCode = '';
  bool isLoading = false;
  String accessCode = "1255";
  int? otp = prefs.getInt('otp');




  void submit(){
    code = code.replaceAll('null', '');

    int encodedCode = int.parse(code);
    // print('VerificationCode = $code');
    Text('Your verification code is $code');
    ref.read(authProvider.notifier).verifyOtp(otp: encodedCode, email: widget.email);
  }



  @override
  Widget build(BuildContext context) {
   final verificationState = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (previous, next){
      if(previous?.request.isSuccess != true && next.request.isSuccess){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));

      }
    else if(previous?.request.isError != true && next.request.isError){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.request.message)),
        );
      }
    });




  return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Verify your new account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Enter the 4-digit code sent to you at ${widget.email}"),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: grey5,
                    ),
                    width: 50,
                    child: Center(
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              String nevalue = ("$code$value");
                              code = nevalue;
                            });
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: grey5,
                    ),
                    width: 50,
                    child: Center(
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              String nevalue = ("$code$value");

                              code = nevalue;
                            });
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            } else {
                              if (value.isEmpty) {
                                FocusScope.of(context).previousFocus();
                              }
                            }
                          },
                          onSaved: (newValue3) {},
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: grey5,
                    ),
                    width: 50,
                    child: Center(
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              String nevalue = ("$code$value");

                              code = nevalue;
                            });
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            } else {
                              if (value.isEmpty) {
                                FocusScope.of(context).previousFocus();
                              }
                            }
                          },
                          onSaved: (newValue3) {},
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: grey5,
                    ),
                    width: 50,
                    child: Center(
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              String nevalue = ("$code$value");

                              code = nevalue;
                            });
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            } else {
                              if (value.isEmpty) {
                                FocusScope.of(context).previousFocus();
                              }
                            }
                          },
                          onSaved: (newValue3) {},
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        )),
                  ),
                ],
              ),

              const SizedBox(
                height: 8,
              ),
              Text(
                wrongCode,
                style: body4(errorColor, TextDecoration.none),
              ),
              const SizedBox(
                height: 30,
              ),

              verificationState.request.when(
                  idle: (){
                    return AppButton(
                      textColor: kWhite,
                      onPressed: submit,
                      label: "Confirm",
                    );
                  },
                  success: (_){
                    return AppButton(
                      textColor: kWhite,
                      onPressed: submit,
                      label: "Confirm",
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

              const SizedBox(
                height: 30,
              ),
              coountDownOver
                  ? GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLoading = false;
                      code = '';
                    });
                    print(code);
                    // await verificationref
                    //     .resendVerificationCode(widget.email);
                    startCountdown();

                  },
                  child: const Center(child: Text("Resend SMS code")))
                  : Center(child: Text("Resend SMS code ($countdown secs)"))
            ]),
      ),
    );
  }
}