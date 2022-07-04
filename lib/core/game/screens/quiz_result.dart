import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../../configs/constants.dart';
import '../../../helpers/user_pref.dart';
import '../controllers/quiz_page_controller.dart';

class QuizResult extends StatefulWidget {
  const QuizResult({Key? key}) : super(key: key);

  @override
  State<QuizResult> createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {
  Uint8List? bytes;

  @override
  void initState() {
    super.initState();
    debugPrint('InitState called');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget _buildTopChildren(BuildContext context, Map<String, String> result) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
                (double.parse(result['score']!) / double.parse(result['total_question']!) * 100) < 40.0
                    ? '50'
                    : (double.parse(result['score']!) / double.parse(result['total_question']!) * 100) < 70.0
                        ? '200'
                        : '500',
                style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 25),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final result = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: kScreenHeight(context) * 0.25,
                child: (double.parse(result['score']!) / double.parse(result['total_question']!) * 100) < 40.0
                    ? Lottie.asset(AssetsAnimations.loss, repeat: false)
                    : (double.parse(result['score']!) / double.parse(result['total_question']!) * 100) < 70.0
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
                      (double.parse(result['score']!) / double.parse(result['total_question']!) * 100) < 40.0
                          ? '50'
                          : (double.parse(result['score']!) / double.parse(result['total_question']!) * 100) <
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
                          // final controller = ScreenshotController();
                          // final bytes = await controller.captureFromWidget(
                          //   Material(
                          //     child: _buildTopChildren(context, result),
                          //   ),
                          // );
                          // setState(() {
                          //   this.bytes = bytes;
                          // });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(content: Text('Coming soon') ,));
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
                        onPressed: () {
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
              if (bytes != null) Image.memory(bytes!),
            ],
          )),
        ),
      ),
    );
  }
}
