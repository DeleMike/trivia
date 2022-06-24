import 'package:flutter/material.dart';

import '../../../configs/http_client.dart' as client;

class QuestionFormController with ChangeNotifier {
  String? _difficulty;
  String? _questionType;
  bool _isLoading = false;

  /// is data been fetched?
  bool get isLoading => _isLoading;

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
          ' $_difficulty, selectedQuestionType = $_questionType' 'categoryTag = $selectedCategory');

      try {
       
        await client.HttpClient(resource: 'api.php/').get(data: {
          'amount': int.parse(selectedNumOfQuestions),
          'type': _questionType,
          'difficulty': _difficulty,
          'category': selectedCategory
        });

        Navigator.pop(context); 
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data Fetched')));
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
}
