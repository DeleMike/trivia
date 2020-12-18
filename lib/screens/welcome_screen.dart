import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/user_pref.dart';
import '../widgets/nav_drawer.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trivia'),
      ),
      drawer: FutureBuilder(
          future: Provider.of<UserPref>(context, listen: false).fetchData(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }
            return Consumer<UserPref>(
              builder: (_, userPref, __) => NavDrawer(
                  username: userPref.userData['username'],
                  fileImage: File(userPref.userData['imagepath'])),
            );
          }),
      body: Center(
        child: Text('Welcome screen'),
      ),
    );
  }
}
