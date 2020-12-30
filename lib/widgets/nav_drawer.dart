import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia/helpers/dark_theme_provider.dart';

import '../screens/history_screen.dart';
import '../screens/settings.dart';

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
      ],
    );
    return Drawer(child: drawerItems);
  }
}
