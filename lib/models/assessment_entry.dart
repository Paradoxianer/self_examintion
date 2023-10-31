import 'package:self_examintion/data/self_assesment_questions.dart';

class AssessmentEntry {
  final DateTime timestamp;
  final SelfAssessmentQuestionSet questionSet;
  final Map<int, int> answers; // Map mit Frage-IDs und den dazugehörigen Antworten

  AssessmentEntry({
    required this.timestamp,
    required this.questionSet,
    required this.answers,
  });

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'questionSet': {
        'authorName': questionSet.authorName,
        'description': questionSet.description,
      },
      'answers': answers,
    };
  }

  factory AssessmentEntry.fromMap(Map<String, dynamic> map) {
    final Map<dynamic, dynamic> answerMap = map['answers'];
    final Map<int, int> answers = Map<int, int>.from(answerMap);
    return AssessmentEntry(
      timestamp: DateTime.parse(map['timestamp']),
      questionSet: SelfAssessmentQuestionSet(
        authorName: map['questionSet']['authorName'],
        description: map['questionSet']['description'],
        questions: [],
      ),
      answers: answers,
    );
  }
}