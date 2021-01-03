import 'package:shared_preferences/shared_preferences.dart';

///[DarkThemePreference] is used to save user dark theme preference
class DarkThemePreference {
  static const THEME_STATUS = 'THEME_STATUS';
  SharedPreferences prefs;

  ///set user dark theme choice
  void setDarkTheme(bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  ///get user dark theme choice
  Future<bool> getTheme() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}