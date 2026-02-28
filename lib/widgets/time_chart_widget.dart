import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/utils/assessment_calculator.dart';
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

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    if (assessmentHistory.isEmpty) return Center(child: Text(localization.noData));

    final start = AssessmentCalculator.getPeriodStart(referenceDate, currentTimeRange);
    final end = AssessmentCalculator.getPeriodEnd(referenceDate, currentTimeRange);
    
    // Daten filtern und ggf. aggregieren
    List<AssessmentEntry> displayHistory;
    if (currentTimeRange == TimeRange.year) {
      final authorKey = assessmentHistory.first.questionSet;
      final questionSet = localization.questionMap[authorKey];
      displayHistory = AssessmentCalculator.aggregateByMonth(assessmentHistory, referenceDate.year, questionSet);
    } else {
      displayHistory = assessmentHistory.where((entry) => 
        entry.timestamp.isAfter(start.subtract(const Duration(seconds: 1))) &&
        entry.timestamp.isBefore(end.add(const Duration(seconds: 1)))
      ).toList();
    }

    if (displayHistory.isEmpty) return Center(child: Text(localization.noData));

    // Skalierung
    double minX = start.millisecondsSinceEpoch.toDouble();
    double maxX = end.millisecondsSinceEpoch.toDouble();

    if (currentTimeRange == TimeRange.year) {
       minX = DateTime(referenceDate.year, 1, 1).millisecondsSinceEpoch.toDouble();
       maxX = DateTime(referenceDate.year, 12, 31).millisecondsSinceEpoch.toDouble();
    } else if ((currentTimeRange == TimeRange.twoDays || currentTimeRange == TimeRange.week) && displayHistory.length >= 2) {
      final firstTs = displayHistory.first.timestamp.millisecondsSinceEpoch.toDouble();
      final lastTs = displayHistory.last.timestamp.millisecondsSinceEpoch.toDouble();
      final diff = lastTs - firstTs;
      if (diff > 0) {
        minX = firstTs - (diff * 0.1);
        maxX = lastTs + (diff * 0.1);
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 24, 16),
      child: LineChart(
        LineChartData(
          minX: minX,
          maxX: maxX,
          minY: 0,
          maxY: 1.05,
          lineBarsData: _buildBars(context, displayHistory),
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 38,
                // Intervall dynamisch je nach Range
                interval: _getInterval(minX, maxX),
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
          gridData: FlGridData(
            show: true, 
            horizontalInterval: 0.2,
            verticalInterval: _getInterval(minX, maxX),
            getDrawingVerticalLine: (value) => FlLine(color: Colors.grey.withValues(alpha: 0.05), strokeWidth: 1),
          ),
          borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey.withValues(alpha: 0.1))),
        ),
      ),
    );
  }

  double _getInterval(double min, double max) {
    final diff = max - min;
    if (currentTimeRange == TimeRange.year) return 1000 * 60 * 60 * 24 * 30; // Monatlich
    if (currentTimeRange == TimeRange.month) return 1000 * 60 * 60 * 24 * 7; // Wöchentlich
    return 1000 * 60 * 60 * 24; // Täglich
  }

  List<LineChartBarData> _buildBars(BuildContext context, List<AssessmentEntry> history) {
    List<LineChartBarData> bars = [];
    final localization = AppLocalizations.of(context)!;

    // Durchschnittslinie (Rot)
    if (selectedQuestions.isNotEmpty && selectedQuestions.last) {
      bars.add(LineChartBarData(
        spots: history.map((e) {
          final questionSet = localization.questionMap[e.questionSet];
          return FlSpot(e.timestamp.millisecondsSinceEpoch.toDouble(), AssessmentCalculator.calculateAverage(e, questionSet));
        }).toList(),
        isCurved: true,
        color: Colors.red,
        barWidth: 3,
        dotData: const FlDotData(show: true),
      ));
    }

    // Einzelne Fragen
    for (int i = 0; i < selectedQuestions.length - 1; i++) {
      if (selectedQuestions[i]) {
        final color = globalColorMap[i + 1] ?? Colors.blue;
        bars.add(LineChartBarData(
          spots: history.map((e) {
            final questionSet = localization.questionMap[e.questionSet];
            bool pos = questionSet?.questions[i].isPositive ?? false;
            return FlSpot(e.timestamp.millisecondsSinceEpoch.toDouble(), AssessmentCalculator.getChartValue(e.values[i], pos));
          }).toList(),
          isCurved: true,
          color: color,
          barWidth: 1.5,
          dotData: const FlDotData(show: false),
        ));
      }
    }
    return bars;
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    final locale = AppLocalizations.of(context)!.localeName;
    
    String text = "";
    if (currentTimeRange == TimeRange.year) {
      text = DateFormat.MMM(locale).format(date); // Jan, Feb...
    } else {
      text = "${DateFormat.E(locale).format(date)}\n${DateFormat.Md(locale).format(date)}";
    }
    
    return SideTitleWidget(meta: meta, space: 4, child: Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 8)));
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta, BuildContext context) =>
      SideTitleWidget(meta: meta, child: Text("${(value * 100).toInt()}%", style: const TextStyle(fontSize: 8)));
}
