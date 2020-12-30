import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.indigo,
      primaryColor: isDarkTheme ? Colors.black : Colors.indigo,
      accentColor: isDarkTheme ? Colors.black : Color(0xff3f51b5),
      canvasColor: isDarkTheme ? Colors.grey[900] : Colors.indigo[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,

      fontFamily: 'Ubuntu',
       accentColorBrightness: Brightness.dark,
      
      buttonTheme: isDarkTheme
          ? ButtonTheme.of(context).copyWith(
              buttonColor: Colors.black,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            )
          : ButtonTheme.of(context).copyWith(
              buttonColor: Colors.indigo,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
      textTheme: isDarkTheme
          ? ThemeData.light().textTheme.copyWith(
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
                    color: Colors.black),
                headline6: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                ),
                headline5: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w600,
                ),
              )
          : ThemeData.light().textTheme.copyWith(
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
                    color: Colors.black),
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
    );
  }
}
