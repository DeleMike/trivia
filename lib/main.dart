import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia/helpers/dark_theme_provider.dart';
import 'package:trivia/models/styles.dart';

import './widgets/splash_screen.dart';
import './screens/auth_screen.dart';
import './screens/categories.dart';
import './screens/build_question.dart';
import './screens/welcome_screen.dart';
import './screens/quiz_page.dart';
import './screens/view_answers.dart';
import './screens/history_screen.dart';
import './screens/settings.dart';
import './helpers/user_pref.dart';
import './helpers/trivia_history.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider _themeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    _getCurrentAppTheme();
  }

  //this will get the app current theme as saved in the shared pref file
  void _getCurrentAppTheme() async {
    _themeProvider.darkTheme =
        await _themeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => UserPref(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => TriviaHistory(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => _themeProvider,
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (_, themeProvider, __) => MaterialApp(
          title: 'Trivia',
          theme: Styles.themeData(themeProvider.darkTheme, context),
          
          home: Consumer<UserPref>(
            builder: (_, userPref, __) => FutureBuilder(
              future: userPref.isLoggedIn(),
              builder: (ctx, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SplashScreen();
                }
                return !userPref.isLogin ? AuthScreen() : WelcomeScreen();
              },
            ),
          ),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            Categories.routeName: (ctx) => Categories(),
            BuildQuestion.routeName: (ctx) => BuildQuestion(),
            QuizPage.routeName: (ctx) => QuizPage(),
            ViewAnswers.routeName: (ctx) => ViewAnswers(),
            HistoryScreen.routeName: (ctx) => HistoryScreen(),
            Settings.routeName: (ctx) => Settings(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
