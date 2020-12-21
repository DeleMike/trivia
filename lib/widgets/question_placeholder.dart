import 'package:flutter/material.dart';

class QuestionPlaceholder extends StatelessWidget {
  final String questionText;
  QuestionPlaceholder(this.questionText);
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(questionText ?? '',
          style: Theme.of(context).textTheme.headline6.copyWith(
            fontSize: 20,
          ),
        ),
      ),
      elevation: 4.0,
    );
  }
}
