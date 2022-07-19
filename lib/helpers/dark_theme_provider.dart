import 'package:flutter/material.dart';

import '../helpers/dark_theme_pref.dart';

///[DarkThemeProvider] apply user theme choice round about the app
class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  // ThemeMode _themeMode = ThemeMode.light;

  // ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _darkTheme;

  /// set the desired theme type by returning
  ///```true``` for dark theme or ```false``` for light theme
  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setTheme(value);
    debugPrint('Dark Theme mode is: $_darkTheme');
    notifyListeners();
  }

  // void toggleTheme(bool isOn) {
  //   _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
  //   darkThemePreference.setTheme(_themeMode);
  //   debugPrint('Theme mode is: $_themeMode');
  //   notifyListeners();
  // }

  ///get if dark theme should be applied
  // bool get darkTheme => _darkTheme;

}
