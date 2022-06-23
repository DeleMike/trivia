import 'package:flutter/material.dart';

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
          ' $_difficulty, selectedQuestionType = $_questionType');

      try {
        //simulate fetching data
        await Future.delayed(const Duration(seconds: 1));
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
