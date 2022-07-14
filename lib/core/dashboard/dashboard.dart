import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:trivia/configs/routes.dart';

import '../../configs/constants.dart';
import '../../configs/app_extensions.dart';
import '../../helpers/trivia_history.dart';

class LineTiles {
  static getTilesData() => FlTitlesData(show: true);
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<void> _getAllData() async {
    await context.read<TriviaHistory>().fetchAndSetHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          kAppName,
          style: Theme.of(context).textTheme.headline5,
        ),
        elevation: 0,
        //backgroundColor: kCanvasColor,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _getAllData(),
          builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : Consumer<TriviaHistory>(
                  builder: (context, history, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: kPaddingS + 2, right: kPaddingM + 2),
                        height: kScreenHeight(context) * 0.25,
                        decoration: BoxDecoration(
                          color: kBlack,
                          borderRadius: const BorderRadius.all(Radius.circular(kSmallRadius)),
                          border: Theme.of(context).brightness == Brightness.dark
                              ? Border.all(color: kWhite)
                              : null,
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
                                        children: [
                                          const TextSpan(text: ''),
                                          history.scorePercentage.isEmpty
                                              ? const TextSpan(text: 'No quiz taken yet')
                                              : TextSpan(text: 'Last quiz: ${history.scorePercentage} %'),
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
                            left: kPaddingS + 2,
                            right: kPaddingM + 2,
                            top: kPaddingM + 2,
                            bottom: kPaddingS - 5),
                        child: Text(
                          'All Time Performance Bar \u{1F525}\u{1F525}\u{1F525}',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: kPaddingS + 2, right: kPaddingM + 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: StepProgressIndicator(
                                // totalSteps: history.possibleMaxScore,
                                // currentStep: history.sumofAllScores,
                                totalSteps: history.possibleMaxScore == 0 ? 7 : history.possibleMaxScore,
                                currentStep: history.sumofAllScores == 0 ? 3 : history.sumofAllScores,
                                size: 15,
                                padding: 0,
                                selectedColor: Colors.yellow,
                                unselectedColor: Colors.cyan,
                                roundedEdges: const Radius.circular(kButtonRadius),
                                selectedGradientColor: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [kAccentColor, kRed]
                                    //colors: [Colors.yellowAccent, Colors.deepOrange],
                                    ),
                                unselectedGradientColor: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.black, kPrimaryColor],
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: kPaddingS - 7),
                              child: Text(
                                '\u{1F929}',
                                style: TextStyle(fontSize: 25),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: kPaddingS + 2,
                            right: kPaddingM + 2,
                            top: kPaddingM + 2,
                            bottom: kPaddingS - 5),
                        child: Text(
                          'Performance per Quiz Attempt \u{1f4ca}',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: kPaddingS + 2, right: kPaddingM + 2, top: kPaddingM + 2),
                        height: kScreenHeight(context) * 0.25,
                        decoration: const BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.all(Radius.circular(kSmallRadius)),
                        ),
                        child: history.items.isEmpty
                            ? Center(
                                child: Text(
                                  'No items yet',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: kPrimaryTextColor),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(kPaddingM),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                  border: Theme.of(context).brightness == Brightness.dark
                                      ? Border.all(color: kWhite)
                                      : null,
                                  color: Theme.of(context).canvasColor,
                                ),
                                child: Center(
                                  child: LineChart(
                                    LineChartData(
                                      minX: 1,
                                      maxX: 7,
                                      minY: 0,
                                      maxY: 100,
                                      titlesData: LineTiles.getTilesData(),
                                      backgroundColor: Theme.of(context).canvasColor,
                                      borderData: FlBorderData(
                                        show: true,
                                        border: Border.all(color: kPrimaryColor),
                                      ),
                                      lineBarsData: [
                                        LineChartBarData(
                                            isCurved: true,
                                            gradient: const LinearGradient(
                                                colors: [kLightPrimaryColor, kPrimaryColor]),
                                            barWidth: 5,
                                            dotData: FlDotData(show: false),
                                            belowBarData: BarAreaData(
                                              show: true,
                                              gradient: LinearGradient(
                                                  colors: <Color>[kLightPrimaryColor, kPrimaryColor]
                                                      .map((color) => color.withOpacity(0.3))
                                                      .toList()),
                                            ),
                                            spots: history.lastWeekScores
                                                .map((chartData) => FlSpot(
                                                      chartData.position.toDouble(),
                                                      chartData.value.toDouble(),
                                                    ))
                                                .toList()),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: kPaddingS + 2,
                            right: kPaddingM + 2,
                            top: kPaddingM + 2,
                            bottom: kPaddingS - 5),
                        child: Text(
                          'Past Quiz Attempts',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: history.items.isEmpty
                            ? Center(
                                child: Text(
                                  'No items yet',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: kPrimaryTextColor),
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(
                                    left: kPaddingS + 2, right: kPaddingM + 2, top: kPaddingS + 2),
                                child: ListView.builder(
                                  itemCount: history.items.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: ((context, index) {
                                    return InkWell(
                                        onTap: (() {
                                          Navigator.of(context).pushNamed(Routes.history);
                                        }),
                                        child: Card(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(kMediumRadius),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: ConstrainedBox(
                                                  constraints:
                                                      const BoxConstraints.tightFor(width: 100, height: 100),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top: kPaddingS - 6),
                                                    child: Image.asset(history.items[index].imageUrl),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(kPaddingS),
                                                  child: Text(
                                                    history.items[index].name.removeColon(),
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
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: kPaddingS + 2, right: kPaddingM + 2, top: kPaddingM + 2, bottom: kPaddingS),
                        height: kScreenHeight(context) * 0.25,
                        decoration: BoxDecoration(
                          color: kBlack,
                          borderRadius: const BorderRadius.all(Radius.circular(kSmallRadius)),
                          border: Theme.of(context).brightness == Brightness.dark
                              ? Border.all(color: kWhite)
                              : null,
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
        ),
      ),
    );
  }
}
