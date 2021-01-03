import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:provider/provider.dart';

import '../helpers/dark_theme_provider.dart';

///[ButtonPlaceholder] is the answer widget holder.
///Hold all answers for a particular question. 
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

  //used to select correct answer
  void _selectAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
    });
    widget.theAnswer(_selectedAnswer);
  }

  //parse the answer into a readable format
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
            child: Consumer<DarkThemeProvider>(
              builder: (_, theme, __) => OutlinedButton(
                key: ValueKey('$answer'),
                style: OutlinedButton.styleFrom(
                  primary: theme.darkTheme
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  side: BorderSide(
                    color: theme.darkTheme
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                  ),
                ),
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
          ),
        );
      }).toList(),
    );
  }
}
