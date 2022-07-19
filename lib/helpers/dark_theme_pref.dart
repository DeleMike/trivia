import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///[DarkThemePreference] is used to save user dark theme preference
class DarkThemePreference {
  static const themeStatus = 'THEME_STATUS';
  late SharedPreferences prefs;

  ///set user dark theme choice
  void setTheme(bool isDarkTheme) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeStatus, isDarkTheme);
  }

  /// get user's dark theme choice
  Future<bool> getTheme() async {
    prefs = await SharedPreferences.getInstance();
    debugPrint('isDarkTheme On = ${prefs.getBool(themeStatus)}');
    return prefs.getBool(themeStatus) ?? false;
  }
}
