import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:springboot_flutter_bloggingapp/view/utilities/app_color.dart';
import 'package:flutter/material.dart';


import 'app_color.dart';


TextStyle kTextStyle1(height) => TextStyle(
    fontSize: height/ 24, color: kBlack);



TextStyle kTextStyle2(height) =>  GoogleFonts.poppins(
    textStyle: TextStyle(
        fontSize: height / 38,
        color: Colors.white,
        fontWeight: FontWeight.w500));

TextStyle kTextStyle3(height) => GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: height / 65,
      color: Colors.white,
    ));

TextStyle kTextStyle4(height) => GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: height / 55,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ));

TextStyle kTextStyle5(height) => GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: height / 60,
      color: Colors.white,
    ));

TextStyle kTextStyle6(height) => GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: height / 57,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ));

TextStyle kTextStyle7(height) => GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: height / 55,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ));


headline1(color) {
  return TextStyle( fontFamily: "Avenir", fontSize:24.sp, fontWeight:FontWeight.bold, color:color);
}
headline2(color) {
  return TextStyle( fontFamily: "Avenir", fontSize:20.sp, fontWeight:FontWeight.w600, color:color);
}
headline3(color) {
  return TextStyle( fontFamily: "Avenir", fontSize:18, fontWeight:FontWeight.bold, color:color);
}
headline4(color) {
  return TextStyle( fontFamily: "Avenir", fontSize:15, fontWeight:FontWeight.bold, color:color);
}

headline5(color) {
  return TextStyle( fontFamily: "Avenir", fontSize:25, fontWeight:FontWeight.w900, color:color);
}


body1(color, decoration) {
  return TextStyle(
      fontFamily: "Avenir", fontSize: 20.sp, color: color, decoration: decoration);
}

body2(color, decoration) {
  return TextStyle( fontFamily: "Avenir", fontSize:18.sp, color:color, decoration: decoration);
}
body3(color, decoration) {
  return TextStyle( fontFamily: "Avenir", fontSize:15.sp, color:color, decoration: decoration);
}
body4(color, decoration) {
  return TextStyle( fontFamily: "Avenir", fontSize:13.sp, color:color, decoration: decoration);
}



apptextstyle(){
  return TextStyle(
    color: primaryColor,
  );
}

apptextwhite(){
  return TextStyle(
      color: Colors.white,
      fontSize: 23,
      fontWeight: FontWeight.bold
  );
}

appbartextStyle(){
  return TextStyle(
    fontSize: 16,

  );
}