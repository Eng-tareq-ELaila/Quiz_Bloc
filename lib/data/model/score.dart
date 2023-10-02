class Score {
  final String id;
  final String uid;
  final DateTime time;
  final String category;

  final String score;
  final int attempts;
  final int wrongAttempts;
  final int correctAttempts;

  Score(
    this.attempts,
    this.wrongAttempts,
    this.correctAttempts,
    this.uid,
    this.time,
    this.score,
    this.category,
    this.id,
  );

  Map<String, dynamic> toJson() => {
        'userId': uid,
        'time': time,
        'score': score,
        'category': category,
        'id': id,
        'attempts': attempts,
        'wrongAttempts': wrongAttempts,
        'correctAttempts': correctAttempts
      };
}
