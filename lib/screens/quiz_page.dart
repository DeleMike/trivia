import 'dart:async';

import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;

import '../widgets/question_num.dart';
import '../widgets/timer.dart' as t;
import '../widgets/question_placeholder.dart';
import '../widgets/button_placeholder.dart';

class QuizPage extends StatefulWidget {
  static const routeName = '/quiz-page';
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Timer _timer;
  var _currentTime = 20;
  var _durationTime = 20;
  var _data;
  var _isLoaded = false;
  var _currentQuestionNum = 0;
  var _totalQuestionNum;
  List<String> _questions;
  var _currentQuestion;
  List<String> _correctAnswers;
  List<List<dynamic>> _incorrectAnswers;
  Map<String, List> _answers = {
    'correct_answers': [],
    'incorrect_answers': [[]],
  };
  List _anAnswer = [];
  List<List> _allAnswers = [];
  var _selectedAnswer = '';
  var _correctAnswer = '';
  var _isDisabled = false;
  var _buttonText = 'NEXT';
  var _score = 0;
  bool _isDoneWithQuiz = false;
  List _chosenAnswers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isLoaded) {
      _data = ModalRoute.of(context).settings.arguments as Map;
      print('QuizPage: DataMap = $_data');
      _questions = _data['results']['questions'];
      _correctAnswers = _data['results']['correct_answer'];
      _incorrectAnswers = _data['results']['incorrect_answers'];
      _answers['correct_answers'] = _correctAnswers;
      _answers['incorrect_answers'] = _incorrectAnswers;
      print('\n\nQuizPage: Answers: $_answers');
      for (var i = 0; i < _correctAnswers.length; i++) {
        _anAnswer.add(_answers['correct_answers'][i]);
        _anAnswer.addAll(_answers['incorrect_answers'][i]);
        _allAnswers.insert(i, _anAnswer);
        _allAnswers.shuffle();
        _anAnswer = [];
      }
      print('AllAnswers: $_allAnswers');

      _totalQuestionNum = _questions.length;
      _currentQuestionNum == (_totalQuestionNum - 1)
          ? _buttonText = 'FINISH'
          : _buttonText = 'NEXT';
      _currentQuestion = parsedHtmlString(_questions[_currentQuestionNum]);
      var time = _data['difficulty'];
      if (time == 'easy') {
        _currentTime = 20;
        _durationTime = 20;
      } else if (time == 'medium') {
        _currentTime = 30;
        _durationTime = 30;
      } else {
        _currentTime = 40;
        _durationTime = 40;
      }
      setState(() {
        _isLoaded = true;
      });
      _startQuiz();
    }
  }

  void _startQuiz() {
    //if all data is loaded: start timer
    if (_isLoaded) {
      startTimer(_currentTime);
    }
  }

  void _moveToNext() {
    //go to current question or finish quiz
    if (_buttonText == 'FINISH') {
      setState(() {
        if (_timer != null) {
          _timer.cancel();
        }
        _currentTime = 0;
        _isDoneWithQuiz = true;
      });

      //end quiz
      //data to be passed
      print('QuizPage: Quiz result = $_score/$_totalQuestionNum');
      print('QuizPage: chosenAnswers = $_chosenAnswers');
      print('QuizPage: correctAnswers = $_correctAnswers');
    } else {
      setState(() {
        ++_currentQuestionNum;
        print('QuizPage: currentQuestionNum = $_currentQuestionNum');
        if (_currentQuestionNum + 1 < _totalQuestionNum) {
          _buttonText = 'NEXT';
        } else {
          _buttonText = 'FINISH';
        }

        if (_timer != null) {
          _timer.cancel();
        }

        _currentQuestion = parsedHtmlString(_questions[_currentQuestionNum]);
        _isDisabled = false;
        _currentTime = _durationTime;
        _selectedAnswer = '';
      });
    }
    _startQuiz();
  }

  void _checkAnswer(String selectedAnswer) {
    //check if answer is correct
    _correctAnswer = _correctAnswers[_currentQuestionNum];
    if (selectedAnswer == _correctAnswer) {
      ++_score; //record quiz score
    }

    _chosenAnswers.insert(_currentQuestionNum, selectedAnswer);

    print('QuizPage: selectedAnswer: $_selectedAnswer');
    print('QuizPage: correctAnswer: $_correctAnswer');
  }

  void _onBtnClick(String selectedAns) {
    _checkAnswer(selectedAns);
    //move to next question or finsih quiz
    _moveToNext();
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
        //if time is 0, then automatically disable buttons
        if (_currentTime == 0) {
          if (mounted) {
            setState(() {
              if (timer != null) {
                timer.cancel();
              }
              _isDisabled = true;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              --_currentTime;
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

  _onSelectAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trivia'),
      ),
      body: Builder(builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.all(8.0),
                    child: QuestionNum(
                      (_currentQuestionNum + 1).toString(),
                      _totalQuestionNum.toString(),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.all(8.0),
                    child: t.Timer(_currentTime),
                  ),
                ],
              ),
              SizedBox(height: 25.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: QuestionPlaceholder(_currentQuestion),
                      ),
                      Divider(),
                      SizedBox(height: 8.0),
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.indigo[50],
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Your answer: $_selectedAnswer'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: ButtonPlaceholder(
                          _allAnswers[_currentQuestionNum],
                          _onSelectAnswer,
                          _isDisabled,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo[200],
                            spreadRadius: 3,
                            blurRadius: 16,
                            offset: Offset(-2, 4),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 16),
                      child: RaisedButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text('${_isDoneWithQuiz ? 'DONE' : _buttonText}'),
                        ),
                        onPressed: () {
                          if (_isDoneWithQuiz) {
                            print('FINISHED');
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Theme.of(context).primaryColor,
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                              content:
                                  Text('Results: $_score/$_totalQuestionNum'
                                      '\n...to display results on the next page.'),
                              action: SnackBarAction(
                                textColor: Theme.of(context).buttonTheme.colorScheme.surface,
                                label: 'OKAY',
                                onPressed: () {},
                              ),
                            ));
                          } else {
                            _onBtnClick(_selectedAnswer);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
