import 'package:flutter_test/flutter_test.dart';
import 'package:self_examination/utils/assessment_calculator.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/models/question.dart';

void main() {
  group('AssessmentCalculator Logic Tests', () {
    
    test('getChartValue should return normal value if isPositive is false (Virtue)', () {
      expect(AssessmentCalculator.getChartValue(0.8, false), 0.8);
      expect(AssessmentCalculator.getChartValue(0.2, false), 0.2);
      expect(AssessmentCalculator.getChartValue(0.0, false), 0.0);
      expect(AssessmentCalculator.getChartValue(1.0, false), 1.0);
    });

    test('getChartValue should invert value if isPositive is true (Sin)', () {
      // 100% Sin (1.0) -> 0% Holiness (0.0)
      expect(AssessmentCalculator.getChartValue(1.0, true), 0.0);
      // 20% Sin (0.2) -> 80% Holiness (0.8)
      expect(AssessmentCalculator.getChartValue(0.2, true), 0.8);
      // 0% Sin (0.0) -> 100% Holiness (1.0)
      expect(AssessmentCalculator.getChartValue(0.0, true), 1.0);
    });

    test('getChartValue should handle unanswered (-1.0) as 0.0', () {
      expect(AssessmentCalculator.getChartValue(-1.0, false), 0.0);
      expect(AssessmentCalculator.getChartValue(-1.0, true), 0.0);
    });

    test('calculateAverage should correctly average mixed polarity questions', () {
      final mockSet = SelfAssessmentQuestionSet(
        authorName: "Test",
        description: "Test",
        questions: [
          Question(text: "Virtue 1", isPositive: false), // Normal
          Question(text: "Sin 1", isPositive: true),    // Inverted
        ],
      );

      final entry = AssessmentEntry(
        timestamp: DateTime.now(),
        questionSet: "Test",
        values: [0.8, 0.2], // 80% Virtue, 20% Sin
        questionNotes: ["", ""],
      );

      // Expected calculation:
      // (0.8 + (1.0 - 0.2)) / 2
      // (0.8 + 0.8) / 2 = 0.8
      expect(AssessmentCalculator.calculateAverage(entry, mockSet), 0.8);
    });

    test('calculateAverage should handle empty or missing data', () {
      final entry = AssessmentEntry(
        timestamp: DateTime.now(),
        questionSet: "Empty",
        values: [],
        questionNotes: [],
      );
      expect(AssessmentCalculator.calculateAverage(entry, null), 0.0);
    });
  });
}
