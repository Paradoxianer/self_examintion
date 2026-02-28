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

  /// Calculates the average score for a single entry.
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

  /// Generic aggregation function that splits a history into a fixed number of data points.
  /// Used for long-term views like "All Time" to keep the chart readable.
  static List<AssessmentEntry> aggregate(List<AssessmentEntry> history, int divisions) {
    if (history.isEmpty) return [];
    if (history.length <= divisions) return history;

    List<AssessmentEntry> aggregated = [];
    // We group by an approximate index range to get exactly 'divisions' points
    double step = history.length / divisions;

    for (int i = 0; i < divisions; i++) {
      int startIdx = (i * step).floor();
      int endIdx = ((i + 1) * step).floor();
      if (endIdx > history.length) endIdx = history.length;
      
      List<AssessmentEntry> batch = history.sublist(startIdx, endIdx);
      if (batch.isEmpty) continue;

      int questionCount = batch.first.values.length;
      List<double> avgValues = List.filled(questionCount, 0.0);
      List<int> counts = List.filled(questionCount, 0);

      for (var entry in batch) {
        for (int q = 0; q < questionCount; q++) {
          if (entry.values[q] != -1.0) {
            avgValues[q] += entry.values[q];
            counts[q]++;
          }
        }
      }

      for (int q = 0; q < questionCount; q++) {
        avgValues[q] = counts[q] > 0 ? avgValues[q] / counts[q] : -1.0;
      }

      aggregated.add(AssessmentEntry(
        timestamp: batch[batch.length ~/ 2].timestamp, // Middle timestamp of the batch
        questionSet: batch.first.questionSet,
        values: avgValues,
        questionNotes: List.filled(questionCount, null),
        note: null
      ));
    }
    return aggregated;
  }

  /// Specific aggregation for months in a year.
  static List<AssessmentEntry> aggregateByMonth(List<AssessmentEntry> history, int year) {
    List<AssessmentEntry> monthly = [];
    for (int m = 1; m <= 12; m++) {
      final entries = history.where((e) => e.timestamp.year == year && e.timestamp.month == m).toList();
      if (entries.isNotEmpty) {
        // Aggregate all entries of this month into one single point
        monthly.add(aggregate(entries, 1).first);
      }
    }
    return monthly;
  }

  static DateTime getPeriodStart(DateTime d, TimeRange range) {
    switch (range) {
      case TimeRange.twoDays: return DateTime(d.year, d.month, d.day - 1);
      case TimeRange.week: return d.subtract(Duration(days: d.weekday - 1));
      case TimeRange.month: return DateTime(d.year, d.month, 1);
      case TimeRange.year: return DateTime(d.year, 1, 1);
      case TimeRange.all: return DateTime(2000); 
    }
  }

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
