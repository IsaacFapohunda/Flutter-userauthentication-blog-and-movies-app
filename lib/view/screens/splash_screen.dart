import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:springboot_flutter_bloggingapp/model/internet/no_internet_widget.dart';
import 'package:springboot_flutter_bloggingapp/view/utilities/strings.dart';

import '../../model/gen/assets.gen.dart';
import '../../model/internet/internet.dart';



class SplashScreen extends  ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  bool isLoading = false;
  bool isConnected = false;
  @override
  void initState() {

  }


  @override
  Widget build(BuildContext context) {
    final internetState =  ref.watch(internetProvider);

    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if(internetState.status == ConnectivityStatus.connected){
      return Scaffold(
        body: Column(
          children: [
           const Text(CustomStrings.onboardingMessage),

            DecoratedBox(decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.red],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),

            ), child: Center(
              child: Assets.pngs.autoLayoutHorizontal.image(),
            ),
            ),
          ],
        ),

      );
    } else {
      return const NoInternetWidget();
    }


  }
}