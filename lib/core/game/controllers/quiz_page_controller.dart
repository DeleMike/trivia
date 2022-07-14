import 'dart:async';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:html/parser.dart' as parser;
import 'package:trivia/configs/constants.dart';

import '../../../helpers/trivia_history.dart';

class QuizPageController with ChangeNotifier {
  /// Get fetched data from
  Map transportedData = {};
  final Map<String, dynamic> _cleanedData = {
    'questions': [],
    'correct_answers': [],
    'incorrect_answers': [],
  };
  final Map<String, dynamic> _triviaSet = {
    'question': '',
    'correct_answer': '',
    'incorrect_answers': [],
    'answers': [],
    'total_question_length': 0,
  };

  int _currentQuestionNumber = 0;
  bool _isDoneWithQuiz = false;
  int _score = 0;
  Timer? _timer;
  double _timeCounter = 0;
  int _timerLength = 0;
  int _totalQuizLength = kTimeLengthForEasyDifficulty;
  bool _isDisabled = false;

  /// Returns clean and processed data
  Map<String, dynamic> get cleanedData => _cleanedData;

  /// Returns current question number
  int get currentQuestionNumber => _currentQuestionNumber;

  /// Returns a particular question
  Map<String, dynamic> get triviaSet {
    debugPrint('Trivia list is now: $_triviaSet');
    return _triviaSet;
  }

  /// Returns or Sets the selected answer
  String selectedAnswer = '';

  /// Returns a boolean value. Returns ```true``` if user is done with quiz
  bool get isDoneWithQuiz => _isDoneWithQuiz;

  /// Returns user score;
  int get score => _score;

  ///
  bool get isDisabled => _isDisabled;

  ///
  int get timeLength => _timerLength;

  double get timeCounter => _timeCounter;

  ///pre-porcess the data to readable form
  void preProcessData() {
    _cleanedData['questions'] = _convertQuestionToString(transportedData['questions']);
    _cleanedData['correct_answers'] = _convertCorrectAnswersToString(transportedData['correct_answers']);
    _cleanedData['incorrect_answers'] = _convertWrongAnswersToString(transportedData['wrong_answers']);

    if ((transportedData['selectedDifficulty'] as String).toLowerCase() == 'hard') {
      _totalQuizLength = kTimeLengthForHardDifficulty;
    } else if ((transportedData['selectedDifficulty'] as String).toLowerCase() == 'medium') {
      _totalQuizLength = kTimeLengthForMediumDifficulty;
    }

    // final questions = [..._cleanedData['questions']];

    // _totalNumOfQuestions = questions.length;
    final List<String> allAnswers = [
      _cleanedData['correct_answers'][_currentQuestionNumber],
      ..._cleanedData['incorrect_answers'][_currentQuestionNumber]
    ];

    // update for first question
    _triviaSet['question'] = _cleanedData['questions'][_currentQuestionNumber];
    _triviaSet['correct_answer'] = _cleanedData['correct_answers'][_currentQuestionNumber];
    _triviaSet['incorrect_answers'] = _cleanedData['incorrect_answers'][_currentQuestionNumber];
    _triviaSet['answers'] = allAnswers..shuffle();
    _triviaSet['total_question_length'] = _cleanedData['questions'].length;

    debugPrint('All Answers list is now: ${_triviaSet['answers']}');
    debugPrint('QPage Controller: fetched Data is = $transportedData');
    _isDoneWithQuiz = (_currentQuestionNumber + 1) == _cleanedData['questions'].length;
  }

