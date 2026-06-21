import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final navigationBarProvider = ChangeNotifierProvider<NavigationBarProvider>((ref) => NavigationBarProvider());


class NavigationBarProvider with ChangeNotifier{
  late AnimationController _animationController;

  void setAnimationController(AnimationController animationController){
    _animationController = animationController;
    notifyListeners();
  }

  AnimationController get animationController => _animationController;
}