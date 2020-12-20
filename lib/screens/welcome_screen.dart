import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/splash_screen.dart';
import '../screens/categories.dart';
import '../helpers/user_pref.dart';
import '../widgets/nav_drawer.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
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
                fileImage: File(
                  userPref.userData['imagepath'],
                ),
              ),
            );
          }),
      body: FutureBuilder(
          future: Provider.of<UserPref>(context, listen: false).fetchData(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            return SingleChildScrollView(
              child: Container(
                width: deviceSize.width,
                height: deviceSize.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        width: deviceSize.width * 0.2,
                        child: Image.asset('assets/images/app_icon.png'),
                      ),
                    ),
                    SizedBox(height: 25),
                    Consumer<UserPref>(
                      builder: (_, userPref, __) => Expanded(
                        child: Text(
                          'Welcome, ${userPref.userData['username']}',
                          style: TextStyle(
                            fontSize: 40,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2.5
                              ..color = Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'ready to test your knowledge ?',
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(16.0),
                            child: RaisedButton(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Text('Go'),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Categories.routeName);
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
