///data model for a [History]
class History {
  final String name;
  final String difficulty;
  final String dateTaken;
  final String scorePercentage;
  final String imageUrl;

  History({
    required this.name,
    required this.difficulty,
    required this.dateTaken,
    required this.scorePercentage,
    required this.imageUrl,
  });
}