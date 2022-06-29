import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../configs/constants.dart';
import '../../../configs/app_extensions.dart';
import '../controllers/quiz_page_controller.dart';

import 'answers_box.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Map _displayData = {};
  String _selectedAnswer = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<QuizPageController>().transportedData = ModalRoute.of(context)!.settings.arguments as Map;

    context.read<QuizPageController>().preProcessData();
  }

  // this affects the Current Chosen Answer Widget selected by user
  _onSelectAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
    });
    context.read<QuizPageController>().selectedAnswer = _selectedAnswer;
    debugPrint('Selected Answer: ${context.read<QuizPageController>().selectedAnswer}');
  }

  // shows dialog to confirm user's action
  Future<bool> _showDialog() async {
    var closeGame = false;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Message'),
            content: const Text('Do you really want to exit?'),
            actions: [
              TextButton(
                style: TextButton.styleFrom(primary: kPrimaryColor),
                child: const Text(
                  'NO',
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(primary: kPrimaryColor),
                child: const Text(
                  'YES',
                ),
                onPressed: () {
                  closeGame = !closeGame;
                  context.read<QuizPageController>().clearResources();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });

    return closeGame;
  }

  @override
  Widget build(BuildContext context) {
    _displayData = context.watch<QuizPageController>().triviaSet;
    return WillPopScope(
      onWillPop: () async => _showDialog(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kCanvasColor,
          leading: Container(),
          elevation: 0,
          centerTitle: true,
          title: Text(context.read<QuizPageController>().transportedData['title'].toString().removeColon(),
              style: Theme.of(context).textTheme.headline5),
          foregroundColor: kPrimaryTextColor,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LinearProgressIndicator(
                  value: 0.8,
                  minHeight: 5,
                ),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: kPaddingS, bottom: kPaddingM - 5),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: kTransparent,
                        child: Image.asset(
                          context.read<QuizPageController>().transportedData['imageUrl'],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 20,
                      right: 20,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, border: Border.all(color: kPrimaryTextColor, width: 2.5)),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: kWhite,
                          child: Text(
                              '${context.watch<QuizPageController>().currentQuestionNumber + 1}/${_displayData['total_question_length']} '),
                        ),
                      ),
                    )
                  ],
                ),
                Bubble(
                  margin: const BubbleEdges.only(left: kPaddingS + 2, top: kPaddingS),
                  padding: const BubbleEdges.all(kPaddingM),
                  nipWidth: kPaddingS + kPaddingM,
                  nipHeight: kPaddingS,
                  elevation: kCardElevation - 2,
                  nip: BubbleNip.leftTop,
                  color: kWhite,
                  child: Text(
                    _displayData['question'],
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                //answer placeholder.
                Container(
                  margin: const EdgeInsets.only(bottom: kPaddingS, top: kPaddingS),
                  decoration: const BoxDecoration(
                    color: kCanvasColor,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Your answer: $_selectedAnswer',
                    style: const TextStyle(color: kPrimaryTextColor),
                  ),
                ),
                // button for all answers
                AnswersBox(
                  answers: _displayData['answers'],
                  selectedAnswer: _onSelectAnswer,
                ),

                Container(
                  width: kScreenWidth(context),
                  margin: const EdgeInsets.only(left: kPaddingM + 2, right: kPaddingM + 2, top: kPaddingM),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(kPaddingS + 5)),
                      onPressed: () {
                        if (context.read<QuizPageController>().isDoneWithQuiz) {
                          context.read<QuizPageController>().clearResources();
                          Navigator.of(context).pop();
                          return;
                        }
                        context.read<QuizPageController>().getNextQuestion();
                        _selectedAnswer = '';
                      },
                      child: Text(context.read<QuizPageController>().isDoneWithQuiz ? 'DONE' : 'NEXT')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