  //start timer widget countdown
  void startTimer(BuildContext context) {
    debugPrint('Total Time for Quiz is: ${_totalQuizLength}s');
    const oneSec = Duration(seconds: 1);
    _isDisabled = false;
    _timer = Timer.periodic(oneSec, (Timer timer) {
      //if time is 0, then automatically disable buttons
      if (_timerLength == _totalQuizLength) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'Okay',
              textColor: Theme.of(context).brightness == Brightness.dark ? kWhite : kPrimaryColor,
              onPressed: () {},
            ),
            content: Padding(
              padding: const EdgeInsets.all(kPaddingS + 2),
              child: Text(
                'No data updated',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
        _timer!.cancel();
        _isDisabled = true;
      } else {
        ++_timerLength;
        _timeCounter = double.parse((_timerLength / _totalQuizLength.toDouble()).toStringAsFixed(2));
        debugPrint('Timer: Current time = $_timerLength remaining');
        debugPrint('Linear Progress Updator: $_timeCounter');
      }
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer!.cancel();
    _timerLength = 0;
    notifyListeners();
  }

  /// process data
  String _changeHTMLtoString(String text) {
    var doc = parser.parse(text);
    String parsedStr = parser.parse(doc.body!.text).documentElement!.text;
    return parsedStr;
  }

  /// convert html questions to strings
  List<String> _convertQuestionToString(List dataList) {
    List<String> questions = [];
    for (String item in dataList) {
      questions.add(_changeHTMLtoString(item));
    }
    return questions;
  }

  /// convert html correct answers to strings
  List<String> _convertCorrectAnswersToString(List dataList) {
    List<String> correctAnswers = [];
    for (String item in dataList) {
      correctAnswers.add(_changeHTMLtoString(item));
    }
    return correctAnswers;
  }

  /// convert html wrong answers to strings
  List<List<String>> _convertWrongAnswersToString(List<List> dataList) {
    List<List<String>> wrongAnswers = [];

    for (var listofAnswers in dataList) {
      List<String> answers = [];
      for (String answer in listofAnswers) {
        answers.add(_changeHTMLtoString(answer));
      }

      wrongAnswers.add(answers);
    }

    return wrongAnswers;
  }

  /// Check if right answer
  void evaluateUserChoice(String chosenAnswer) {
    stopTimer();
    String correctAnswer = _triviaSet['correct_answer'];
    if (correctAnswer == chosenAnswer) {
      debugPrint('Right Answer chosen');
      _score++;
    } else {
      debugPrint('Wrong Answer chosen');
    }

    debugPrint('Right answer: ${_triviaSet['correct_answer']}');
  }

  /// update next question
  ///
  /// Also, checks if the user is at the last question
  void getNextQuestion(BuildContext context) {
    _currentQuestionNumber = _currentQuestionNumber + 1;
    if (_currentQuestionNumber >= (_cleanedData['questions'].length - 1)) {
      _isDoneWithQuiz = true;
      _currentQuestionNumber = _cleanedData['questions'].length - 1;
    }
    debugPrint('Current Question Number: $_currentQuestionNumber');
    _triviaSet['question'] = _cleanedData['questions'][_currentQuestionNumber];
    _triviaSet['correct_answer'] = _cleanedData['correct_answers'][_currentQuestionNumber];
    _triviaSet['incorrect_answers'] = _cleanedData['incorrect_answers'][_currentQuestionNumber];
    final List<String> allAnswers = [
      _cleanedData['correct_answers'][_currentQuestionNumber],
      ..._cleanedData['incorrect_answers'][_currentQuestionNumber]
    ];
    _triviaSet['answers'] = allAnswers..shuffle();
    startTimer(context);
    notifyListeners();
  }

  /// Save result to DB
  Future<void> savetoDB(BuildContext context, {required int score, required int totalQuestion}) async {
    final dateFormat = DateFormat('dd/MM/yyyy @ H:m:s');
    final date = dateFormat.format(DateTime.now());
    int scorePercentage = ((score / totalQuestion) * 100).toInt();

    // save to db
    await context.read<TriviaHistory>().addHistory(
          quizName: transportedData['title'],
          imageUrl: transportedData['imageUrl'],
          difficulty: transportedData['selectedDifficulty'],
          scorePercentage: scorePercentage.toString(),
          dateTaken: date,
        );

    debugPrint('QuizPageController: Date = $date');
    debugPrint('QuizPageController: quizName = ${transportedData['title']}');
    debugPrint('QuizPageController: img-url = ${transportedData['imageUrl']}');
    debugPrint('QuizPageController: difficulty = ${transportedData['selectedDifficulty']}');

    debugPrint('QuizPageController: Saved to DB');

    notifyListeners();
  }

  void clearResources() {
    transportedData.clear();
    _cleanedData.clear();
    _triviaSet.clear();
    _currentQuestionNumber = 0;
    _isDoneWithQuiz = false;
    _score = 0;
    _timer!.cancel();
    _timeCounter = 0;
    _timerLength = 0;
    _totalQuizLength = kTimeLengthForEasyDifficulty;
    _isDisabled = false;
    debugPrint('Clear Quiz Page states');
  }
}
