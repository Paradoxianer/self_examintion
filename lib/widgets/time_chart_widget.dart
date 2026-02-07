import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/widgets/chart_control_widget.dart';

class TimeChartWidget extends StatelessWidget {
  final List<AssessmentEntry> assessmentHistory;
  final List<bool> selectedQuestions;
  final TimeRange currentTimeRange;
  final DateTime referenceDate;

  const TimeChartWidget({
    super.key,
    required this.assessmentHistory,
    required this.selectedQuestions,
    required this.currentTimeRange,
    required this.referenceDate,
  });

  // --- Kalender-orientierte Fenster-Berechnung (identisch zur Logik im Screen) ---
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
        return assessmentHistory.isNotEmpty 
            ? assessmentHistory.first.timestamp 
            : referenceDate.subtract(const Duration(days: 30));
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
        return assessmentHistory.isNotEmpty 
            ? assessmentHistory.last.timestamp 
            : referenceDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (assessmentHistory.isEmpty) {
      return const Center(child: Text("No data available"));
    }

    final start = _windowStart;
    final end = _windowEnd;

    final filteredHistory = assessmentHistory.where((entry) {
      return entry.timestamp.isAfter(start.subtract(const Duration(seconds: 1))) &&
             entry.timestamp.isBefore(end.add(const Duration(seconds: 1)));
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          minX: start.millisecondsSinceEpoch.toDouble(),
          maxX: end.millisecondsSinceEpoch.toDouble(),
          minY: 0,
          maxY: 1.1,
          lineBarsData: [
            // Overall average line (last element in selectedQuestions)
            if (selectedQuestions.isNotEmpty && selectedQuestions.last)
              LineChartBarData(
                spots: getOverallScores(filteredHistory),
                isCurved: true,
                color: Colors.red,
                barWidth: 4,
                dotData: const FlDotData(show: false),
              ),
            for (int i = 0; i < selectedQuestions.length - 1; i++)
              if (selectedQuestions[i])
                LineChartBarData(
                  spots: getQuestionScores(filteredHistory, i),
                  isCurved: true,
                  color: globalColorMap[i + 1] ?? Colors.blue,
                  barWidth: 2,
                  dotData: const FlDotData(show: false),
                ),
          ],
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: _calculateInterval(start, end),
                getTitlesWidget: (value, meta) => bottomTitleWidgets(value, meta, context),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) => leftTitleWidgets(value, meta, context),
              ),
            ),
          ),
          borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey.shade300)),
          gridData: const FlGridData(show: true, horizontalInterval: 0.2, drawVerticalLine: false),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    "${(spot.y * 100).round()}%",
                    TextStyle(color: spot.bar.color, fontWeight: FontWeight.bold),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  double _calculateInterval(DateTime start, DateTime end) {
    final diff = end.difference(start).inDays;
    if (diff <= 2) return 1000 * 60 * 60 * 12;
    if (diff <= 7) return 1000 * 60 * 60 * 24;
    if (diff <= 31) return 1000 * 60 * 60 * 24 * 7;
    return 1000 * 60 * 60 * 24 * 30;
  }

  List<FlSpot> getOverallScores(List<AssessmentEntry> history) {
    return history.map((entry) {
      double avg = 0;
      int count = 0;
      for (var val in entry.values) {
        if (val != -1.0) {
          avg += val;
          count++;
        }
      }
      return FlSpot(
        entry.timestamp.millisecondsSinceEpoch.toDouble(),
        count > 0 ? avg / count : 0,
      );
    }).toList();
  }

  List<FlSpot> getQuestionScores(List<AssessmentEntry> history, int index) {
    List<FlSpot> spots = [];
    for (var entry in history) {
      if (index < entry.values.length && entry.values[index] != -1.0) {
        spots.add(FlSpot(
          entry.timestamp.millisecondsSinceEpoch.toDouble(),
          entry.values[index],
        ));
      }
    }
    return spots;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    String text;
    if (currentTimeRange == TimeRange.year || currentTimeRange == TimeRange.all) {
      text = "${date.month}.${date.year.toString().substring(2)}";
    } else {
      text = "${date.day}.${date.month}.";
    }
    return SideTitleWidget(
      meta: meta,
      child: Text(text, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    if (value > 1.0) return const SizedBox.shrink();
    return SideTitleWidget(
      meta: meta,
      child: Text("${(value * 100).toInt()}%", style: const TextStyle(fontSize: 8)),
    );
  }
}
