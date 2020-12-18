import 'dart:io';

import 'package:flutter/material.dart';

import '../helpers/user_pref.dart';

class NavDrawer extends StatefulWidget {
  final String username;
  final File fileImage;

  NavDrawer({this.username, this.fileImage});

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String _username = '';
  File _imageFile;

  Future _getUserData() async {
    final userPref = UserPref();
    final userData = await userPref.fetchData();
    _username = userData['username'];
    final imageFilePath = userData['imagepath'];
    print('NavDrawer: username = $_username');
    print('NavDrawer: imageFilePath = $imageFilePath');
    _imageFile = File(imageFilePath);
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text('$_username'),
      accountEmail: null,
      currentAccountPicture: CircleAvatar(
        radius: 40,
        backgroundImage: _imageFile != null
            ? FileImage(_imageFile)
            : AssetImage('assets/images/app_icon.png'),
      ),
    );

    final drawerItems = ListView(
      children: [
        drawerHeader,
        InkWell(
          child: ListTile(
            title: Text('History'),
          ),
          onTap: () {},
        ),
        InkWell(
          child: ListTile(
            title: Text('Settings'),
          ),
          onTap: () {},
        ),
      ],
    );
    return Drawer(child: drawerItems);
  }
}
