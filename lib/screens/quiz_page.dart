import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart' as parser;
import 'package:lottie/lottie.dart';

import '../helpers/dark_theme_provider.dart';
import '../widgets/question_num.dart';
import '../widgets/timer.dart' as t;
import '../widgets/question_placeholder.dart';
import '../widgets/button_placeholder.dart';
import '../helpers/trivia_history.dart';
import '../screens/view_answers.dart';
import '../screens/categories.dart';

///[QuizPage] screen used to display the main quiz board.
///It contains [QuestionNum], [t.Timer], [QuestionPlaceholder], [ButtonPlaceholder] widgets.
///
///All print statements are used for logging
class QuizPage extends StatefulWidget {
  static const routeName = '/quiz-page';
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Timer? _timer;
  var _currentTime = 20;
  var _durationTime = 20;
  var _data;
  var _isLoaded = false;
  var _currentQuestionNum = 0;
  var _totalQuestionNum;
  List<String>? _questions;
  var _currentQuestion;
  List<String>? _correctAnswers;
  List<List<dynamic>>? _incorrectAnswers;
  Map<String, List?> _answers = {
    'correct_answers': [],
    'incorrect_answers': [[]],
  };
  List _anAnswer = [];
  List<List> _allAnswers = [];
  String? _selectedAnswer = '';
  var _correctAnswer = '';
  var _isDisabled = false;
  var _isSavingData = false;
  var _buttonText = 'NEXT';
  var _score = 0;
  String? _dateTaken = '';
  String? _difficulty = '';
  String? _quizName = '';
  bool _isDoneWithQuiz = false;
  List _chosenAnswers = [];
  List _viewAnswersQuestions = [];
  List _viewAnswersCorrectAnswers = [];
  final animations = [
    'assets/animations/congratulation-success-batch.json',
    'assets/animations/thumb-up-party.json',
    'assets/animations/you-loss.json',
  ];

  ///this is used to load quiz board data instead of [initState] because we passed data
  ///through page routing.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isLoaded) {
      //if data is not loaded, then get data.
      //pass them into their respective variables
      _data = ModalRoute.of(context)!.settings.arguments as Map?;
      print('QuizPage: DataMap = $_data');
      _questions = _data['results']['questions'];
      _quizName = _data['quiz_name'];
      _difficulty = _data['difficulty'];
      _dateTaken = _data['date_taken'];
      _correctAnswers = _data['results']['correct_answer'];
      _incorrectAnswers = _data['results']['incorrect_answers'];
      _answers['correct_answers'] = _correctAnswers;
      _answers['incorrect_answers'] = _incorrectAnswers;
      print('\n\nQuizPage: Answers: $_answers');
      for (var i = 0; i < _correctAnswers!.length; i++) {
        _anAnswer.addAll(_answers['incorrect_answers']![i]);
        _anAnswer.add(_answers['correct_answers']![i]);
        _anAnswer..shuffle();
        _allAnswers.add(_anAnswer);
        //_allAnswers.shuffle();
        _anAnswer = [];
      }
      print('AllAnswers: $_allAnswers');

      _totalQuestionNum = _questions!.length;
      _currentQuestionNum == (_totalQuestionNum - 1)
          ? _buttonText = 'FINISH'
          : _buttonText = 'NEXT';
      _currentQuestion = _parsedHtmlString(_questions![_currentQuestionNum]);
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

  //DISCLAIMER: This only starts the timer after data has been loaded.
  void _startQuiz() {
    //if all data is loaded: start timer
    if (_isLoaded) {
      _startTimer(_currentTime);
    }
  }

