import 'package:flutter/material.dart';

import '../helpers/quiz_builder.dart';
import '../screens/quiz_page.dart';

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

  String _selectedDifficulty = 'easy';
  String _selectedQuestionType = 'True/False';
  String _numOfQuestions = '';
  String _typeTag = '';
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> _trySubmit() async {
    setState(() => _isLoading = true);
    _selectedQuestionType == 'True/False'
        ? _typeTag = 'boolean'
        : _typeTag = 'multiple';
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus(); //close keyboard

    //is valid, save data using shared pref
    if (isValid) {
      _formKey.currentState.save();

      print('numOfQuestions = $_numOfQuestions, selectedDifficulty = ' +
          ' $_selectedDifficulty, selectedQuestionType = $_typeTag');

      final quizBuilder = QuizBuilder();
      await quizBuilder.fetchAndSetQuestions(
        numOfQuestion: _numOfQuestions,
        difficulty: _selectedDifficulty,
        categoryTag: widget.categoryTag.toString(),
        type: _typeTag,
      );

      final result = quizBuilder.fetchedData;
      setState(() => _isLoading = false);
      print('BuildQuestionForm: Result = $result');
      //pass data to quiz page
      Navigator.of(context).pushNamed(QuizPage.routeName, arguments: {
        'results' : result,
        'difficulty' :  _selectedDifficulty,
        'type' : _typeTag,
      },);
    }
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child:
                    Text(widget.categoryName, style: TextStyle(fontSize: 20)),
              ),
              Divider(),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter number of questions',
                      border: UnderlineInputBorder(),
                      filled: true,
                    ),
                    validator: (value) {
                      if (value.isEmpty ||
                          (int.parse(value) <= 0 || int.parse(value) > 50)) {
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
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text('Difficulty:', style: TextStyle(fontSize: 16)),
                    ),
                    DropdownButton(
                      underline: Container(),
                      value: _selectedDifficulty,
                      onChanged: (newVal) {
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
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Question Type:',
                          style: TextStyle(fontSize: 16)),
                    ),
                    DropdownButton(
                      underline: Container(),
                      value: _selectedQuestionType,
                      onChanged: (newVal) {
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
              if(_isLoading)
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: CircularProgressIndicator(),
                ),
               if(!_isLoading) 
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: RaisedButton(
                    child: Text('Submit'),
                    onPressed: _trySubmit,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
