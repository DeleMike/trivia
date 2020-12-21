import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

import '../widgets/timer.dart' as t;

class QuizPage extends StatefulWidget {
  static const routeName = '/quiz-page';
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // CountdownTimer _countDownTimer;
  // int _totalTime = 20;
  // int _currentTime = 0;
  Timer _timer;
  int _start = 20;
  var _indicatorVal = 0.0;

  void startTimer(int quizTime) {
    const oneSec = const Duration(seconds: 1);

    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          if (mounted) {
            setState(() {
              if (timer != null) {
                timer.cancel();
              }
            });
          }
        } else {
          if (mounted) {
            setState(() {
              int currentTime = --_start;
              print('Timer: Current time = $currentTime seconds used up');
              // print('Timer: indicator value = ${((currentTime / quizTime).toStringAsFixed(2))}');
              // _indicatorVal = double.parse((currentTime / quizTime).toStringAsFixed(2));
              _indicatorVal = currentTime.toDouble();
              
            });
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    startTimer(20);
    //_startCountdown(_totalTime);
    return Scaffold(
      appBar: AppBar(
        title: Text('Trivia'),
      ),

      body: Center(
        child: t.Timer(_indicatorVal),
      ),

      //LinearProgressIndicator widget as a timer
      //current question display widget
      //Question display widget
      //a divider
      //Answer Button widget
      //next button widget
    );
  }

  final timer = LinearProgressIndicator();
}
