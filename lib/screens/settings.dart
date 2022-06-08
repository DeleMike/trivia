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
                title: Text('Preferences'),
                // titleTextStyle: TextStyle(
                //     color: theme.darkTheme ? Colors.white : Colors.black),
                tiles: [
                  SettingsTile.switchTile(
                    title: Text('Dark Mode'),
                    leading: Icon(
                      _isDarkMode ? Icons.bedtime : Icons.bedtime_outlined,
                      color: Colors.indigo[600],
                    ),
                    enabled: !theme.isAppDefaultThemeActive,
                    initialValue: theme.darkTheme,
                    activeSwitchColor: Colors.indigo[600],
                    onToggle: (bool val) {
                      theme.darkTheme = val;
                      print('Settings: Dark Mode = $val');
                    },
                  ),
                  SettingsTile(
                    title: Text('Update bio'),
                    description: Text('Change your name and profile pic'),
                    leading: Icon(
                      theme.darkTheme ? Icons.person : Icons.person_outlined,
                      color: Colors.indigo[600],
                    ),
                    onPressed: (ctx) {
                      Navigator.of(context).pushNamed(AuthScreen.routeName);
                    },
                  ),
                  SettingsTile.switchTile(
                    title: Text('System default theme'),
                    description: Text('Apply your phone\'s current theme to this app'),
                    leading: Icon(
                      _isDarkMode ? Icons.circle : Icons.circle_outlined,
                      color: Colors.indigo[600],
                    ),
                    initialValue: theme.isAppDefaultThemeActive,
                    activeSwitchColor: Colors.indigo[600],
                    onToggle: (bool val) {
                      theme.darkTheme = false;
                      //change toggle option
                      theme.isAppDefaultThemeActive = val;
                      var brightness =
                          MediaQuery.of(context).platformBrightness;

                      if (theme.isAppDefaultThemeActive) {
                        //get app current settings
                        _isAppInDarkMode = brightness == Brightness.dark;
                      }
                     // print('Settings: isAppInDarkMode = $_isAppInDarkMode');
                      theme.darkTheme = _isAppInDarkMode;
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
