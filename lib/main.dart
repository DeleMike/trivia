import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widgets/splash_screen.dart';
import './screens/auth_screen.dart';
import './screens/categories.dart';
import './screens/build_question.dart';
import './screens/welcome_screen.dart';
import './screens/quiz_page.dart';
import './screens/view_answers.dart';
import './helpers/user_pref.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => UserPref(),
      child: Consumer<UserPref>(
        builder: (_, userPref, __) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Color(0xff3f51b5),
            canvasColor: Colors.indigo[50],
            fontFamily: 'Ubuntu',
            accentColorBrightness: Brightness.dark,
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.indigo,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            textTheme: ThemeData.light().textTheme.copyWith(
                  bodyText2: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                  ),
                  bodyText1: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                    fontStyle: FontStyle.italic,
                  ),
                  headline1: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.normal,
                    color: Colors.black
                  ),
                  headline6: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold,
                  ),
                   headline5: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w600,
                  ),
                ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ), 
          home: FutureBuilder(
            future: userPref.isLoggedIn(),
            builder: (ctx, AsyncSnapshot<void> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              }
              return !userPref.isLogin ?  AuthScreen() : WelcomeScreen(); 
            },
          ),
          routes: {
            Categories.routeName : (ctx) => Categories(),
            BuildQuestion.routeName : (ctx) => BuildQuestion(),
            QuizPage.routeName : (ctx) => QuizPage(),
            ViewAnswers.routeName : (ctx) => ViewAnswers(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
