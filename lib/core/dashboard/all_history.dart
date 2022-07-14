import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../configs/constants.dart';
import '../../helpers/trivia_history.dart';
import '../../configs/app_extensions.dart';

class AllHistory extends StatefulWidget {
  const AllHistory({Key? key}) : super(key: key);

  @override
  State<AllHistory> createState() => _AllHistoryState();
}

class _AllHistoryState extends State<AllHistory> {
  Future<void> _getAllData() async {
    await context.read<TriviaHistory>().fetchAndSetHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark ? kWhite : kBlack,
        ),
        title: Text(
          'History',
          style: Theme.of(context).textTheme.headline5,
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _getAllData(),
          builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : Consumer<TriviaHistory>(
                  builder: (context, history, _) => Container(
                    margin:
                        const EdgeInsets.only(left: kPaddingS + 2, right: kPaddingM + 2, top: kPaddingS + 2),
                    child: ListView.builder(
                      itemCount: history.items.length,
                      itemBuilder: ((context, index) {
                        return InkWell(
                            onTap: () {},
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(kMediumRadius),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: ConstrainedBox(
                                          constraints: const BoxConstraints.tightFor(width: 100, height: 100),
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
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Flexible(
                                      //   child: ConstrainedBox(
                                      //     constraints: const BoxConstraints.tightFor(width: 100, height: 100),
                                      //     child: Padding(
                                      //       padding: const EdgeInsets.only(top: kPaddingS - 6),
                                      //       child: Text('${history.items[index].scorePercentage}%')
                                      //     ),
                                      //   ),
                                      // ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(kPaddingS),
                                          child: Text(
                                            '${history.items[index].scorePercentage}%',
                                            //textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Theme.of(context).brightness == Brightness.dark
                                                  ? kWhite
                                                  : kBlack,
                                              fontSize: 30,
                                              fontFamily: GoogleFonts.caveatBrush().fontFamily,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(kPaddingS),
                                          child: Text(
                                            history.items[index].difficulty,
                                            // textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.bodyText2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      }),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
