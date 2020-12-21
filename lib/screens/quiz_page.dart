import 'dart:async';

import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;

import '../widgets/question_num.dart';
import '../widgets/timer.dart' as t;
import '../widgets/question_placeholder.dart';

class QuizPage extends StatefulWidget {
  static const routeName = '/quiz-page';
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Timer _timer;
  int _start = 20;
  var _currentTime = 20;
  var _data;
  var isLoaded = false;
  var _currentQuestionNum = 0;
  var _totalQuestionNum;
  List<String> _questions;
  var _currentQuestion;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isLoaded) {
      _data = ModalRoute.of(context).settings.arguments as Map;
      _questions = _data['results']['questions'];
      _totalQuestionNum = _questions.length;
      _currentQuestion = parsedHtmlString(_questions[_currentQuestionNum]);
      var time = _data['difficulty'];
      if (time == 'easy') {
        _currentTime = 20;
      } else if (time == 'medium') {
        _currentTime = 30;
      } else {
        _currentTime = 40;
      }
      setState(() {
        isLoaded = true;
      });
    }
  }

  String parsedHtmlString(String question) {
    var doc = parser.parse(question);
    String parsedStr = parser.parse(doc.body.text).documentElement.text;
    return parsedStr;
  }
  
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
              _currentTime = --_start;
              print('Timer: Current time = $_currentTime remaining');
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
    // startTimer(20);
    //_startCountdown(_totalTime);
    return Scaffold(
      appBar: AppBar(
        title: Text('Trivia'),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(8.0),
                  child: QuestionNum(
                    (_currentQuestionNum + 1).toString(),
                    _totalQuestionNum.toString(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(8.0),
                  child: t.Timer(_currentTime),
                ),
              ],
            ),
            SizedBox(height: 25.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: QuestionPlaceholder(_currentQuestion),
            ),
            Divider(),
            SizedBox(height: 25.0),
          ],
        ),
      ),

      //current question display widget
      //Question display widget
      //a divider
      //Answer Button widget
      //next button widget
    );
  }

  final timer = LinearProgressIndicator();
}
