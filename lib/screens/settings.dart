import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:provider/provider.dart';

import '../helpers/dark_theme_provider.dart';
import '../screens/auth_screen.dart';

///[Settings] screen is used to display user prefences options
class Settings extends StatefulWidget {
  static const routeName = 'settings';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isDarkMode = false;
  bool _isAppInDarkMode = false;
  bool _isDeviceDefaultThemeChosen = false;

  @override
  Widget build(BuildContext context) {
    // final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Container(
        padding: const EdgeInsets.only(top: 1.0),
        child: Consumer<DarkThemeProvider>(
          builder: (_, theme, __) => SettingsList(
            sections: [
              SettingsSection(
                title: 'Preferences',
                titleTextStyle: TextStyle(
                    color: theme.darkTheme ? Colors.white : Colors.black),
                tiles: [
                  SettingsTile.switchTile(
                    title: 'Dark Mode',
                    leading: Icon(
                      _isDarkMode ? Icons.bedtime : Icons.bedtime_outlined,
                      color: Colors.indigo[600],
                    ),
                    enabled: !theme.isAppDefaultThemeActive,
                    switchValue: theme.darkTheme,
                    switchActiveColor: Colors.indigo[600],
                    onToggle: (bool val) {
                      theme.darkTheme = val;
                      print('Settings: Dark Mode = $val');
                    },
                  ),
                  SettingsTile(
                    title: 'Update bio',
                    subtitle: 'Change your name and profile pic',
                    leading: Icon(
                      theme.darkTheme ? Icons.person : Icons.person_outlined,
                      color: Colors.indigo[600],
                    ),
                    onPressed: (ctx) {
                      Navigator.of(context).pushNamed(AuthScreen.routeName);
                    },
                  ),
                  SettingsTile.switchTile(
                    title: 'System default theme',
                    subtitle: 'Apply your phone\'s current theme to this app',
                    leading: Icon(
                      _isDarkMode ? Icons.circle : Icons.circle_outlined,
                      color: Colors.indigo[600],
                    ),
                    switchValue: _isDeviceDefaultThemeChosen,
                    switchActiveColor: Colors.indigo[600],
                    onToggle: (bool val) {
                      //change toggle option
                      setState(
                        () => _isDeviceDefaultThemeChosen = val,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Settings: Phone Theme wants to be used = $_isDeviceDefaultThemeChosen',
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      if (_isDeviceDefaultThemeChosen) {
                        //get app current settings
                        var brightness =
                            MediaQuery.of(context).platformBrightness;
                        _isAppInDarkMode = brightness == Brightness.dark;
                        theme.isAppDefaultThemeActive = true;

                        //apply dark mode if user device theme is the Dark Theme
                        theme.darkTheme = _isAppInDarkMode;
                      } else {
                        //if device default mode is not chosen then enable
                        // app theming options which will be the primary theme
                        theme.isAppDefaultThemeActive = false;
                        theme.darkTheme = _isAppInDarkMode;
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
