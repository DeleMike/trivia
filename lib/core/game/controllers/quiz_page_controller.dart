import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;

class QuizPageController with ChangeNotifier {
  /// Get fetched data from
  Map transportedData = {};
  // List _questions = [];
  // List _correct_answers = [];
  // List _incorrect_answers = [[], []];
  final Map<String, dynamic> _cleanedData = {
    'questions': [],
    'correct_answers': [],
    'incorrect_answers': [],
  };

  Map<String, dynamic> get cleanedData => _cleanedData;

  ///pre-porcess the data to readable form
  void preProcessData() {
    _cleanedData['questions'] = _convertQuestionToString(transportedData['questions']);
    _cleanedData['correct_answers'] = _convertCorrectAnswersToString(transportedData['correct_answers']);
    _cleanedData['incorrect_answers'] = _convertWrongAnswersToString(transportedData['wrong_answers']);
  }

  /// process data
  String changeHTMLtoString(String text) {
    var doc = parser.parse(text);
    String parsedStr = parser.parse(doc.body!.text).documentElement!.text;
    return parsedStr;
  }

  List<String> _convertQuestionToString(List dataList) {
    List<String> questions = [];
    for (String item in dataList) {
      questions.add(changeHTMLtoString(item));
    }
    return questions;
  }

  List<String> _convertCorrectAnswersToString(List dataList) {
    List<String> correctAnswers = [];
    for (String item in dataList) {
      correctAnswers.add(changeHTMLtoString(item));
    }
    return correctAnswers;
  }

  List<List<String>> _convertWrongAnswersToString(List<List> dataList) {
    List<List<String>> wrongAnswers = [];

    for (var listofAnswers in dataList) {
      List<String> answers = [];
      for (String answer in listofAnswers) {
        answers.add(changeHTMLtoString(answer));
      }

      wrongAnswers.add(answers);
    }

    return wrongAnswers;
  }
}
