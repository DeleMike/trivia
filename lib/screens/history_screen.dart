import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/dark_theme_provider.dart';
import '../helpers/trivia_history.dart';

///[HistoryScreen] is used to display list of quiz taken so far.
class HistoryScreen extends StatelessWidget {
  static const routeName = '/history';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: FutureBuilder(
        future: Provider.of<TriviaHistory>(context, listen: false)
            .fetchAndSetHistory(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<TriviaHistory>(
                child: Center(child: Text('You got no history. Take a quiz.')),
                builder: (ctx, history, ch) => history.items.length == 0
                    ? ch!
                    : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: history.items.length,
                          itemBuilder: (ctx, i) {
                            int diffStrength = 100;
                            if (history.items[i].difficulty == 'easy') {
                              diffStrength = 300;
                            } else if (history.items[i].difficulty == 'medium') {
                              diffStrength = 600;
                            } else {
                              diffStrength = 900;
                            }

                            return Container(
                              margin: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0,),
                              child: Card(
                                elevation: 4.0,
                                child: InkWell(
                                  onTap: () {},
                                  child: ListTile(
                                    leading: Consumer<DarkThemeProvider>(
                                                                          builder: (_, theme, __) => CircleAvatar(
                                        backgroundColor: theme.darkTheme ? Colors.grey[diffStrength] :
                                            Colors.indigo[diffStrength],
                                      ),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${history.items[i].name}', style: Theme.of(context).textTheme.headline1),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Score: ${history.items[i].score}',
                                      ),
                                    ),
                                    trailing: Text(
                                        'Date: ${history.items[i].dateTaken}'),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
              ),
      ),
    );
  }
}
