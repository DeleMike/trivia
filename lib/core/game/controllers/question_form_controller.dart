import 'package:flutter/material.dart';

import '../../../configs/http_client.dart' as client;

class QuestionFormController with ChangeNotifier {
  String? _difficulty;
  String? _questionType;
  bool _isLoading = false;
  int _reponseCode = 0;
  List<dynamic> _results = [];
  List<String> _questions = [];
  List<String> _correctAnswers = [];
  List<List<dynamic>> _wrongAnswers = [];
  Map<String, List> _fetchedData = {};

  /// is data been fetched?
  bool get isLoading => _isLoading;

  /// get all data consisting of questions, correct answers, incorrect answers
  Map<String, List> get fetchedData => _fetchedData;

  /// process users selected type and fetch question resource
  Future<void> submitAndFetchQuestions(
    BuildContext context, {
    required String selectedQuestionType,
    required String selectedDifficulty,
    required int selectedCategory,
    required String selectedNumOfQuestions,
    required GlobalKey<FormState> formKey,
  }) async {
    selectedQuestionType == 'True/False' ? _questionType = 'boolean' : _questionType = 'multiple';
    _difficulty = selectedDifficulty.toLowerCase();

    final _isValid = formKey.currentState!.validate();

    debugPrint('Num of Questions = $selectedNumOfQuestions');

    FocusScope.of(context).unfocus();

    if (_isValid) {
      _isLoading = true;
      formKey.currentState!.save();

      debugPrint('numOfQuestions = $selectedNumOfQuestions, selectedDifficulty = '
          ' $_difficulty, selectedQuestionType = $_questionType'
          'categoryTag = $selectedCategory');

      try {
        var response = await client.HttpClient(resource: 'api.php/').get(data: {
          'amount': int.parse(selectedNumOfQuestions),
          'type': _questionType,
          'difficulty': _difficulty,
          'category': selectedCategory
        });

        _reponseCode = response['response_code'];

        if (_reponseCode == 1) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('trivia'),
                  content: Text(
                      'No data available for selected number of questions.\nPlease try to enter a lower value(e.g. 5)'),
                  actions: [ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('GOT IT'))],
                );
              });
        } else {
          //get results
          _results = response['results'];
          for (var result in _results) {
            _questions.add(result['question']);
            _correctAnswers.add(result['correct_answer']);
            _wrongAnswers.add(result['incorrect_answers']);
          }

          _fetchedData = {
            'questions': _questions,
            'correct_answers': _correctAnswers,
            'wrong_answers': _wrongAnswers,
          };

          debugPrint('FormController: FetchedData =  $_fetchedData');
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data Fetched')));
        }
        _isLoading = false;
      } catch (e) {
        _isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Data Fetch procedure failed')));
        throw ('Error Message: ' + e.toString());
      } finally {
        notifyListeners();
      }
    }
  }

  /// clear all variables old states
  void clearStates() {
    _isLoading = false;
    _reponseCode = 0;
    _results = [];
    _questions = [];
    _correctAnswers = [];
    _wrongAnswers = [];
    _fetchedData = {};

    debugPrint('QuestionFormController: All States Cleared');
  }
}
