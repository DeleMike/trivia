import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trivia')),
      body: Center(
        child: Text('Welcome screen'),
      ),
    );
  }
}
