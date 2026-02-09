import 'package:flutter_test/flutter_test.dart';
import 'package:self_examination/utils/assessment_calculator.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/models/question.dart';
import 'package:self_examination/widgets/chart_control_widget.dart';

void main() {
  group('AssessmentCalculator Logic Tests', () {
    
    test('getChartValue should return normal value if isPositive is false (Virtue)', () {
      expect(AssessmentCalculator.getChartValue(0.8, false), 0.8);
    });

    test('getChartValue should invert value if isPositive is true (Sin)', () {
      expect(AssessmentCalculator.getChartValue(0.2, true), 0.8);
    });

    test('escapeCsvField should handle semicolons and line breaks', () {
      expect(AssessmentCalculator.escapeCsvField("Hello; World"), "Hello, World");
      expect(AssessmentCalculator.escapeCsvField("Line 1\nLine 2"), "Line 1 Line 2");
      expect(AssessmentCalculator.escapeCsvField(null), "");
    });

    test('getPeriodStart should return correct Monday for Week range', () {
      // 2024-03-20 is a Wednesday
      final date = DateTime(2024, 3, 20);
      final start = AssessmentCalculator.getPeriodStart(date, TimeRange.week);
      // Monday of that week is 2024-03-18
      expect(start.day, 18);
      expect(start.month, 3);
      expect(start.year, 2024);
    });

    test('getIsoWeek should return correct week number', () {
      // 2024-01-01 is a Monday, Week 1
      expect(AssessmentCalculator.getIsoWeek(DateTime(2024, 1, 1)), 1);
      // 2024-12-31 is a Tuesday, Week 53 (leap year)
      expect(AssessmentCalculator.getIsoWeek(DateTime(2024, 12, 31)), 53);
    });
  });
}
