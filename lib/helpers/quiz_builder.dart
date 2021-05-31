import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

///[QuizBuilder] - handles all quiz's data handling
class QuizBuilder with ChangeNotifier {
  List<String?> _questions = [];
  List<String?> _correctAnswers = [];
  List<List<dynamic>?> _incorrectAnswers = [];
  Map<String, List>? _fetchedData;
  bool _isEmpty = false;

  Map<String, List>? get fetchedData {
    return _fetchedData != null ? _fetchedData : null;
  }

  bool get isEmpty {
    return _isEmpty;
  }

  ///fetch questions from api
  Future<void> fetchAndSetQuestions({
    required String? numOfQuestion,
    required String categoryTag,
    required String? difficulty,
    required String type,
  }) async {
    //set data and send request
    final String url = 'www.opentdb.com';
    final queryParameters = {
      'amount': numOfQuestion,
      'category': categoryTag,
      'difficulty': difficulty,
      'type': type,
    };

    final uri = Uri.https(url, '/api.php', queryParameters);
    print('QuizBuilder: URL TO DB = $uri');

    //get response and group data
    final response = await http.get(uri);
    print('QuizBuilder: Response from request sent = ${response.body}');

    final List result = json.decode(response.body)['results'];
    if (result.isEmpty) {
      _isEmpty = true;
      print('QuizBuilder: response returned no result');
    } else {
      _isEmpty = false;
      result.forEach((res) {
        _questions.add(res['question']);
        _correctAnswers.add(res['correct_answer']);
        _incorrectAnswers.add(res['incorrect_answers']);
      });

      print('QuizBuilder: question = $_questions');
      print('QuizBuilder: correct_answers = $_correctAnswers');
      print('QuizBuilder: incorrect_answers = $_incorrectAnswers');

      _fetchedData = {
        'questions': _questions,
        'correct_answer': _correctAnswers,
        'incorrect_answers': _incorrectAnswers,
      };
      print('QuizBuilder: data = $_fetchedData');
    }
    notifyListeners();
  }
}
