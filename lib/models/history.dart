import 'package:flutter/foundation.dart';

class History {
  final String name;
  final String difficulty;
  final String timeTaken;
  final String score;

  History({
    @required this.name,
    @required this.difficulty,
    @required this.timeTaken,
    @required this.score,
  });
}