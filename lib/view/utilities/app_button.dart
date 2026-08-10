import 'package:flutter/material.dart';
import 'package:springboot_flutter_bloggingapp/view/utilities/textstyle.dart';

import '../../model/theme/app_color.dart';

class AppButton extends StatelessWidget {
  VoidCallback onPressed;
  String label;
  Color buttonColor;
  Color textColor;
  Color borderColor;
  AppButton({
    required this.onPressed,
    required this.label,
    this.buttonColor = kBlack,
    this.textColor = kBlack,
    this.borderColor = kBlack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size height = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).brightness == Brightness.dark
                ? kWhite
                : kBlack
        ),
        child: Center(
          child: Text(
              label,
            style: TextStyle(
              color:
              Theme.of(context).brightness == Brightness.dark
                ? kBlack
                : kWhite
              ,
            ),
          ),
        ),
      ),
    );
  }
}