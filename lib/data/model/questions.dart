import 'dart:convert';

class Question {
  final String question;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.question,
    required this.correctAnswer,
    required this.options,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'question': question});
    result.addAll({'options': options});
    result.addAll({'correctAnswer': correctAnswer});

    return result;
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['question'] ?? '',
      options: List<String>.from(map['options']),
      correctAnswer: map['correctAnswer'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));
}
