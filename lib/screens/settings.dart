// import 'package:flutter/material.dart';
// import 'package:settings_ui/settings_ui.dart';
// import 'package:provider/provider.dart';
// import 'package:trivia/configs/routes.dart';

// import '../helpers/dark_theme_provider.dart';

// ///[Settings] screen is used to display user prefences options
// class Settings extends StatefulWidget {
//   @override
//   _SettingsState createState() => _SettingsState();
// }

// class _SettingsState extends State<Settings> {
//   bool _isDarkMode = false;
//   bool _isAppInDarkMode = false;

//   @override
//   Widget build(BuildContext context) {
//     // final themeChange = Provider.of<DarkThemeProvider>(context);
//     return Scaffold(
//       appBar: AppBar(title: Text('Settings')),
//       body: Container(
//         padding: const EdgeInsets.only(top: 1.0),
//         child: Consumer<DarkThemeProvider>(
//           builder: (_, theme, __) => SettingsList(
//             sections: [
//               SettingsSection(
//                 title: Text('Preferences'),
//                 // titleTextStyle: TextStyle(
//                 //     color: theme.darkTheme ? Colors.white : Colors.black),
//                 tiles: [
//                   SettingsTile.switchTile(
//                     title: Text('Dark Mode'),
//                     leading: Icon(
//                       _isDarkMode ? Icons.bedtime : Icons.bedtime_outlined,
//                       color: Colors.indigo[600],
//                     ),
//                     enabled:false,
//                     initialValue: theme.darkTheme,
//                     activeSwitchColor: Colors.indigo[600],
//                     onToggle: (bool val) {
//                       theme.darkTheme = val;
//                       print('Settings: Dark Mode = $val');
//                     },
//                   ),
//                   SettingsTile(
//                     title: Text('Update bio'),
//                     description: Text('Change your name and profile pic'),
//                     leading: Icon(
//                       theme.darkTheme ? Icons.person : Icons.person_outlined,
//                       color: Colors.indigo[600],
//                     ),
//                     onPressed: (ctx) {
//                       Navigator.of(context).pushNamed(Routes.auth);
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
