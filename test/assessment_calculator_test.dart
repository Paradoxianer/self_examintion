import 'package:flutter_test/flutter_test.dart';
import 'package:self_examination/utils/assessment_calculator.dart';
import 'package:self_examination/widgets/chart_control_widget.dart';

void main() {
  group('AssessmentCalculator Logic Tests', () {
    
    group('Value Inversion (Sin vs. Virtue)', () {
      test('should return normal value if isPositive is false (Virtue)', () {
        expect(AssessmentCalculator.getChartValue(0.8, false), 0.8);
        expect(AssessmentCalculator.getChartValue(0.0, false), 0.0);
        expect(AssessmentCalculator.getChartValue(1.0, false), 1.0);
      });

      test('should invert value if isPositive is true (Sin)', () {
        expect(AssessmentCalculator.getChartValue(0.2, true), 0.8);
        expect(AssessmentCalculator.getChartValue(0.0, true), 1.0);
        expect(AssessmentCalculator.getChartValue(1.0, true), 0.0);
        expect(AssessmentCalculator.getChartValue(0.5, true), 0.5);
      });
    });

    group('CSV Export Formatting', () {
      test('escapeCsvField should handle semicolons and line breaks', () {
        expect(AssessmentCalculator.escapeCsvField("Hello; World"), "Hello, World");
        expect(AssessmentCalculator.escapeCsvField("Line 1\nLine 2"), "Line 1 Line 2");
        expect(AssessmentCalculator.escapeCsvField(null), "");
      });

      test('escapeCsvField should handle commas by keeping them (semicolon is the separator)', () {
        expect(AssessmentCalculator.escapeCsvField("Hello, World"), "Hello, World");
      });
    });

    group('Date & Period Calculations', () {
      test('getPeriodStart should return correct Monday for Week range', () {
        // 2024-03-20 is a Wednesday
        final date = DateTime(2024, 3, 20);
        final start = AssessmentCalculator.getPeriodStart(date, TimeRange.week);
        // Monday of that week is 2024-03-18
        expect(start.day, 18);
        expect(start.month, 3);
        expect(start.year, 2024);
        expect(start.hour, 0);
      });

      test('getPeriodStart for year should return Jan 1st', () {
        final date = DateTime(2024, 5, 15);
        final start = AssessmentCalculator.getPeriodStart(date, TimeRange.year);
        expect(start.month, 1);
        expect(start.day, 1);
        expect(start.year, 2024);
      });

      test('getIsoWeek should return correct week number', () {
        // 2024-01-01 is a Monday, Week 1
        expect(AssessmentCalculator.getIsoWeek(DateTime(2024, 1, 1)), 1);
        // 2024-12-31 is a Tuesday, Week 53 (leap year)
        expect(AssessmentCalculator.getIsoWeek(DateTime(2024, 12, 31)), 53);
      });
    });
  });
}
