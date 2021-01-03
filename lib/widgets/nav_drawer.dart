import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/dark_theme_provider.dart';
import '../screens/history_screen.dart';
import '../screens/settings.dart';

///[NavDrawer] - displays all navigation drawer items.
class NavDrawer extends StatelessWidget {
  final String username;
  final File fileImage;

  NavDrawer({this.username, this.fileImage});

  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      accountName: Text('$username'),
      accountEmail: null,
      currentAccountPicture: CircleAvatar(
        radius: 40,
        backgroundImage: fileImage != null
            ? FileImage(fileImage)
            : AssetImage('assets/images/app_icon.png'),
      ),
    );

    final themeProvider = Provider.of<DarkThemeProvider>(context);

    final drawerItems = ListView(
      children: [
        Container(
          width: double.infinity,
          child: drawerHeader,
        ),
        InkWell(
          child: ListTile(
            leading: Icon(
              Icons.note,
              color: themeProvider.darkTheme
                  ? Theme.of(context).buttonTheme.colorScheme.surface
                  : Theme.of(context).primaryColor,
            ),
            title: Text(
              'History',
              style: TextStyle(
                fontStyle: FontStyle.normal,
                color: themeProvider.darkTheme
                    ? Theme.of(context).buttonTheme.colorScheme.surface
                    : Theme.of(context).primaryColor,
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).popAndPushNamed(HistoryScreen.routeName);
          },
        ),
        InkWell(
          child: ListTile(
            leading: Icon(
              Icons.settings,
              color: themeProvider.darkTheme
                  ? Theme.of(context).buttonTheme.colorScheme.surface
                  : Theme.of(context).primaryColor,
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                fontStyle: FontStyle.normal,
                color: themeProvider.darkTheme
                    ? Theme.of(context).buttonTheme.colorScheme.surface
                    : Theme.of(context).primaryColor,
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).popAndPushNamed(Settings.routeName);
          },
        ),
        InkWell(
          child: AboutListTile(
            icon: Icon(
              Icons.info_outline_rounded,
              color: themeProvider.darkTheme
                  ? Theme.of(context).buttonTheme.colorScheme.surface
                  : Theme.of(context).primaryColor,
            ),
            child: Text(
              'About',
              style: TextStyle(
                fontStyle: FontStyle.normal,
                color: themeProvider.darkTheme
                    ? Theme.of(context).buttonTheme.colorScheme.surface
                    : Theme.of(context).primaryColor,
              ),
            ),
             applicationName: 'Trivia',
              applicationVersion: '1.0.0',
              applicationIcon: Container(
                padding: const EdgeInsets.all(8.0),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                   borderRadius: BorderRadiusDirectional.circular(12),
                  color: Theme.of(context).primaryColor,
                ),
                child: Image.asset('assets/images/logo.png'),
              ),
              aboutBoxChildren: [
                Text('A trivia application to have fun, if you like!')
              ]
          ),
          
        ),
      ],
    );
    return Drawer(child: drawerItems);
  }
}
