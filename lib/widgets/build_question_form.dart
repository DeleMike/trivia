import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helpers/quiz_builder.dart';
import '../screens/quiz_page.dart';
import '../screens/categories.dart';
import '../helpers/dark_theme_provider.dart';

///[BuildQuestionForm] is the form to collect data on how the [QuizPage] should look and have
class BuildQuestionForm extends StatefulWidget {
  final String categoryName;
  final int categoryTag;

  BuildQuestionForm(this.categoryName, this.categoryTag);

  @override
  _BuildQuestionFormState createState() => _BuildQuestionFormState();
}

class _BuildQuestionFormState extends State<BuildQuestionForm> {
  static const _difficulties = [
    'easy',
    'medium',
    'hard',
  ];

  static const _questionTypes = [
    'True/False',
    'Mutliple Choice',
  ];

  final List<DropdownMenuItem<String>> _difficultyDropdownMenuItems =
      _difficulties.map((val) {
    return DropdownMenuItem<String>(value: val, child: Text(val));
  }).toList();

  final List<DropdownMenuItem<String>> _questionTypeDropdownMenuItems =
      _questionTypes.map((val) {
    return DropdownMenuItem<String>(value: val, child: Text(val));
  }).toList();

  String _quizName = '';
  String? _selectedDifficulty = 'easy';
  String? _selectedQuestionType = 'True/False';
  String? _numOfQuestions = '';
  String _typeTag = '';
  bool _isLoading = false;
  final _quizBuilder = QuizBuilder();

  final _formKey = GlobalKey<FormState>();

  /// try to submit user data and get response.
  /// if ```_quizBuilder``` is empty prompt user on next steps 
  /// else move on and pass data to ```QuizPage```
  Future<void> _trySubmit() async {
    setState(() => _isLoading = true);
    _selectedQuestionType == 'True/False'
        ? _typeTag = 'boolean'
        : _typeTag = 'multiple';
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus(); //close keyboard

    //is valid, save data using shared pref
    if (isValid) {
      _formKey.currentState!.save();

      print('numOfQuestions = $_numOfQuestions, selectedDifficulty = ' +
          ' $_selectedDifficulty, selectedQuestionType = $_typeTag');

      await _quizBuilder.fetchAndSetQuestions(
        numOfQuestion: _numOfQuestions,
        difficulty: _selectedDifficulty,
        categoryTag: widget.categoryTag.toString(),
        type: _typeTag,
      );

      _checkValidResult(_quizBuilder);
    }
  }

  //check if http response contains values 
  void _checkValidResult(QuizBuilder quizBuilder) async {
    if (_quizBuilder.isEmpty) {
      _quizName = 'Any Category';
      setState(() => _isLoading = false);
      _showDialog();
    } else {
      final result = _quizBuilder.fetchedData;
      final dateFormat = DateFormat('dd/MM/yyyy');
      final date = dateFormat.format(DateTime.now());
      setState(() => _isLoading = false);
      print('BuildQuestionForm: Result = $result');
      //pass data to quiz page
      Navigator.of(context).pushReplacementNamed(
        QuizPage.routeName,
        arguments: {
          'results': result,
          'quiz_name': _quizName.length != 0 ? _quizName : widget.categoryName,
          'difficulty': _selectedDifficulty,
          'type': _typeTag,
          'date_taken': date,
        },
      );
    }
  }

  //alert dialog
  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Consumer<DarkThemeProvider>(
                      builder: (_, theme, __) => AlertDialog(
              title: Text(
                'Message',
              ),
              content: Text(
                'The questions are not available yet.'
                '\n\nPlease try again later or you can get the default questions',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 15,
                    ),
              ),
              actions: [
                if (_isLoading) Center(child: CircularProgressIndicator()),
                if (!_isLoading)
                  ElevatedButton(
                    child: Text('GET DEFAULT QUESTIONS',
                      style: TextStyle(color: theme.darkTheme ? Colors.white : Theme.of(context).primaryColor,),
                    ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    setState(() => _isLoading = true);
                    await _quizBuilder.fetchAndSetQuestions(
                      numOfQuestion: _numOfQuestions,
                      categoryTag: '0',
                      difficulty: _selectedDifficulty,
                      type: _typeTag,
                    );

                      _checkValidResult(_quizBuilder);
                    },
                  ),
                TextButton(
                  child: Text('OKAY', 
                    style: TextStyle(color: theme.darkTheme ? Colors.white : Theme.of(context).primaryColor,),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName(Categories.routeName));
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width * 0.85,
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Consumer<DarkThemeProvider>(
          builder: (_, themeProvider, __) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '${_isLoading ? 'Preparing your questions...' : widget.categoryName}',
                    style: TextStyle(
                      fontSize: 20,
                      color: themeProvider.darkTheme
                          ? Theme.of(context).buttonTheme.colorScheme!.surface
                          : null,
                    ),
                  ),
                ),
                Divider(),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: themeProvider.darkTheme
                              ? Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .surface
                              : null,
                        ),
                        //fillColor: themeProvider.darkTheme ? Theme.of(context).buttonTheme.colorScheme.surface: null,
                        labelText: 'Enter number of questions',
                        border: UnderlineInputBorder(),
                        filled: true,
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            (int.parse(value) <= 0 || int.parse(value) > 50)) {
                          setState(() => _isLoading = false);
                          return 'please enter a value between 0 and 50';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _numOfQuestions = value;
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: themeProvider.darkTheme
                        ? Colors.grey[700]
                        : Colors.grey[200],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Difficulty:',
                          style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.darkTheme
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      DropdownButton(
                        underline: Container(),
                        value: _selectedDifficulty,
                        onChanged: (dynamic newVal) {
                          setState(() {
                            _selectedDifficulty = newVal;
                          });
                        },
                        items: _difficultyDropdownMenuItems,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: themeProvider.darkTheme
                        ? Colors.grey[700]
                        : Colors.grey[200],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Question Type:',
                          style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.darkTheme
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      DropdownButton(
                        underline: Container(),
                        value: _selectedQuestionType,
                        onChanged: (dynamic newVal) {
                          setState(() {
                            _selectedQuestionType = newVal;
                          });
                        },
                        items: _questionTypeDropdownMenuItems,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                if (_isLoading)
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: CircularProgressIndicator(),
                  ),
                if (!_isLoading)
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      child: Text('Submit'),
                      onPressed: _trySubmit,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