  //go to next question or finish quiz
  void _moveToNext() {
    if (_buttonText == 'FINISH') {
      setState(() {
        if (_timer != null) {
          _timer!.cancel();
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
      //move to next question.
      setState(() {
        ++_currentQuestionNum;
        print('QuizPage: currentQuestionNum = $_currentQuestionNum');
        if (_currentQuestionNum + 1 < _totalQuestionNum) {
          _buttonText = 'NEXT';
        } else {
          _buttonText = 'FINISH';
        }

        if (_timer != null) {
          _timer!.cancel();
        }

        _currentQuestion = _parsedHtmlString(_questions![_currentQuestionNum]);
        _isDisabled = false;
        _currentTime = _durationTime;
        _selectedAnswer = '';
      });
    }
    _startQuiz();
  }

  //check if answer is correct
  void _checkAnswer(String? selectedAnswer) {
    _correctAnswer = _correctAnswers![_currentQuestionNum];
    if (selectedAnswer == _correctAnswer) {
      ++_score; //record quiz score
    }

    _chosenAnswers.insert(_currentQuestionNum, selectedAnswer);

    print('QuizPage: selectedAnswer: $_selectedAnswer');
    print('QuizPage: correctAnswer: $_correctAnswer');
  }

  //this is a func that reacts when ButtonPlaceholder is clicked.
  //It is used to retrieve the selceted answer by user
  void _onBtnClick(String? selectedAns) {
    _checkAnswer(selectedAns);
    //move to next question or finsih quiz
    _moveToNext();
  }

  //this is used to change the raw HTML markup into a readable form
  String _parsedHtmlString(String? question) {
    var doc = parser.parse(question);
    String parsedStr = parser.parse(doc.body!.text).documentElement!.text;
    return parsedStr;
  }

  //this is used to get an Animation appropraite to user's score.
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

  //After quiz, and if users desires to view their to view the correct answer,
  //then this will collect only correct answers that correpond to a particular question
  //and store as  in Map that will be passed when called upon.
  Map<String, List<String>> _buildViewAnswersTabView() {
    Map<String, List<String>> dataToPass = {
      'question': [],
      'answer': [],
    };
    List<String> questions = [];
    List<String> answers = [];
    for (var i = 0; i < _viewAnswersQuestions.length; i++) {
      questions.insert(i, _viewAnswersQuestions[i]);
      answers.insert(i, _viewAnswersCorrectAnswers[i]);
    }

    dataToPass['question'] = questions;
    dataToPass['answer'] = answers;

    return dataToPass;
  }

  //start timer widget countdown
  void _startTimer(int quizTime) {
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
              // print('Timer: Current time = $_currentTime remaining');
            });
          }
        }
      },
    );
  }

  //this affects the Current Chosen Answer Widget selected by user
  _onSelectAnswer(String? answer) {
    setState(() {
      _selectedAnswer = answer;
    });
  }

  //this displays an AlertDialog when user tries to close quiz while quiz is still ongoing.
  //it gives user the choice to forcefully quit or remain.
  Future<bool> _showDialog() async {
    var closeQuiz = false;
    await showDialog(
      context: context,
      builder: (context) {
        return Consumer<DarkThemeProvider>(
          builder: (_, theme, __) => AlertDialog(
            title: Text(
              'Message',
            ),
            content: Text(
              'Do you really want to exit quiz?',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 15,
                  ),
            ),
            actions: [
              FlatButton(
                child: Text(
                  'NO',
                  style: TextStyle(
                    color: theme.darkTheme
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                  ),
                ),
                splashColor: Colors.grey.withOpacity(0.1),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  'YES',
                  style: TextStyle(
                    color: theme.darkTheme
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                  ),
                ),
                splashColor: Colors.grey.withOpacity(0.1),
                onPressed: () {
                  closeQuiz = !closeQuiz;
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
    print('QuizPage: closeQuiz = $closeQuiz');
    return closeQuiz;
  }

  //do some house keeping
  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _showDialog(),
      child: Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: Text('Trivia'),
        // ),
        body: SafeArea(
          child: Builder(builder: (BuildContext context) {
            return Consumer<DarkThemeProvider>(
              builder: (_, theme, __) => SingleChildScrollView(
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
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 2,
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: QuestionPlaceholder(_currentQuestion),
                            ),
                            Divider(),
                            SizedBox(height: 8.0),
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: theme.darkTheme
                                    ? Colors.white
                                    : Colors.indigo[50],
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Your answer: ${_parsedHtmlString(_selectedAnswer)}',
                                style: TextStyle(
                                    color:
                                        theme.darkTheme ? Colors.black : null),
                              ),
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
                                  color: theme.darkTheme
                                      ? Colors.black
                                      : Colors.indigo[200]!,
                                  spreadRadius: theme.darkTheme ? 1 : 3,
                                  blurRadius: theme.darkTheme ? 0 : 16,
                                  offset: theme.darkTheme ? Offset(0, 0) : Offset(-2, 4),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 16),
                            child: RaisedButton(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
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
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Text(
                                                    'Your Score: $_score / $_totalQuestionNum',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6,
                                                  ),
                                                ),
                                                Container(
                                                  width: 300,
                                                  margin: const EdgeInsets.only(
                                                      top: 16.0,
                                                      left: 16.0,
                                                      right: 16.0),
                                                  child: OutlinedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        primary: theme.darkTheme
                                                            ? Colors.white
                                                            : Theme.of(context)
                                                                .primaryColor,
                                                        side: BorderSide(
                                                          color: theme.darkTheme
                                                              ? Colors.white
                                                              : Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: _isSavingData
                                                            ? CircularProgressIndicator()
                                                            : Text('FINISH'),
                                                      ),
                                                      onPressed: () async {
                                                        setState(() {
                                                          _isSavingData = true;
                                                        });
                                                        await Provider.of<
                                                                    TriviaHistory>(
                                                                context,
                                                                listen: false)
                                                            .addHistory(
                                                                _quizName,
                                                                _difficulty,
                                                                _dateTaken,
                                                                '$_score of $_totalQuestionNum');
                                                        print(
                                                            'QuizPage-Bottom Sheet: Pressed take-another button');
                                                        setState(() {
                                                          _isSavingData = false;
                                                        });
                                                        Navigator.of(context)
                                                            .popUntil((route) =>
                                                                route.settings
                                                                    .name ==
                                                                Categories
                                                                    .routeName);
                                                      }),
                                                ),
                                                Container(
                                                  width: 300,
                                                  margin: const EdgeInsets.all(
                                                      16.0),
                                                  child: OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      primary: theme.darkTheme
                                                          ? Colors.white
                                                          : Theme.of(context)
                                                              .primaryColor,
                                                      side: BorderSide(
                                                        color: theme.darkTheme
                                                            ? Colors.white
                                                            : Theme.of(context)
                                                                .primaryColor,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      child:
                                                          Text('VIEW ANSWERS'),
                                                    ),
                                                    onPressed: () {
                                                      var parsedQuestion = '';
                                                      var parsedAnswer = '';
                                                      print(
                                                          'QuizPage-Bottom Sheet: Pressed view-answers button');
                                                      for (var question
                                                          in _questions!) {
                                                        parsedQuestion =
                                                            _parsedHtmlString(
                                                                question);
                                                        _viewAnswersQuestions
                                                            .add(
                                                                parsedQuestion);
                                                      }

                                                      for (var answer
                                                          in _correctAnswers!) {
                                                        parsedAnswer =
                                                            _parsedHtmlString(
                                                                answer);
                                                        _viewAnswersCorrectAnswers
                                                            .add(parsedAnswer);
                                                      }
                                                      var tabs =
                                                          _buildViewAnswersTabView();
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              ViewAnswers
                                                                  .routeName,
                                                              arguments: tabs);
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
              ),
            );
          }),
        ),
      ),
    );
  }
}
