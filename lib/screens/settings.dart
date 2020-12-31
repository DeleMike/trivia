import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:provider/provider.dart';
import 'package:trivia/helpers/dark_theme_provider.dart';

class Settings extends StatefulWidget {
  static const routeName = 'settings';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var _value = false;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Container(
        padding: const EdgeInsets.only(top: 1.0),
        child: SettingsList(
          sections: [
            SettingsSection(
              title: 'Preferences',
              titleTextStyle: TextStyle(color: themeChange.darkTheme ? Colors.white: Colors.black),
              tiles: [
                SettingsTile.switchTile(
                  title: 'Dark Mode',
                  leading: Icon(_value ? Icons.bedtime : Icons.bedtime_outlined, color: Colors.indigo[600],),
                  switchValue: themeChange.darkTheme,
                  switchActiveColor : Colors.indigo[600],
                  onToggle: (bool val) {
                    themeChange.darkTheme = val;
                    print('Settings: Dark Mode = $val');
                  },
                ),
              ],
            )
          ],
        ),
      ),
      
    );
  }
}