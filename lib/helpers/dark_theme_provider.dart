import 'package:flutter/foundation.dart';

import '../helpers/dark_theme_pref.dart';

///[DarkThemeProvider] apply user theme choice round about the app
class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  ///get if dark theme should be applied
  bool get darkTheme => _darkTheme;

  ///set the desired theme type by returning 
  ///```true``` for dark theme or ```false``` for light theme
  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }

}