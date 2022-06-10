import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia/configs/routes.dart';

import 'helpers/dark_theme_provider.dart';
import 'core/game/home_screen.dart';
import 'widgets/splash_screen.dart';
import 'core/auth/screens/auth_screen.dart';
import 'helpers/user_pref.dart';
import 'helpers/trivia_history.dart';
import 'configs/app_theme.dart';
import 'core/auth/controllers/auth_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DarkThemeProvider _themeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    _getCurrentAppTheme();
    _checkThemeChange(theme: _themeProvider);
  }

  ///actively listens for changes in the device theme.
  ///If user has selected 'System Default' as the theme of the app
  ///then this app will automatically change its colour when the device switches
  ///from eithe Dark to Light Mode or Light to Dark Mode
  void _checkThemeChange({DarkThemeProvider? theme}) {
    var window = WidgetsBinding.instance.window;
    window.onPlatformBrightnessChanged = () {
      //the callback is called every time the brightness changes.
      var brightness = window.platformBrightness;
      if (theme!.isAppDefaultThemeActive) {
        // print('Main: isAppDefaultActive = ${theme.isAppDefaultThemeActive}');
        brightness == Brightness.dark ? theme.darkTheme = true : theme.darkTheme = false;
      }
      //print('Main: isDarkMode = ${theme.darkTheme}');
    };
  }

  ///this will get the app current theme as saved in the shared pref file
  void _getCurrentAppTheme() async {
    //get if device theme wants to be used
    _themeProvider.isAppDefaultThemeActive = await _themeProvider.darkThemePreference.getDeviceTheme();
    _getDeviceCurrentTheme(
      _themeProvider.isAppDefaultThemeActive,
    );

    _themeProvider.darkTheme = await _themeProvider.darkThemePreference.getTheme();
  }

  ///this subroutine checks if "System Default Theme" option was choosen
  void _getDeviceCurrentTheme(bool isDeviceThemeSelected) {
    print('Main: isDeviceThemeSelected = $isDeviceThemeSelected');
    if (isDeviceThemeSelected) {
      _themeProvider.darkThemePreference.getCurrentDeviceTheme();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => UserPref(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AuthController(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => TriviaHistory(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => _themeProvider,
        ),
      ],
      child: MaterialApp(
        title: 'Trivia',
        theme: AppTheme(context).lightTheme,
        home: Consumer<UserPref>(
          builder: (_, userPref, __) => FutureBuilder(
            future: userPref.isLoggedIn(),
            builder: (ctx, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              }
              return !userPref.isLogin ? const AuthScreen() : const HomeScreen();
            },
          ),
        ),
        routes: Routes().generateRoutes(context),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
