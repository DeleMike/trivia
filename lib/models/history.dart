import 'package:flutter/foundation.dart';

///data model for a [History]
class History {
  final String name;
  final String difficulty;
  final String dateTaken;
  final String score;

  History({
    @required this.name,
    @required this.difficulty,
    @required this.dateTaken,
    @required this.score,
  });
}