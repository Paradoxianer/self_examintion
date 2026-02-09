import 'package:intl/intl.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/widgets/chart_control_widget.dart';

class AssessmentCalculator {
  /// Calculates the display value for a question based on its polarity.
  static double getChartValue(double rawValue, bool isPositive) {
    if (rawValue == -1.0) return 0.0;
    return isPositive ? 1.0 - rawValue : rawValue;
  }

  /// Calculates the average 'holiness' score for a single assessment entry.
  static double calculateAverage(AssessmentEntry entry, SelfAssessmentQuestionSet? questionSet) {
    if (entry.values.isEmpty) return 0.0;
    double sum = 0;
    int count = 0;
    for (int i = 0; i < entry.values.length; i++) {
      double val = entry.values[i];
      if (val != -1.0) {
        bool isPositive = false;
        if (questionSet != null && i < questionSet.questions.length) {
          isPositive = questionSet.questions[i].isPositive;
        }
        sum += getChartValue(val, isPositive);
        count++;
      }
    }
    return count > 0 ? sum / count : 0.0;
  }

  /// Returns the start of the period for a given date and range.
  static DateTime getPeriodStart(DateTime d, TimeRange range) {
    switch (range) {
      case TimeRange.twoDays: return d;
      case TimeRange.week: return d.subtract(Duration(days: d.weekday - 1));
      case TimeRange.month: return DateTime(d.year, d.month, 1);
      case TimeRange.year: return DateTime(d.year, 1, 1);
      case TimeRange.all: return DateTime(2000); // Placeholder for earliest
    }
  }

  /// Returns the end of the period for a given date and range.
  static DateTime getPeriodEnd(DateTime d, TimeRange range) {
    final start = getPeriodStart(d, range);
    switch (range) {
      case TimeRange.twoDays: return DateTime(d.year, d.month, d.day, 23, 59, 59);
      case TimeRange.week: return start.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
      case TimeRange.month: return DateTime(d.year, d.month + 1, 0, 23, 59, 59);
      case TimeRange.year: return DateTime(d.year, 12, 31, 23, 59, 59);
      case TimeRange.all: return DateTime.now();
    }
  }

  /// Calculates the ISO week number.
  static int getIsoWeek(DateTime date) {
    int days = date.difference(DateTime(date.year, 1, 1)).inDays;
    return ((days - date.weekday + 10) / 7).floor();
  }

  /// Escapes CSV special characters in user notes.
  static String escapeCsvField(String? field) {
    if (field == null) return "";
    return field.replaceAll(';', ',').replaceAll('\n', ' ').trim();
  }
}
