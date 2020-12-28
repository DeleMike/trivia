import 'dart:io';

import 'package:flutter/material.dart';

import '../screens/history_screen.dart'; 

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
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(HistoryScreen.routeName);
          },
        ),
        InkWell(
          child: ListTile(
            title: Text(
              'Settings',
              style: TextStyle(
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    return Drawer(child: drawerItems);
  }
}
