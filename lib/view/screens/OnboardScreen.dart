import 'package:flutter/material.dart';
import 'package:springboot_flutter_bloggingapp/model/theme/app_color.dart';

import '../../view_model/constants/app_image.dart';
import '../../view_model/widgets/app_button.dart';
import 'Signup_screen.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List images = [
    tv,
    kScreenoneimage,
  ];

  List texts = [
    "See movies in ",
    "Make blogs in ",

  ];

  List subTexts = [
    "Join Streams of High Demand Movies.",
    "Effortlessly Connect with Others and Make Your Friendship a Breeze.",

  ];

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.10),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: size.height * 0.4),
                child: Stack(children: [
                  PageView.builder(
                      itemCount: images.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Image.asset(
                          images[index],
                          fit: BoxFit.contain,
                        );
                      }),
                ]),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: SliderContainer(
                          color: _currentIndex == index ? kWhite : grey5),
                    );

                  })),
              const SizedBox(height: 10),
              const SizedBox(height: 20, child:
                Icon(Icons.swipe, color: kWhite,),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                      children: List.generate(texts.length, (index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: RichText(
                                text: TextSpan(
                                    text: _currentIndex == index ? texts[index] : '',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: kBlack,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                          text: _currentIndex == index ? "BM App" : "",
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: kWhite,
                                          ))
                                    ])));
                      })),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                //mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(subTexts.length, (index) {
                    return SizedBox(
                      width: double.infinity,
                      child: Text(
                        _currentIndex == index ? subTexts[index] : '',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(color: kBlack),
                      ),
                    );
                  })),
              const SizedBox(
                height: 20,
              ),
              AppButton(
                textColor: kWhite,
                label: "Sign Up",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              AppButton(
                label: "Log In",
                buttonColor: kWhite,
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SliderContainer extends StatelessWidget {
  const SliderContainer({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 15,
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(5), color: color),
    );
  }
}