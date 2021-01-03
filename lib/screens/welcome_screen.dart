import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/dark_theme_provider.dart';
import '../widgets/splash_screen.dart';
import '../screens/categories.dart';
import '../helpers/user_pref.dart';
import '../widgets/nav_drawer.dart';

///[WelcomeScreen] - this is the first screen of the app. It will be used to show greeting section basically.
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
            return Consumer<DarkThemeProvider>(
              builder: (_, themeProvider, __) => SingleChildScrollView(
                child: Container(
                  width: deviceSize.width,
                  height: deviceSize.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          width: deviceSize.width * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(12),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Image.asset('assets/images/logo.png'),
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
                                ..color = themeProvider.darkTheme
                                    ? Theme.of(context)
                                        .buttonTheme
                                        .colorScheme
                                        .surface
                                    : Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'ready to test your knowledge ?',
                          style: TextStyle(
                            color: themeProvider.darkTheme
                                ? Theme.of(context)
                                    .buttonTheme
                                    .colorScheme
                                    .surface
                                : Theme.of(context).primaryColor,
                          ),
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
                                onPressed: () async {
                                  try {
                                    final result = await InternetAddress.lookup(
                                        'google.com');
                                    if (result.isNotEmpty &&
                                        result[0].rawAddress.isNotEmpty) {
                                      print('connected to a network');
                                      Navigator.pushNamed(
                                          context, Categories.routeName);
                                    }
                                  } on SocketException catch (_) {
                                    print('Not connected to internet');
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Message'),
                                        content: Text(
                                          'No network connection. Please connect and try again',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                fontSize: 15,
                                              ),
                                        ),
                                        actions: [
                                          FlatButton(
                                              child: Text(
                                                'OKAY',
                                                style: TextStyle(
                                                  color: themeProvider.darkTheme
                                                      ? Colors.white
                                                      : Colors.indigo,
                                                ),
                                              ),
                                              splashColor:
                                                  Colors.grey.withOpacity(0.1),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              })
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
