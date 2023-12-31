
class AssessmentEntry {
  final DateTime timestamp;
  final String questionSet;
  final List<int> answers; // Map mit Frage-IDs und den dazugehörigen Antworten
  final String? note;

  AssessmentEntry(
      {required this.timestamp,
      required this.questionSet,
      required this.answers,
      this.note = null});

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'authorName': questionSet,
      'answers': answers,
      'note': note
    };
  }

  factory AssessmentEntry.fromMap(Map<String, dynamic> map) {
    final List<dynamic> answerList = map['answers'];
    final List<int> answers = List<int>.from(answerList);
    return AssessmentEntry(
        timestamp: DateTime.parse(map['timestamp']),
        questionSet: map['authorName'].toString(),
  //todo fix this          SelfAssessmentQuestions.questionMap[map['authorName'].toString()] ??
  //              SelfAssessmentQuestions.questionMap.entries.first.value,
        answers: answers,
        note: map['note']);
  }
}
