import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../configs/constants.dart';

class QuizSeries {
  final int score;
  final String difficulty;
  final String courseName;
  final charts.Color barColor;

  QuizSeries({
    required this.score,
    required this.difficulty,
    required this.courseName,
    required this.barColor,
  });
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<QuizSeries> data = [
    QuizSeries(
      score: 70,
      courseName: 'General',
      difficulty: 'easy',
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    QuizSeries(
      score: 40,
      courseName: 'General',
      difficulty: 'hard',
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    QuizSeries(
      score: 80,
      courseName: 'Mathematics',
      difficulty: 'medium',
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    QuizSeries(
      score: 90,
      courseName: 'Any',
      difficulty: 'easy',
      barColor: charts.ColorUtil.fromDartColor(Colors.orange),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    List<charts.Series<QuizSeries, String>> series = [
      charts.Series(
          id: "Progression",
          data: data,
          domainFn: (QuizSeries series, _) => series.courseName,
          measureFn: (QuizSeries series, _) => series.score,
          colorFn: (QuizSeries series, _) => series.barColor)
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          kAppName,
          style: Theme.of(context).textTheme.headline5,
        ),
        elevation: 0,
        backgroundColor: kCanvasColor,
      ),
      body: SingleChildScrollView(
      
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: kPaddingS + 2, right: kPaddingM + 2),
              height: kScreenHeight(context) * 0.25,
              decoration: const BoxDecoration(
                color: kBlack,
                borderRadius: BorderRadius.all(Radius.circular(kSmallRadius)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: kPaddingS),
                    width: kScreenWidth(context) * 0.35,
                    child: Align(child: Image.asset(AssetsImages.homeBannerImg)),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: kScreenWidth(context) * 0.55,
                      child: Align(
                        child: RichText(
                          text: TextSpan(
                              text: 'Play & Win.\n',
                              style: TextStyle(
                                fontFamily: GoogleFonts.caveatBrush().fontFamily,
                                fontSize: 30,
                              ),
                              children: const [
                                TextSpan(text: ''),
                                TextSpan(text: 'Last quiz: 80%'),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: kPaddingS + 2, right: kPaddingM + 2, top: kPaddingM + 2, bottom: kPaddingS - 5),
              child: Text(
                'Current Streak \u{1F525}\u{1F525}\u{1F525}',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: kPaddingS + 2, right: kPaddingM + 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    child: StepProgressIndicator(
                      totalSteps: 7,
                      currentStep: 3,
                      size: 15,
                      padding: 0,
                      selectedColor: Colors.yellow,
                      unselectedColor: Colors.cyan,
                      roundedEdges: Radius.circular(kButtonRadius),
                      selectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [kAccentColor, kRed]
                          //colors: [Colors.yellowAccent, Colors.deepOrange],
                          ),
                      unselectedGradientColor: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.black, kPrimaryColor],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: kPaddingS - 7),
                    child: Text(
                      '\u{1F929}',
                      style: TextStyle(fontSize: 25),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: kPaddingS + 2, right: kPaddingM + 2, top: kPaddingM + 2),
              height: kScreenHeight(context) * 0.25,
              decoration: const BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.all(Radius.circular(kSmallRadius)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(kPaddingM),
                child: Center(
                    child: charts.BarChart(
                  series,
                  animate: true,
                  barGroupingType: charts.BarGroupingType.groupedStacked
                ) //.Barchart(series, animate: true)
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: kPaddingS + 2, right: kPaddingM + 2, top: kPaddingM + 2, bottom: kPaddingS - 5),
              child: Text(
                'Last Attempts',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return InkWell(
                      onTap: (() {
                        debugPrint('Position $index clicked');
                      }),
                      child: Card(
                        elevation: kCardElevation,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kMediumRadius),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints.tightFor(width: 100, height: 100),
                                child: Image.asset(AssetsImages.generalImg),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Text(
                                  'General',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                }),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: kPaddingS + 2, right: kPaddingM + 2, top: kPaddingM + 2),
              height: kScreenHeight(context) * 0.25,
              decoration: const BoxDecoration(
                color: kBlack,
                borderRadius: BorderRadius.all(Radius.circular(kSmallRadius)),
              ),
              child: const Padding(
                padding: EdgeInsets.all(kPaddingM),
                child: Center(
                  child: Text(
                    '"A man\'s mind, stretched by new ideas, may never return to its original dimensions." - Oliver Wendell Holmes Jr.',
                    style: TextStyle(
                      // fontFamily: GoogleFonts.caveatBrush().fontFamily,
                      fontSize: 16,
                      color: kWhite,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
