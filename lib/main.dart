import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'configs/constants.dart';
import 'configs/routes.dart';
import 'core/nav_screen.dart';
import 'core/game/controllers/question_form_controller.dart';
import 'widgets/splash_screen.dart';
import 'core/auth/screens/auth_screen.dart';
import 'helpers/user_pref.dart';
import 'helpers/trivia_history.dart';
import 'helpers/dark_theme_provider.dart';
import 'configs/app_theme.dart';
import 'core/auth/controllers/auth_controller.dart';
import 'core/game/controllers/quiz_page_controller.dart';
import 'widgets/internet_pop_screen.dart';
import 'configs/internet_config.dart';

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
  // ignore: unused_field
  // Map _source = {ConnectivityResult.none: false};
  bool isOnline = false;

  ConnectivityResult result = ConnectivityResult.none;
  final InternetConnectivity _connectivity = InternetConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _getTheme();

    _connectivity.initialise();
    _connectivity.internetStream.listen((source) {
      setState(() => isOnline = source);
    });
  }

  void _getTheme() async {
    _themeProvider.darkTheme = await _themeProvider.darkThemePreference.getTheme();
  }

  @override
  void dispose() {
    _connectivity.closeConnectionStream();
    super.dispose();
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
        ChangeNotifierProvider(
          create: (ctx) => QuestionFormController(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => QuizPageController(),
        ),
      ],
      // NOTE: Added Builder Wrapper because provider needed a new context.
      child: Builder(builder: (context) {
        return OverlaySupport.global(
          child: MaterialApp(
            title: kAppName,
            theme: AppTheme(context).themeData(context.watch<DarkThemeProvider>().isDarkMode),
            home: Consumer<UserPref>(
              builder: (_, userPref, __) => FutureBuilder(
                // future: Future.wait([userPref.isLoggedIn(), Future.delayed(const Duration(seconds: 1))]),
                future: userPref.isLoggedIn(),
                builder: (ctx, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SplashScreen();
                  }

                  return !isOnline ? const InternetPopScreen(): !userPref.isLogin ? const AuthScreen() : const NavScreen();
                },
              ),
            ),
            routes: Routes().generateRoutes(context),
            debugShowCheckedModeBanner: false,
          ),
        );
      }),
    );
  }
}
