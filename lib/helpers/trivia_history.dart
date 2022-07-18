import 'package:flutter/foundation.dart';

import '../models/history.dart';
import '../helpers/db_helper.dart';

/// used to express FLChart Data
class ChartData {
  /// x value for chart
  int position;

  /// y value for chart
  int value;

  /// used to express FLChart Data
  ChartData({required this.position, required this.value});
}

///[TriviaHistory] - used to handle all trivia app history
class TriviaHistory with ChangeNotifier {
  List<History> _items = [];
  String _scorePercentage = '';
  int _sumofAllScores = 0;
  int _possibleMaxScore = 0;
  final List<ChartData> _lastWeekScores = [];

  ///returns all histories
  List<History> get items {
    return [..._items];
  }

  String get scorePercentage => _scorePercentage;

  int get sumofAllScores => _sumofAllScores;

  int get possibleMaxScore => _possibleMaxScore;

  List<ChartData> get lastWeekScores => _lastWeekScores;

  ///add a history
  Future<void> addHistory({
    required String quizName,
    required String difficulty,
    required String dateTaken,
    required String scorePercentage,
    required String imageUrl,
  }) async {
    // create a new history
    final newHistory = History(
      name: quizName,
      difficulty: difficulty,
      dateTaken: dateTaken,
      scorePercentage: scorePercentage,
      imageUrl: '',
    );

    _items.add(newHistory);

    await DbHelper.insert(
      'history',
      {
        'quizName': quizName,
        'quizDifficulty': difficulty,
        'scorePercentage': scorePercentage,
        'imageUrl': imageUrl,
        'dateTaken': dateTaken,
      },
    );

    notifyListeners();
  }

  ///fetch an history
  Future<void> fetchAndSetHistory() async {
    // clear all old resources
    clearResources();

    final dataList = await DbHelper.getData('history');
    _items = dataList
        .map((item) => History(
              name: item['quizName'],
              difficulty: item['quizDifficulty'],
              dateTaken: item['dateTaken'],
              scorePercentage: item['scorePercentage'],
              imageUrl: item['imageUrl'],
            ))
        .toList();

    // get last quiz score
    if (_items.isEmpty) {
      debugPrint('Pass');
    } else {
      History lastItem = _items.last;
      _scorePercentage = lastItem.scorePercentage;

      // get values for performance bar
      _possibleMaxScore = items.length * 100;
      for (var item in _items) {
        _sumofAllScores += int.parse(item.scorePercentage);
      }

      debugPrint('MaxScore: $_possibleMaxScore');
      debugPrint('User Accumulated Score: $_sumofAllScores');

      if (_items.length < 7) {
        for (var i = 0; i < _items.length; i++) {
          _lastWeekScores.add(ChartData(position: i + 1, value: int.parse(_items[i].scorePercentage)));
        }
      } else {
        int pos = 1;
        for (var i = (_items.length - 7); i < _items.length; i++) {
          _lastWeekScores.add(ChartData(position: pos, value: int.parse(_items[i].scorePercentage)));
          pos++;
        }
      }
    }

    notifyListeners();
  }

  void clearResources() {
    _items.clear();
    _scorePercentage = '';
    _sumofAllScores = 0;
    _possibleMaxScore = 0;
    _lastWeekScores.clear();
  }
}
