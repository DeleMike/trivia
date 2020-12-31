import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/dark_theme_provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
          builder: (_, themeProvider, __) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 80,
                decoration: BoxDecoration(),
                child:  themeProvider.darkTheme ? null : Image.asset('assets/images/app_icon.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '...testing your knowledge.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
      ),
    );
  }
}
