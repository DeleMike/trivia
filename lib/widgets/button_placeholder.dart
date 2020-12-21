import 'package:flutter/material.dart';

class ButtonPlaceHolder extends StatefulWidget {
  final String questionType;
  final List answers;

  ButtonPlaceHolder(this.questionType, this.answers);

  @override
  _ButtonPlaceHolderState createState() => _ButtonPlaceHolderState();
}

class _ButtonPlaceHolderState extends State<ButtonPlaceHolder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //use Wrap widget
    );
  }
}