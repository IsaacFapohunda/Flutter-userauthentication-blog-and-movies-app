import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:springboot_flutter_bloggingapp/view/screens/Signup_screen.dart';
import 'package:springboot_flutter_bloggingapp/view/screens/splash_screen.dart';
import 'package:springboot_flutter_bloggingapp/view/screens/verification_screen.dart';
import 'package:springboot_flutter_bloggingapp/view/utilities/app_image.dart';
import 'package:springboot_flutter_bloggingapp/view/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'model/theme/theme_provider.dart';
import 'dart:io';



final navigatorKey = GlobalKey<NavigatorState>();
//late Mixpanel mixpanel;
late SharedPreferences prefs;

String baseUrl = 'https://springbootrolebaseauth.onrender.com/api/v1/role_base';

///https://2218-102-89-22-226.ngrok-free.app
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );


  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,


    /// Uncomment below 2 lines to enable landscape mode
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);




  const counter = 0;

  await SharedPreferences.getInstance().then((prefs) {
    prefs.setInt('counter', counter);
    final bool isDarkTheme;
    if (prefs.getBool('isDarkTheme') ?? ThemeMode.system == ThemeMode.dark) {
      isDarkTheme = true;
    } else {
      isDarkTheme = false;
    }
    return runApp(
      const ProviderScope(
          child: MyApp())
    );
  });

}

class MyApp extends ConsumerStatefulWidget {

  const MyApp();

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {


  Widget build(BuildContext context) {
    final theme = ref.watch(themeDataProvider);
    return ScreenUtilInit(
      designSize: const Size(428, 964),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child){
        return  MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        themeMode: theme.themeMode,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        navigatorKey: navigatorKey,
        //this enables to perform navigation actions(push, pop
        //without needing a buildcontext)
        home: const SignupScreen(),
        );
      },

    );
  }
}