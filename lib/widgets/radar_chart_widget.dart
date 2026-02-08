import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/widgets/chart_control_widget.dart';

/// A radar chart that displays question averages or latest values with polarity support.
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
    final localization = AppLocalizations.of(context)!;
    if (assessmentHistory.isEmpty) {
      return Center(child: Text(localization.noData));
    }

    final filteredHistory = assessmentHistory.where((entry) {
      return entry.timestamp.isAfter(_windowStart.subtract(const Duration(seconds: 1))) &&
             entry.timestamp.isBefore(_windowEnd.add(const Duration(seconds: 1)));
    }).toList();

    final List<int> activeIndices = [];
    for (int i = 0; i < selectedQuestions.length - 1; i++) {
      if (selectedQuestions[i]) {
        activeIndices.add(i);
      }
    }

    if (activeIndices.length < 3) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.analytics_outlined, size: 48, color: Colors.grey.withValues(alpha: 0.5)),
              const SizedBox(height: 16),
              Text(
                localization.radarError,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final double size = min(constraints.maxWidth, constraints.maxHeight);
        final double radius = size * 0.30;

        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: RadarChart(
                RadarChartData(
                  radarBackgroundColor: Colors.white,
                  dataSets: _buildDataSets(context, filteredHistory, activeIndices),
                  getTitle: (index, angle) => const RadarChartTitle(text: ""),
                  tickCount: 5,
                  ticksTextStyle: const TextStyle(fontSize: 8, color: Colors.grey),
                  gridBorderData: BorderSide(color: Colors.grey.withValues(alpha: 0.3), width: 1),
                ),
              ),
            ),
            ..._buildCustomLabels(context, filteredHistory, activeIndices, radius),
          ],
        );
      },
    );
  }

  List<RadarDataSet> _buildDataSets(BuildContext context, List<AssessmentEntry> history, List<int> activeIndices) {
    List<RadarEntry> entries = [];
    double totalSum = 0;
    int totalCount = 0;

    for (int originalIndex in activeIndices) {
      double displayVal = _getDisplayValue(context, originalIndex, history);
      entries.add(RadarEntry(value: displayVal));
      totalSum += displayVal;
      totalCount++;
    }

    final double overallAvg = totalCount > 0 ? totalSum / totalCount : 0.0;

    return [
      if (selectedQuestions.last)
        RadarDataSet(
          borderColor: Colors.red.withValues(alpha: 0.6),
          fillColor: Colors.transparent,
          borderWidth: 2,
          entryRadius: 0,
          dataEntries: List.generate(activeIndices.length, (index) => RadarEntry(value: overallAvg)),
        ),
      RadarDataSet(
        borderColor: Colors.green,
        fillColor: Colors.green.withValues(alpha: 0.2),
        borderWidth: 2,
        entryRadius: 3,
        dataEntries: entries,
      ),
    ];
  }

  List<Widget> _buildCustomLabels(BuildContext context, List<AssessmentEntry> history, List<int> activeIndices, double radius) {
    List<Widget> labels = [];
    final int count = activeIndices.length;

    for (int i = 0; i < count; i++) {
      final int originalIndex = activeIndices[i];
      final double angle = (2 * pi / count) * i - (pi / 2);
      final double x = cos(angle) * (radius + 25);
      final double y = sin(angle) * (radius + 20);
      final color = globalColorMap[originalIndex + 1] ?? Colors.grey;
      final val = _getDisplayValue(context, originalIndex, history);

      labels.add(
        Transform.translate(
          offset: Offset(x, y),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 2)],
            ),
            child: Text(
              "${originalIndex + 1}: ${(val * 100).round()}%",
              style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }
    return labels;
  }

  double _getDisplayValue(BuildContext context, int questionIndex, List<AssessmentEntry> history) {
    if (history.isEmpty) return 0.0;
    final localization = AppLocalizations.of(context)!;

    if (currentTimeRange == TimeRange.twoDays) {
      final latest = history.last;
      if (questionIndex < latest.values.length) {
        double val = latest.values[questionIndex];
        if (val == -1.0) return 0.0;
        // Invert if positive (sin)
        final questionSet = localization.questionMap[latest.questionSet];
        if (questionSet != null && questionIndex < questionSet.questions.length && questionSet.questions[questionIndex].isPositive) {
          val = 1.0 - val;
        }
        return val;
      }
      return 0.0;
    } else {
      double sum = 0;
      int count = 0;
      for (var entry in history) {
        if (questionIndex < entry.values.length && entry.values[questionIndex] != -1.0) {
          double val = entry.values[questionIndex];
          // Invert if positive (sin)
          final questionSet = localization.questionMap[entry.questionSet];
          if (questionSet != null && questionIndex < questionSet.questions.length && questionSet.questions[questionIndex].isPositive) {
            val = 1.0 - val;
          }
          sum += val;
          count++;
        }
      }
      return count > 0 ? sum / count : 0.0;
    }
  }
}
