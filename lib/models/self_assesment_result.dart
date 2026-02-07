import 'package:self_examination/models/question.dart';

class SelfAssessmentResult {
  final String id;
  final DateTime timestamp;
  final List<Question> answers;

  SelfAssessmentResult({
    required this.id,
    required this.timestamp,
    required this.answers,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp.toUtc().toIso8601String(),
      'answers': answers.map((answer) => answer.toMap()).toList(),
    };
  }

  factory SelfAssessmentResult.fromMap(Map<String, dynamic> map) {
    final List<dynamic> answerMaps = map['answers'];
    final List<Question> answers =
        answerMaps.map((answerMap) => Question.fromMap(answerMap)).toList();

    return SelfAssessmentResult(
      id: map['id'],
      timestamp: DateTime.parse(map['timestamp']),
      answers: answers,
    );
  }

  double calculateTotalScore() {
    double totalScore = 0;
    for (Question question in answers) {
      double value = question.value;
      if (value != -1.0) {
        totalScore += value;
      }
    }
    return totalScore;
  }
}
