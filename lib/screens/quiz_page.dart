import 'dart:async';

import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:lottie/lottie.dart';

import '../widgets/question_num.dart';
import '../widgets/timer.dart' as t;
import '../widgets/question_placeholder.dart';
import '../widgets/button_placeholder.dart';
import '../screens/result_screen.dart';

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
  final animations = [
    'assets/animations/congratulation-success-batch.json',
    'assets/animations/thumb-up-party.json',
    'assets/animations/you-loss.json',
  ];

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

  Widget _resultAnimation() {
    if (_score == 0) {
      return Lottie.asset(
        animations[2],
        width: 200,
        height: 200,
        fit: BoxFit.fill,
      );
    } else if (_score == _totalQuestionNum) {
      return Lottie.asset(
        animations[0],
        width: 200,
        height: 200,
        fit: BoxFit.fill,
      );
    } else {
      return Lottie.asset(
        animations[1],
        width: 200,
        height: 200,
        fit: BoxFit.fill,
      );
    }
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

  Future<bool> _showDialog() async {
    var closeQuiz = false;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Message',
          ),
          content: Text(
            'Do you really want to exit quiz?',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 15,
                ),
          ),
          actions: [
            FlatButton(
              child: Text('NO'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('YES'),
              onPressed: () {
                closeQuiz = !closeQuiz;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    print('QuizPage: closeQuiz = $closeQuiz');
    return closeQuiz;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _showDialog(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      padding: const EdgeInsets.all(8.0),
                      child: QuestionNum(
                        (_currentQuestionNum + 1).toString(),
                        _totalQuestionNum.toString(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      padding: const EdgeInsets.all(8.0),
                      child: t.Timer(_currentTime),
                    ),
                  ],
                ),
                SizedBox(height: 25.0),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                            child: Text(
                                '${_isDoneWithQuiz ? 'DONE' : _buttonText}'),
                          ),
                          onPressed: () {
                            if (_isDoneWithQuiz) {
                              print('FINISHED');
                              //Navigator.of(context).pushReplacementNamed(ResultScreen.routeName);
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.0),
                                  )),
                                  context: context,
                                  builder: (_) {
                                    return GestureDetector(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            _resultAnimation(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                'Your Score: $_score / $_totalQuestionNum',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6,
                                              ),
                                            ),
                                            //TODO: Make all buttons do their respective tasks.
                                            Container(
                                              width: 300,
                                              margin: const EdgeInsets.only(
                                                  top: 16.0,
                                                  left: 16.0,
                                                  right: 16.0),
                                              child: OutlinedButton(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Text('FINISH'),
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'QuizPage-Bottom Sheet: Pressed finish button');
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: 300,
                                              margin: const EdgeInsets.only(
                                                  top: 16.0,
                                                  left: 16.0,
                                                  right: 16.0),
                                              child: OutlinedButton(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Text('TAKE ANOTHER'),
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'QuizPage-Bottom Sheet: Pressed take-another button');
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: 300,
                                              margin:
                                                  const EdgeInsets.all(16.0),
                                              child: OutlinedButton(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Text('VIEW ANSWERS'),
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'QuizPage-Bottom Sheet: Pressed view-answers button');
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {},
                                      behavior: HitTestBehavior.opaque,
                                    );
                                  });
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
      ),
    );
  }
}
