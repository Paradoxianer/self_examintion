import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/widgets/chart_control_widget.dart';

class RadarChartWidget extends StatelessWidget {
  final List<AssessmentEntry> assessmentHistory;
  final List<bool> selectedQuestions;
  final TimeRange currentTimeRange;
  final DateTime referenceDate;

  const RadarChartWidget({
    super.key,
    required this.assessmentHistory,
    required this.selectedQuestions,
    required this.currentTimeRange,
    required this.referenceDate,
  });

  // --- Kalender-orientierte Fenster-Berechnung ---
  DateTime get _windowStart {
    switch (currentTimeRange) {
      case TimeRange.twoDays:
        return DateTime(referenceDate.year, referenceDate.month, referenceDate.day - 1);
      case TimeRange.week:
        return DateTime(referenceDate.year, referenceDate.month, referenceDate.day - (referenceDate.weekday - 1));
      case TimeRange.month:
        return DateTime(referenceDate.year, referenceDate.month, 1);
      case TimeRange.year:
        return DateTime(referenceDate.year, 1, 1);
      case TimeRange.all:
        return assessmentHistory.isNotEmpty ? assessmentHistory.first.timestamp : referenceDate;
    }
  }

  DateTime get _windowEnd {
    switch (currentTimeRange) {
      case TimeRange.twoDays:
        return DateTime(referenceDate.year, referenceDate.month, referenceDate.day, 23, 59, 59);
      case TimeRange.week:
        final monday = _windowStart;
        return DateTime(monday.year, monday.month, monday.day + 6, 23, 59, 59);
      case TimeRange.month:
        return DateTime(referenceDate.year, referenceDate.month + 1, 0, 23, 59, 59);
      case TimeRange.year:
        return DateTime(referenceDate.year, 12, 31, 23, 59, 59);
      case TimeRange.all:
        return assessmentHistory.isNotEmpty ? assessmentHistory.last.timestamp : referenceDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (assessmentHistory.isEmpty) {
      return const Center(child: Text("No data available"));
    }

    final filteredHistory = assessmentHistory.where((entry) {
      return entry.timestamp.isAfter(_windowStart.subtract(const Duration(seconds: 1))) &&
             entry.timestamp.isBefore(_windowEnd.add(const Duration(seconds: 1)));
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RadarChart(
        RadarChartData(
          radarBackgroundColor: Colors.white,
          dataSets: _buildDataSets(context, filteredHistory),
          getTitle: (index, angle) {
            if (index < selectedQuestions.length && selectedQuestions[index]) {
              final val = _getDisplayValue(index, filteredHistory);
              return RadarChartTitle(
                text: "${index + 1}: ${(val * 100).round()}%",
                angle: angle,
              );
            }
            return const RadarChartTitle(text: "");
          },
          tickCount: 5,
          ticksTextStyle: const TextStyle(fontSize: 8, color: Colors.grey),
          gridBorderData: BorderSide(color: Colors.grey.withValues(alpha: 0.3), width: 1),
          // Styling hier vornehmen, da RadarChartTitle kein textStyle unterstützt
          titlePositionPercentageOffset: 0.2,
          titleTextStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  double _getDisplayValue(int questionIndex, List<AssessmentEntry> history) {
    if (history.isEmpty) return 0.0;

    if (currentTimeRange == TimeRange.twoDays) {
      final latest = history.last;
      if (questionIndex < latest.values.length) {
        return latest.values[questionIndex] == -1.0 ? 0.0 : latest.values[questionIndex];
      }
      return 0.0;
    } else {
      double sum = 0;
      int count = 0;
      for (var entry in history) {
        if (questionIndex < entry.values.length && entry.values[questionIndex] != -1.0) {
          sum += entry.values[questionIndex];
          count++;
        }
      }
      return count > 0 ? sum / count : 0.0;
    }
  }

  List<RadarDataSet> _buildDataSets(BuildContext context, List<AssessmentEntry> history) {
    if (history.isEmpty) return [];

    final localization = AppLocalizations.of(context)!;
    final authorKey = history.first.questionSet;
    if (!localization.questionMap.containsKey(authorKey)) return [];

    final int questionCount = localization.questionMap[authorKey]!.questions.length;
    List<RadarEntry> entries = [];

    for (int i = 0; i < questionCount; i++) {
      double displayVal = _getDisplayValue(i, history);
      bool isSelected = i < selectedQuestions.length && selectedQuestions[i];
      entries.add(RadarEntry(value: isSelected ? displayVal : 0.0));
    }

    return [
      RadarDataSet(
        borderColor: Colors.green,
        fillColor: Colors.green.withValues(alpha: 0.2),
        borderWidth: 2,
        entryRadius: 4,
        dataEntries: entries,
      ),
    ];
  }
}
