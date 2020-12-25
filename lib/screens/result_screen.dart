import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  static const routeName = '/result';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Trivia'),
      ),
      body: Center(
        child: Text('results page'),
      ),
    );
  }
}
