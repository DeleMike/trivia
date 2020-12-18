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
        //leading: Image.file(file),
        leading: FutureBuilder(
            future: Provider.of<UserPref>(context, listen: false).fetchData(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              return GestureDetector(
                onTap: () {
                  Scaffold.of(ctx).openDrawer();
                },
                child: Consumer<UserPref>(
                  builder: (_, userPref, __) => Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: CircleAvatar(
                      radius: 6,
                      backgroundImage: FileImage(
                          File(userPref.userData['imagepath']) == null
                              ? null
                              : File(userPref.userData['imagepath'])),
                    ),
                  ),
                ),
              );
            }),
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
