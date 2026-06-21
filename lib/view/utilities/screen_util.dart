// import 'package:flutter/material.dart';
//
// const double designScreenHeight = 926.0;
// const double designScreenWidth = 428.0;
//
// ///
// /// return current screen's height, width and orientation
// class ScreenUtil {
//   static MediaQueryData? _mediaQueryData;
//   static late double screenHeight;
//   static late double screenWidth;
//   static Orientation? orientation;
//
//   static late double _safeAreaWidth;
//   static late double _safeAreaHeight;
//   static late double safeScreenWidth;
//   static late double safeScreenHeight;
//
//   void init(BuildContext context) {
//     _mediaQueryData = MediaQuery.of(context);
//     screenWidth = _mediaQueryData!.size.width;
//     screenHeight = _mediaQueryData!.size.height;
//     orientation = _mediaQueryData!.orientation;
//
//     _safeAreaWidth =
//         _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
//     _safeAreaHeight =
//         _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
//     safeScreenWidth = (screenWidth - _safeAreaWidth) / 100;
//     safeScreenHeight = (screenHeight - _safeAreaHeight) / 100;
//   }
// }
//
// ///
// /// return screen's height percentage
// double getScreenHeightPercentage(double percentageValue) {
//   double screenHeight = ScreenUtil.screenHeight;
//   return (percentageValue / 100) * screenHeight;
// }
//
// ///
// /// return screen's width percentage
// double getScreenWidthPercentage(double percentageValue) {
//   double screenWidth = ScreenUtil.screenWidth;
//   return (percentageValue / 100) * screenWidth;
// }
//
// ///
// /// return screen's height percentage
// double getSafeScreenHeightPercentage(double percentageValue) {
//   double screenHeight = ScreenUtil.safeScreenHeight;
//   return (percentageValue / 100) * screenHeight;
// }
//
// ///
// /// return screen's width percentage
// double getSafeScreenWidthPercentage(double percentageValue) {
//   double screenWidth = ScreenUtil.safeScreenWidth;
//   return (percentageValue / 100) * screenWidth;
// }
//
// ///
// /// return size based on design screen height
// double getScreenPropotionalHeight(double inputHeight) {
//   double? screenHeight = ScreenUtil.screenHeight;
//   return (inputHeight / designScreenHeight) * screenHeight;
// }
//
// ///
// /// return size based on design screen width
// double getScreenPropotionalWidth(double inputWidth) {
//   double screenWidth = ScreenUtil.screenWidth;
//   return (inputWidth / designScreenWidth) * screenWidth;
// }
//
// ///
// /// return size based on design screen width
// double getScreenPropotionalFontSize(double inputWidth) {
//   double screenWidth = ScreenUtil.screenWidth;
//   return (inputWidth / designScreenWidth) * screenWidth;
// }