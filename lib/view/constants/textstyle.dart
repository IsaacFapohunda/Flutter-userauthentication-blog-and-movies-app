import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:springboot_flutter_bloggingapp/model/theme/app_color.dart';
import 'package:flutter/material.dart';


import '../../model/theme/app_color.dart';


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
    color:  kPrimaryColor,
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