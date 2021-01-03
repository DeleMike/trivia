import 'package:flutter/foundation.dart';

import '../models/history.dart';
import '../helpers/db_helper.dart';

///[TriviaHistory] - used to handle all trivia app history
class TriviaHistory with ChangeNotifier {
  List<History> _items = [];

  ///returns all histories
  List<History> get items {
    return [..._items];
  }

  ///add a history
  Future<void> addHistory(
      String quizName, String difficulty, String dateTaken, String score) async {
    final newHistory = History(
      name: quizName,
      difficulty: difficulty,
      dateTaken: dateTaken,
      score: score,
    );

    _items.add(newHistory);
    notifyListeners();
    await DbHelper.insert(
      'history',
      {
        'quizName': quizName,
        'quizDifficulty': difficulty,
        'dateTaken': dateTaken,
        'score' : score,
      },
    );
  }

  ///fetch an history
  Future<void> fetchAndSetHistory() async {
    final dataList = await DbHelper.getData('history');
    _items = dataList
        .map((item) => History(
              name: item['quizName'],
              difficulty: item['quizDifficulty'],
              dateTaken: item['dateTaken'],
              score: item['score'],
            ))
        .toList();
    notifyListeners();
  }
}
