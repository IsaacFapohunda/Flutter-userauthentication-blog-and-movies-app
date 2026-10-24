
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/gen/assets.gen.dart';
import '../../model/internet/internet.dart';
import '../constants/strings.dart';
import '../widgets/no_internet_widget.dart';



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