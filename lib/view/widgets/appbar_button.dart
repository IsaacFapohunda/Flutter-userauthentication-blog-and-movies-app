import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  Color? color;
  String text;
  void Function()? onPressed;
  Color? textColor;
  AppBarButton({required this.onPressed, required this.color, required this.text, required this.textColor}) : super();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
      width: size.width*0.25,
      height: size.height*0.045,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: TextButton(onPressed: onPressed,
        child: Text(text, style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),),),
    );
  }
}