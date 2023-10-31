import 'package:self_examintion/models/question.dart';

class SelfAssessmentResult {
  final String id; // Eindeutige ID für das Ergebnis
  final DateTime timestamp; // Zeitstempel des Selbstbewertungsergebnisses
  final List<Question> answers; // Eine Liste von beantworteten Fragen

  SelfAssessmentResult({
    required this.id,
    required this.timestamp,
    required this.answers,
  });

  // Konvertiert das Selbstbewertungsergebnis in ein Map-Objekt für die Speicherung
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp.toUtc().toIso8601String(), // Zeitstempel als ISO-8601-String speichern
      'answers': answers.map((answer) => answer.toMap()).toList(),
    };
  }

  // Erstellt ein Selbstbewertungsergebnis aus einem Map-Objekt, z.B. beim Laden aus der Datenbank
  factory SelfAssessmentResult.fromMap(Map<String, dynamic> map) {
    final List<dynamic> answerMaps = map['answers'];
    final List<Question> answers = answerMaps.map((answerMap) => Question.fromMap(answerMap)).toList();

    return SelfAssessmentResult(
      id: map['id'],
      timestamp: DateTime.parse(map['timestamp']),
      answers: answers,
    );
  }

  int calculateTotalScore() {
    int totalScore = 0;
    for (Question question in answers) {
      int answerValue = question.answer;
      if (question.isNegative) {
        // Wenn die Frage "negativ" bewertet wird, kehre die Bewertung um
        answerValue = 5 - answerValue;
      }
      totalScore += answerValue;
    }
    return totalScore;
  }
}
