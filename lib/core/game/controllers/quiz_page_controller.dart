import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;

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
  

  /// Returns clean and processed data
  Map<String, dynamic> get cleanedData => _cleanedData;

  /// Returns current question number
  int get currentQuestionNumber => _currentQuestionNumber;

  /// Returns a particular question
  Map<String, dynamic> get triviaSet => _triviaSet;

  /// Returns or Sets the selected answer
  String selectedAnswer = '';

  ///pre-porcess the data to readable form
  void preProcessData() {
    _cleanedData['questions'] = _convertQuestionToString(transportedData['questions']);
    _cleanedData['correct_answers'] = _convertCorrectAnswersToString(transportedData['correct_answers']);
    _cleanedData['incorrect_answers'] = _convertWrongAnswersToString(transportedData['wrong_answers']);

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

  /// update next question
  void getNextQuestion() {
    ++_currentQuestionNumber;
    _triviaSet['question'] = _cleanedData['questions'][_currentQuestionNumber];
    _triviaSet['correct_answer'] = _cleanedData['correct_answers'][_currentQuestionNumber];
    _triviaSet['incorrect_answers'] = _cleanedData['incorrect_answers'][_currentQuestionNumber];
    notifyListeners();
  }

}
