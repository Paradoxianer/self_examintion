import 'package:self_examintion/models/question.dart';

class SelfAssessmentQuestionSet {
  final String authorName; // Name des Autors des Fragebogens
  final String description; // Beschreibung des Fragebogens
  final List<Question> questions; // Die Fragen im Fragebogen

  SelfAssessmentQuestionSet({
    required this.authorName,
    required this.description,
    required this.questions,
  });
}
