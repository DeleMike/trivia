import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;

class ButtonPlaceholder extends StatefulWidget {
  final List answers;
  final void Function(String answer) theAnswer;
  final bool isDisabled;

  ButtonPlaceholder(this.answers, this.theAnswer, this.isDisabled);

  @override
  _ButtonPlaceholderState createState() => _ButtonPlaceholderState();
}

class _ButtonPlaceholderState extends State<ButtonPlaceholder> {
  var _selectedAnswer;
  var _selectedButtonColor = Colors.transparent;
  //var _selectedTextColor

  void _selectAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
    });
    widget.theAnswer(_selectedAnswer);
  }

  String _parsedHtmlString(String answer) {
    var doc = parser.parse(answer);
    String parsedStr = parser.parse(doc.body.text).documentElement.text;
    return parsedStr;
  }

  //_passValue
  @override
  Widget build(BuildContext context) {
    _selectedAnswer = widget.theAnswer;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widget.answers.map((answer) {
        //return each answer button
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: _selectedButtonColor,
            ),
            child: OutlinedButton(
              key: ValueKey('$answer'),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(_parsedHtmlString(answer)),
              ),
              onPressed: widget.isDisabled
                  ? null
                  : () {
                      _selectAnswer(answer);
                      print(
                          'Button PlacedHolder: SelectedAnswer = $_selectedAnswer');
                    },
            ),
          ),
        );
      }).toList(),
    );
  }
}
