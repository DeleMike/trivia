import 'package:flutter/material.dart';

import '../widgets/build_question_form.dart';

class BuildQuestion extends StatelessWidget {
  static const routeName = '/build-questions';

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context).settings.arguments as Map<String, Object>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Fill in the form'),
      ),
      body: Center(child: BuildQuestionForm(data['name'], data['tag'])),
    );
  }
}
