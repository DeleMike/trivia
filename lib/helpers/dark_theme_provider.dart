import 'package:flutter/foundation.dart';

import '../helpers/dark_theme_pref.dart';

///[DarkThemeProvider] apply user theme choice round about the app
class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;
  bool _isAppDefaultThemeActive = false;

  ///get if dark theme should be applied
  bool get darkTheme => _darkTheme;

  ///get value if app theme has been selected on the app
  bool get isAppDefaultThemeActive => _isAppDefaultThemeActive;

  ///set the desired theme type by returning
  ///```true``` for dark theme or ```false``` for light theme
  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }

  ///set value for ```isAppDefaultThemeActive```
  set isAppDefaultThemeActive(bool val) {
    _isAppDefaultThemeActive = val;
    notifyListeners();
  }
}
