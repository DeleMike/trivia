import 'package:flutter/material.dart';

class QuestionNum extends StatefulWidget {
  final String currentQuestionNum;
  final String totalQuestionNum;
  QuestionNum(this.currentQuestionNum, this.totalQuestionNum);
  @override
  _QuestionNumState createState() => _QuestionNumState();
}

class _QuestionNumState extends State<QuestionNum> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.indigo[200],
            spreadRadius: 3,
            blurRadius: 8,
            offset: Offset(-2, 3),
          ),
        ],
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
        //borderRadius: BorderRadius.circular(12),
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            '${widget.currentQuestionNum}/${widget.totalQuestionNum}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}