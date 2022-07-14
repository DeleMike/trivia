import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/quiz_page_controller.dart';
import '../../../configs/constants.dart';

class AnswersBox extends StatefulWidget {
  final List<String> answers;
  final void Function(String answer) selectedAnswer;
  final bool isDisabled;

  const AnswersBox({
    Key? key,
    required this.answers,
    required this.selectedAnswer,
    required this.isDisabled,
  }) : super(key: key);

  @override
  State<AnswersBox> createState() => _AnswersBoxState();
}

class _AnswersBoxState extends State<AnswersBox> {
  var _selectedAnswer;

  //used to select correct answer
  void _selectAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
    });
    widget.selectedAnswer(answer);
  }

  @override
  Widget build(BuildContext context) {
    _selectedAnswer = widget.selectedAnswer;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widget.answers.map((answer) {
        return Container(
          margin: const EdgeInsets.only(left: kPaddingM + 2, right: kPaddingM + 2, top: kPaddingM),
          decoration: const BoxDecoration(color: kTransparent),
          child: OutlinedButton(
            key: ValueKey(answer),
            style: OutlinedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              textStyle: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
              side: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark ? kWhite : kPrimaryColor,
                  width: 1.5),
            ),
            child: Padding(padding: const EdgeInsets.all(18.0), child: Text(answer, style: Theme.of(context).textTheme.headline6,)),
            onPressed: widget.isDisabled
                ? null
                : () {
                    _selectAnswer(answer);
                  },
          ),
        );
      }).toList(),
    );
  }
}
