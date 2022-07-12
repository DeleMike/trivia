import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

/// Creates light and dark [ThemeData].
class AppTheme {
  late ThemeData lightTheme;

  /// Constructs an [AppTheme].
  AppTheme(BuildContext context) {
    lightTheme = ThemeData(
      fontFamily: GoogleFonts.ubuntu().fontFamily,
      brightness: Brightness.light,
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: kCanvasColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xfff5f5f5),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo).copyWith(secondary: kPrimaryColor),
      buttonTheme: ButtonTheme.of(context).copyWith(
        buttonColor: kPrimaryColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return kPrimaryColor.withOpacity(.48);
          }
          return kPrimaryColor;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color>((states) {
          return kPrimaryColor.withOpacity(.48);
        }),
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
            bodyText2: TextStyle(
              color: kBlack,
              fontFamily: GoogleFonts.ubuntu().fontFamily,
            ),
            bodyText1: const TextStyle(
              color: kBlack,
              fontStyle: FontStyle.italic,
            ),
            headline1: const TextStyle(
                fontSize: 16, fontFamily: 'Ubuntu', fontWeight: FontWeight.normal, color: kWhite),
            headline6: const TextStyle(
              fontSize: 18,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.normal,
            ),
            headline5: const TextStyle(
              fontSize: 18,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w600,
            ),
          ),
    );
  }
}
