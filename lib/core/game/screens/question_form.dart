import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/question_form_controller.dart';
import '../../../configs/constants.dart';
import '../../../configs/routes.dart';
import '../../../configs/app_extensions.dart';

class QuestionForm extends StatefulWidget {
  const QuestionForm({Key? key, required this.name, required this.imageUrl, required this.tag})
      : super(key: key);
  final String name;
  final String imageUrl;
  final int tag;

  @override
  State<QuestionForm> createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  static const _difficulties = [
    'Easy',
    'Medium',
    'Hard',
  ];

  static const _questionTypes = [
    'True/False',
    'Mutliple Choice',
  ];

  String _selectedDifficulty = 'Easy';
  String _selectedQuestionType = 'True/False';
  String _numOfQuestions = '';
  Map<String, dynamic> _data = {};

  final _formKey = GlobalKey<FormState>();

  final List<DropdownMenuItem<String>> _difficultyDropdownMenuItems = _difficulties.map((val) {
    return DropdownMenuItem<String>(value: val, child: Text(val));
  }).toList();

  final List<DropdownMenuItem<String>> _questionTypeDropdownMenuItems = _questionTypes.map((val) {
    return DropdownMenuItem<String>(value: val, child: Text(val));
  }).toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(top: kPaddingM, left: kPaddingS, right: kPaddingS),
              child: Row(
                children: [
                  Image.asset(
                    widget.imageUrl,
                    width: 100,
                    height: 100,
                    alignment: Alignment.topLeft,
                  ),
                  Expanded(
                    child: Text(widget.name.removeColon(),
                        textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline5),
                  ),
                ],
              ),
            ),
            const Divider(color: kCanvasColor),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'How many battle questions can you conquer?',
                      labelStyle: Theme.of(context).textTheme.bodyText2,
                      border: const UnderlineInputBorder(),
                      filled: true,
                      fillColor: kCanvasColor.withOpacity(0.3),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || !value.isNumeric()) {
                        return 'please enter a valid input';
                      }

                      if ((int.parse(value) <= 0 || int.parse(value) > 50)) {
                        return 'please enter a value between 1 and 50';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _numOfQuestions = value;
                    },
                    onSaved: (value) {
                      _numOfQuestions = value!;
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: kPaddingS, left: kPaddingS, right: kPaddingS),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Difficulty:', style: kGetQuestionFormHeaderTheme(context)),
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
              margin: const EdgeInsets.only(top: kPaddingS, left: kPaddingS, right: kPaddingS),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Questions form:', style: kGetQuestionFormHeaderTheme(context)),
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
            const SizedBox(height: 20),
            context.watch<QuestionFormController>().isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    margin: const EdgeInsets.all(kPaddingS),
                    child: ElevatedButton(
                      child: Text(
                        'Submit',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kWhite),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(kScreenWidth(context), kScreenHeight(context) * 0.05),
                        padding: const EdgeInsets.all(kPaddingM - 5),
                      ),
                      onPressed: () async {
                        await context.read<QuestionFormController>().submitAndFetchQuestions(context,
                            formKey: _formKey,
                            title: widget.name,
                            imageUrl: widget.imageUrl,
                            selectedDifficulty: _selectedDifficulty,
                            selectedCategory: widget.tag,
                            selectedNumOfQuestions: _numOfQuestions,
                            selectedQuestionType: _selectedQuestionType);
                        Navigator.pushNamed(context, Routes.quiz,
                            arguments: context.read<QuestionFormController>().fetchedData);
                        context.read<QuestionFormController>().clearStates();
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
