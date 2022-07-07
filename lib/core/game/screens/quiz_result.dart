import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../configs/constants.dart';
import '../../../helpers/user_pref.dart';
import '../controllers/quiz_page_controller.dart';

class QuizResult extends StatefulWidget {
  const QuizResult({Key? key}) : super(key: key);

  @override
  State<QuizResult> createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {
// shows dialog to confirm user's action
  Future<bool> _showDialog(Map<String, String> result) async {
    var closePage = false;
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
                onPressed: () async {
                  closePage = !closePage;
                  await context.read<QuizPageController>().savetoDB(context,
                      score: int.parse(result['score']!),
                      totalQuestion: int.parse(result['total_question']!));

                  context.read<QuizPageController>().clearResources();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });

    return closePage;
  }

  @override
  Widget build(BuildContext context) {
    final result = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return WillPopScope(
      onWillPop: () => _showDialog(result),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: kScreenHeight(context) * 0.25,
                  child:
                      (double.parse(result['score']!) / double.parse(result['total_question']!) * 100) < 40.0
                          ? Lottie.asset(AssetsAnimations.loss, repeat: false)
                          : (double.parse(result['score']!) / double.parse(result['total_question']!) * 100) <
                                  70.0
                              ? Lottie.asset(AssetsAnimations.thumbsUp)
                              : Lottie.asset(AssetsAnimations.congrats),
                ),
                MediaQuery(
                  data: const MediaQueryData(),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: kWhite,
                    backgroundImage: FileImage(
                      File(context.read<UserPref>().userData['imagepath']!),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kPaddingS),
                  child: Text(
                    (double.parse(result['score']!) / double.parse(result['total_question']!) * 100) < 40.0
                        ? 'Try Again...'
                        : (double.parse(result['score']!) / double.parse(result['total_question']!) * 100) <
                                70.0
                            ? 'Well done'
                            : 'Congratulations!',
                    style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kPaddingS),
                  child: Text(
                    'YOUR SCORE',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 3.5,
                        ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                      text: result['score'],
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: 40,
                            color: kDarkPrimaryColor,
                            letterSpacing: 2.5,
                          ),
                      children: [
                        TextSpan(
                          text: '/' '${result['total_question']}',
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                                fontSize: 40,
                              ),
                        ),
                      ]),
                ),
                SizedBox(height: kScreenHeight(context) * 0.05),
                Padding(
                  padding: const EdgeInsets.all(kPaddingS),
                  child: Text(
                    'EARNED COINS',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 3.5,
                        ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AssetsImages.coinsImg,
                      width: kScreenWidth(context) * 0.15,
                      height: kScreenHeight(context) * 0.15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(kPaddingS),
                      child: Text(
                        (double.parse(result['score']!) / double.parse(result['total_question']!) * 100) <
                                40.0
                            ? '50'
                            : (double.parse(result['score']!) /
                                        double.parse(result['total_question']!) *
                                        100) <
                                    70.0
                                ? '200'
                                : '500',
                        style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 25),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(kPaddingM),
                  child: Row(
                    children: [
                      Flexible(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Coming soon'),
                            ));
                            context.read<QuizPageController>().clearResources();
                          },
                          style: ElevatedButton.styleFrom(
                              onPrimary: kPrimaryTextColor,
                              primary: kWhite,
                              elevation: kCardElevation,
                              shape: const StadiumBorder()),
                          icon: const Icon(Icons.share),
                          label: Padding(
                            padding: const EdgeInsets.all(kPaddingM),
                            child: Text(
                              'Share Results',
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 3.5,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: kScreenWidth(context) * 0.05),
                      Flexible(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await context.read<QuizPageController>().savetoDB(context,
                                score: int.parse(result['score']!),
                                totalQuestion: int.parse(result['total_question']!));

                            context.read<QuizPageController>().clearResources();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              onPrimary: kPrimaryTextColor,
                              primary: kLightPrimaryColor,
                              elevation: kCardElevation,
                              shape: const StadiumBorder()),
                          icon: const Icon(Icons.power_settings_new),
                          label: Padding(
                            padding: const EdgeInsets.all(kPaddingM),
                            child: Text(
                              'Close Quiz',
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 3.5,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
