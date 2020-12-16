import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Color(0xff3f51b5),
        canvasColor: Colors.indigo[50],
        fontFamily: 'Ubuntu',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
          bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
          headline6: TextStyle(
                fontSize: 12,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
              ),
        ) ,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Trivia'),
        ),
        body: Center(
            child: Text('Hello world!', style:  Theme.of(context).textTheme.headline6,),
          ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
