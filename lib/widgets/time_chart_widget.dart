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
    
    List<AssessmentEntry> displayHistory;
    final authorKey = assessmentHistory.first.questionSet;
    final questionSet = localization.questionMap[authorKey];

    // Aggregations-Logik je nach Zeitspanne
    if (currentTimeRange == TimeRange.year) {
      displayHistory = AssessmentCalculator.aggregateByMonth(assessmentHistory, referenceDate.year);
    } else if (currentTimeRange == TimeRange.all) {
      // Für die Gesamtansicht unterteilen wir in 10 sinnvolle Blöcke
      displayHistory = AssessmentCalculator.aggregate(assessmentHistory, 10);
    } else {
      displayHistory = assessmentHistory.where((entry) => 
        entry.timestamp.isAfter(start.subtract(const Duration(seconds: 1))) &&
        entry.timestamp.isBefore(end.add(const Duration(seconds: 1)))
      ).toList();
    }

    if (displayHistory.isEmpty) return Center(child: Text(localization.noData));

    // X-Achsen Bereich festlegen
    double minX = (currentTimeRange == TimeRange.all) 
        ? displayHistory.first.timestamp.millisecondsSinceEpoch.toDouble()
        : start.millisecondsSinceEpoch.toDouble();
    double maxX = (currentTimeRange == TimeRange.all)
        ? displayHistory.last.timestamp.millisecondsSinceEpoch.toDouble()
        : end.millisecondsSinceEpoch.toDouble();

    // Zoom-Effekt für kleine Ansichten (Punkte nicht am Rand kleben lassen)
    if ((currentTimeRange == TimeRange.twoDays || currentTimeRange == TimeRange.week) && displayHistory.length >= 2) {
      final diff = maxX - minX;
      minX -= diff * 0.05;
      maxX += diff * 0.05;
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
    if (currentTimeRange == TimeRange.all) return diff / 5; // Zeige ca 5 Labels
    if (currentTimeRange == TimeRange.year) return 1000 * 60 * 60 * 24 * 30; // 1 Monat
    if (currentTimeRange == TimeRange.month) return 1000 * 60 * 60 * 24 * 7; // 1 Woche
    return 1000 * 60 * 60 * 24; // 1 Tag
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
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
            radius: 3, color: Colors.white, strokeWidth: 2, strokeColor: Colors.red,
          ),
        ),
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
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
              radius: 2, color: color, strokeWidth: 1, strokeColor: Colors.white,
            ),
          ),
        ));
      }
    }
    return bars;
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    final locale = AppLocalizations.of(context)!.localeName;
    
    // Unterdrücke doppelte Labels am Rand
    if (value <= meta.min || value >= meta.max) return const SizedBox.shrink();

    String text = "";
    if (currentTimeRange == TimeRange.all) {
      text = DateFormat.yM(locale).format(date);
    } else if (currentTimeRange == TimeRange.year) {
      text = DateFormat.MMM(locale).format(date);
    } else {
      text = "${DateFormat.E(locale).format(date)}\n${DateFormat.Md(locale).format(date)}";
    }
    
    return SideTitleWidget(
      meta: meta, 
      space: 4, 
      child: Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold))
    );
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta, BuildContext context) =>
      SideTitleWidget(meta: meta, child: Text("${(value * 100).toInt()}%", style: const TextStyle(fontSize: 8)));
}
