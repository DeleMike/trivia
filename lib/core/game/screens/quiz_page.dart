import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../configs/constants.dart';
import '../../../configs/app_extensions.dart';
import '../controllers/quiz_page_controller.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Map _cleanData = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<QuizPageController>().transportedData = ModalRoute.of(context)!.settings.arguments as Map;

    context.read<QuizPageController>().preProcessData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kCanvasColor,
        elevation: 0,
        centerTitle: true,
        title: Text(context.read<QuizPageController>().transportedData['title'].toString().removeColon(),
            style: Theme.of(context).textTheme.headline5),
        foregroundColor: kPrimaryTextColor,
      ),
      body: Center(
        child: Column(
          children: [
            Text('Quiz Data:\n ${context.read<QuizPageController>().cleanedData}'),
          ],
        ),
      ),
    );
  }
}
