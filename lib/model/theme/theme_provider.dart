import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:springboot_flutter_bloggingapp/model/theme/app_color.dart';
import '../../main.dart';



final themeDataProvider = ChangeNotifierProvider((ref) => ThemeProvider(isDarkTheme: false));


class ThemeProvider extends ChangeNotifier {

  ThemeProvider({required bool isDarkTheme}) {
    themeMode = isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }


  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      return themeMode.name == Brightness.dark.name;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  Future<void> toggleTheme({required bool isOn}) async {
    if (isOn) {
      themeMode = ThemeMode.dark;
      await prefs.setBool('isDarkTheme', true);

    } else {
      themeMode = ThemeMode.light;
      await prefs.setBool('isDarkTheme', false);
    }

    notifyListeners();
  }

  ThemeMode getTheme() => themeMode;

}



class AppThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: backgroundColorDarkThemeDark,
      colorScheme: const ColorScheme.dark(),
      fontFamily: 'SegUI',
      primaryColor: kWhite,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: kWhite,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        bodyMedium: TextStyle(
          color: kWhite,
          fontSize: 16,
        ),
      ),
      iconTheme: const IconThemeData(color: kWhite),
      cardColor: kPrimaryColor,
      appBarTheme: AppBarTheme(
        backgroundColor: grey2,
        surfaceTintColor: grey2,
        titleTextStyle: const TextStyle(
          color: kWhite,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: accentColor,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        linearTrackColor: indicatorColor2,
        color: indicatorColor1,
        refreshBackgroundColor: indicatorColor3,
      ),
      highlightColor: kPrimaryColor.withOpacity(0.2),
      indicatorColor: accentColor,
      shadowColor: Colors.transparent,
      canvasColor: Colors.black.withOpacity(0.7)
  );

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: backgroundColorLightThemeWhite,
      colorScheme: const ColorScheme.light(),
      fontFamily: 'SegUI',
      primarySwatch: primaryColors,
      primaryColor: kBlack,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: kBlack,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        bodyMedium: TextStyle(color: kBlack, fontSize: 16),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: accentColor,
      ),
      iconTheme: const IconThemeData(color: kPrimaryColor),
      cardColor: kWhite,
      appBarTheme: const AppBarTheme(
        surfaceTintColor: kWhite,
        backgroundColor: kWhite,
        titleTextStyle: TextStyle(
          color: kBlack,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(color: kBlack),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        linearTrackColor: indicatorColor2,
        color: indicatorColor1,
        refreshBackgroundColor: indicatorColor3,
      ),
      highlightColor: kPrimaryColor.withOpacity(0.2),
      indicatorColor: accentColor,
      shadowColor: Colors.grey[400],
      canvasColor: Colors.white.withOpacity(0.5)
  );
}