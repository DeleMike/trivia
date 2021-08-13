import 'package:shared_preferences/shared_preferences.dart';

///[DarkThemePreference] is used to save user dark theme preference
class DarkThemePreference {
  static const THEME_STATUS = 'THEME_STATUS';
  static const DEVICE_THEME_STATUS = 'DEVICE_THEME_STATUS';
  late SharedPreferences prefs;

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

  ///set device theme
  void setDeviceTheme(bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(DEVICE_THEME_STATUS, value);
  }

  ///get device theme
  Future<bool> getDeviceTheme() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool(DEVICE_THEME_STATUS) ?? false;
  }
}
