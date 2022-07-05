import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../configs/constants.dart';

final barData = [
  QuizData(id: 1, score: 70, difficulty: 'Hard', courseName: 'Mat', color: Colors.blue),
  QuizData(id: 2, score: 40, difficulty: 'Medium', courseName: 'Ge', color: Colors.green),
  QuizData(id: 2, score: 40, difficulty: 'Easy', courseName: 'Fr', color: Colors.green),
  QuizData(id: 3, score: 20, difficulty: 'Easy', courseName: 'Com', color: Colors.red),
  QuizData(id: 4, score: 90, difficulty: 'Medium', courseName: 'Sci', color: Colors.orange),
  QuizData(id: 5, score: 55, difficulty: 'Easy', courseName: 'Eng', color: Colors.pink),
];

class QuizData {
  final int id;
  final int score;
  final String difficulty;
  final String courseName;
  final Color color;

  QuizData({
    required this.id,
    required this.score,
    required this.difficulty,
    required this.courseName,
    required this.color,
  });
}

class BarTiles {
  static AxisTitles getBottomTiles() => AxisTitles(
        axisNameWidget: const Text('Subjects'),
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (id, _) =>
              Text(barData.firstWhere((element) => element.id == id.toInt()).courseName),
        ),
        // showTitles: true,
        // getTitlesWidget: (id, _) => Text(barData.firstWhere((element) => element.id == id.toInt()).courseName));
      );


}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final double _barWidth = 22;

  @override
  Widget build(BuildContext context) {
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
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.center,
                      maxY: 100,
                      minY: 0,
                      // borderData: FlBorderData(show: false) ,
                      // gridData: FlGridData(checkToShowHorizontalLine: ((value) => false)),
                      groupsSpace: 20,
                      titlesData: FlTitlesData(
                        //topTitles: BarTitles.getTopTiles(),
                        bottomTitles: BarTiles.getBottomTiles(),
                       
                      ),
                      barTouchData: BarTouchData(enabled: true),
                      barGroups: barData
                          .map(
                            (data) => BarChartGroupData(
                              x: data.id,
                              barsSpace: 0,
                              groupVertically: true,
                              barRods: [
                                BarChartRodData(
                                  fromY: 0,
                                  toY: double.parse(data.score.toString()),
                                  width: _barWidth,
                                  color: data.color,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(2), topRight: Radius.circular(2)),
                                ),
                                
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
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
