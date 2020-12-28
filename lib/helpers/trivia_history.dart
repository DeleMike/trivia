import 'package:flutter/foundation.dart';

import '../models/history.dart';
import '../helpers/db_helper.dart';

class TriviaHistory with ChangeNotifier {
  List<History> _items = [];

  List<History> get items {
    return [..._items];
  }

  ///add data
  Future<void> addHistory(
      String quizName, String difficulty, String timeTaken, String score) async {
    final newHistory = History(
      name: quizName,
      difficulty: difficulty,
      timeTaken: timeTaken,
      score: score,
    );

    _items.add(newHistory);
    notifyListeners();
    await DbHelper.insert(
      'history',
      {
        'quizName': quizName,
        'quizDifficulty': difficulty,
        'timeTaken': timeTaken,
        'score' : score,
      },
    );
  }

  ///fetch data
  Future<void> fetchAndSetHistory() async {
    final dataList = await DbHelper.getData('history');
    _items = dataList
        .map((item) => History(
              name: item['quizName'],
              difficulty: item['quizDifficulty'],
              timeTaken: item['timeTaken'],
              score: item['score'],
            ))
        .toList();
    notifyListeners();
  }
}
