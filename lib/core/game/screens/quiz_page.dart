import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:trivia/configs/routes.dart';

import '../../../configs/constants.dart';
import '../../../configs/app_extensions.dart';
import '../controllers/question_form_controller.dart';
import '../controllers/quiz_page_controller.dart';

import 'answers_box.dart';

class QuizPage extends StatefulWidget {
  final Map<String, dynamic> transportedData;
  const QuizPage({Key? key, required this.transportedData}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Map _displayData = {};
  String _selectedAnswer = '';

  @override
  void initState() {
    super.initState();
    debugPrint('Called only once');

    _getData();

    // debugPrint('Collected Data from Controller Page: ${widget.transportedData}');

    // debugPrint('Transported Data on Quiz Page: ${context.read<QuizPageController>().transportedData}');
    // context.read<QuizPageController>().preProcessData();
    // context.read<QuizPageController>().startTimer(context);
  }

  void _getData() {
    debugPrint('Collected Data from Controller Page: ${widget.transportedData}');
    context.read<QuizPageController>().transportedData = {...widget.transportedData};
    // context.read<QuizPageController>().transportedData = ModalRoute.of(context)!.settings.arguments as Map;
    debugPrint('Transported Data on Quiz Page: ${context.read<QuizPageController>().transportedData}');
    context.read<QuizPageController>().preProcessData();
    context.read<QuizPageController>().startTimer(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<QuestionFormController>().clearStates();
    debugPrint('didChangeDependencies is called because of a state change');
    // context.read<QuizPageController>().transportedData = ModalRoute.of(context)!.settings.arguments as Map;
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
                  context.read<QuestionFormController>().clearStates();
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
          actions: [
            Container(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: kLightPrimaryColor.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: kWhite,
                child: Lottie.asset(
                  AssetsAnimations.lookingEyes,
                  animate: context.watch<QuizPageController>().timeLength == 20 ? false : true,
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
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
                LinearProgressIndicator(
                  value: context.watch<QuizPageController>().timeCounter,
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
                  isDisabled: context.watch<QuizPageController>().isDisabled,
                ),

                Container(
                  width: kScreenWidth(context),
                  margin: const EdgeInsets.only(left: kPaddingM + 2, right: kPaddingM + 2, top: kPaddingM),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(kPaddingS + 5)),
                    onPressed: () {
                      context.read<QuizPageController>().evaluateUserChoice(_selectedAnswer);
                      if (context.read<QuizPageController>().isDoneWithQuiz) {
                        context.read<QuizPageController>().savetoDB();
                        Navigator.pushReplacementNamed(context, Routes.result);
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(content: Text(context.read<QuizPageController>().score.toString())));
                        // context.read<QuizPageController>().clearResources();
                        //  Navigator.of(context).pop();
                        return;
                      }

                      context.read<QuizPageController>().getNextQuestion(context);
                      _selectedAnswer = '';
                    },
                    child: Text(context.read<QuizPageController>().isDoneWithQuiz ? 'DONE' : 'NEXT'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
