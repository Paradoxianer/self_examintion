import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/utils/assessment_calculator.dart';
import 'package:self_examination/widgets/chart_control_widget.dart';

/// A chart that visualizes assessment trends over time using area charts.
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

  DateTime get _windowStart {
    switch (currentTimeRange) {
      case TimeRange.twoDays: return DateTime(referenceDate.year, referenceDate.month, referenceDate.day - 1);
      case TimeRange.week: return DateTime(referenceDate.year, referenceDate.month, referenceDate.day - (referenceDate.weekday - 1));
      case TimeRange.month: return DateTime(referenceDate.year, referenceDate.month, 1);
      case TimeRange.year: return DateTime(referenceDate.year, 1, 1);
      case TimeRange.all: return assessmentHistory.isNotEmpty ? assessmentHistory.first.timestamp : referenceDate;
    }
  }

  DateTime get _windowEnd {
    switch (currentTimeRange) {
      case TimeRange.twoDays: return DateTime(referenceDate.year, referenceDate.month, referenceDate.day, 23, 59, 59);
      case TimeRange.week:
        final monday = _windowStart;
        return DateTime(monday.year, monday.month, monday.day + 6, 23, 59, 59);
      case TimeRange.month: return DateTime(referenceDate.year, referenceDate.month + 1, 0, 23, 59, 59);
      case TimeRange.year: return DateTime(referenceDate.year, 12, 31, 23, 59, 59);
      case TimeRange.all: return assessmentHistory.isNotEmpty ? assessmentHistory.last.timestamp : referenceDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    if (assessmentHistory.isEmpty) return Center(child: Text(localization.noData));

    final start = _windowStart;
    final end = _windowEnd;
    final filteredHistory = assessmentHistory.where((entry) => 
      entry.timestamp.isAfter(start.subtract(const Duration(seconds: 1))) &&
      entry.timestamp.isBefore(end.add(const Duration(seconds: 1)))
    ).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 24, 16),
      child: LineChart(
        LineChartData(
          minX: start.millisecondsSinceEpoch.toDouble(),
          maxX: end.millisecondsSinceEpoch.toDouble(),
          minY: 0,
          maxY: 1.05,
          lineBarsData: _buildBars(context, filteredHistory),
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: _calculateInterval(start, end),
                getTitlesWidget: (value, meta) => _bottomTitleWidgets(value, meta, context),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) => _leftTitleWidgets(value, meta, context),
              ),
            ),
          ),
          borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey.withValues(alpha: 0.1))),
          gridData: FlGridData(
            show: true, 
            horizontalInterval: 0.2, 
            drawVerticalLine: true,
            getDrawingVerticalLine: (value) => FlLine(color: Colors.grey.withValues(alpha: 0.05), strokeWidth: 1),
          ),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (touchedSpots) => touchedSpots.map((spot) => LineTooltipItem(
                "${(spot.y * 100).round()}%",
                TextStyle(color: spot.bar.color, fontWeight: FontWeight.bold),
              )).toList(),
            ),
          ),
        ),
      ),
    );
  }

  List<LineChartBarData> _buildBars(BuildContext context, List<AssessmentEntry> history) {
    List<LineChartBarData> bars = [];

    if (selectedQuestions.isNotEmpty && selectedQuestions.last) {
      bars.add(LineChartBarData(
        spots: _getOverallScores(context, history),
        isCurved: true,
        color: Colors.red,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
            radius: 4, color: Colors.white, strokeWidth: 2, strokeColor: Colors.red,
          ),
        ),
        belowBarData: BarAreaData(show: true, color: Colors.red.withValues(alpha: 0.1)),
      ));
    }

    for (int i = 0; i < selectedQuestions.length - 1; i++) {
      if (selectedQuestions[i]) {
        final color = globalColorMap[i + 1] ?? Colors.blue;
        bars.add(LineChartBarData(
          spots: _getQuestionScores(context, history, i),
          isCurved: true,
          color: color,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
              radius: 3, color: color, strokeWidth: 1, strokeColor: Colors.white,
            ),
          ),
          belowBarData: BarAreaData(show: true, color: color.withValues(alpha: 0.05)),
        ));
      }
    }
    return bars;
  }

  double _calculateInterval(DateTime start, DateTime end) {
    final diff = end.difference(start).inDays;
    if (diff <= 2) return 1000 * 60 * 60 * 12;
    if (diff <= 7) return 1000 * 60 * 60 * 24;
    if (diff <= 31) return 1000 * 60 * 60 * 24 * 7;
    return 1000 * 60 * 60 * 24 * 30;
  }

  List<FlSpot> _getOverallScores(BuildContext context, List<AssessmentEntry> history) {
    final localization = AppLocalizations.of(context)!;
    return history.map((entry) {
      final questionSet = localization.questionMap[entry.questionSet];
      double avg = AssessmentCalculator.calculateAverage(entry, questionSet);
      return FlSpot(entry.timestamp.millisecondsSinceEpoch.toDouble(), avg);
    }).toList();
  }

  List<FlSpot> _getQuestionScores(BuildContext context, List<AssessmentEntry> history, int index) {
    final localization = AppLocalizations.of(context)!;
    List<FlSpot> spots = [];
    for (var entry in history) {
      if (index < entry.values.length && entry.values[index] != -1.0) {
        final questionSet = localization.questionMap[entry.questionSet];
        bool isPositive = false;
        if (questionSet != null && index < questionSet.questions.length) {
          isPositive = questionSet.questions[index].isPositive;
        }
        double val = AssessmentCalculator.getChartValue(entry.values[index], isPositive);
        spots.add(FlSpot(entry.timestamp.millisecondsSinceEpoch.toDouble(), val));
      }
    }
    return spots;
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    String text = (currentTimeRange == TimeRange.year || currentTimeRange == TimeRange.all)
        ? "${date.month}.${date.year.toString().substring(2)}"
        : "${date.day}.${date.month}.";
    return SideTitleWidget(meta: meta, child: Text(text, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)));
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    if (value > 1.0) return const SizedBox.shrink();
    return SideTitleWidget(meta: meta, child: Text("${(value * 100).toInt()}%", style: const TextStyle(fontSize: 8)));
  }
}
