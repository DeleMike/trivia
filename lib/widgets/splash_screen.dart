import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/dark_theme_provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              
              padding: const EdgeInsets.all(8.0),
              width: 80,
              decoration: BoxDecoration(
                 borderRadius: BorderRadiusDirectional.circular(12),
                color: Theme.of(context).primaryColor,
              ),
              child: Image.asset('assets/images/logo.png'),
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
    );
  }
}
