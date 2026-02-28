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

    if (currentTimeRange == TimeRange.year) {
      displayHistory = AssessmentCalculator.aggregateByMonth(assessmentHistory, referenceDate.year);
    } else if (currentTimeRange == TimeRange.all) {
      displayHistory = AssessmentCalculator.aggregate(assessmentHistory, 10);
    } else {
      displayHistory = assessmentHistory.where((entry) => 
        entry.timestamp.isAfter(start.subtract(const Duration(seconds: 1))) &&
        entry.timestamp.isBefore(end.add(const Duration(seconds: 1)))
      ).toList();
    }

    if (displayHistory.isEmpty) return Center(child: Text(localization.noData));

    double minX = (currentTimeRange == TimeRange.all) 
        ? displayHistory.first.timestamp.millisecondsSinceEpoch.toDouble()
        : start.millisecondsSinceEpoch.toDouble();
    double maxX = (currentTimeRange == TimeRange.all)
        ? displayHistory.last.timestamp.millisecondsSinceEpoch.toDouble()
        : end.millisecondsSinceEpoch.toDouble();

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
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (spot) => Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.95),
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                return touchedSpots.map((LineBarSpot touchedSpot) {
                  final textStyle = TextStyle(
                    color: touchedSpot.bar.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  );
                  
                  // Finde heraus, ob es der Durchschnitt (rote Linie) oder eine Einzelfrage ist
                  String label = "";
                  if (touchedSpot.bar.color == Colors.red) {
                    label = localization.total;
                  } else {
                    // Suche den Index der Frage basierend auf der Farbe/Reihenfolge
                    // Da wir die Bars in _buildBars in einer festen Reihenfolge bauen:
                    // 1. Bar: Durchschnitt (optional)
                    // Weitere: Gewählte Fragen
                    int qIdx = -1;
                    int barIndex = touchedSpots.indexOf(touchedSpot); // Das ist leider nicht zuverlässig
                    
                    // Wir nutzen die x-Koordinate für das Datum
                    final date = DateTime.fromMillisecondsSinceEpoch(touchedSpot.x.toInt());
                    final dateStr = DateFormat.yMd(localization.localeName).format(date);
                    
                    // Der Wert
                    final val = "${(touchedSpot.y * 100).round()}%";
                    
                    return LineTooltipItem(
                      "$dateStr\n$val",
                      textStyle,
                    );
                  }
                  
                  final date = DateTime.fromMillisecondsSinceEpoch(touchedSpot.x.toInt());
                  final dateStr = DateFormat.yMd(localization.localeName).format(date);
                  return LineTooltipItem(
                    "$label: ${(touchedSpot.y * 100).round()}%\n$dateStr",
                    textStyle,
                  );
                }).toList();
              },
            ),
          ),
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
    if (currentTimeRange == TimeRange.all) return diff / 5;
    if (currentTimeRange == TimeRange.year) return 1000 * 60 * 60 * 24 * 30;
    if (currentTimeRange == TimeRange.month) return 1000 * 60 * 60 * 24 * 7;
    return 1000 * 60 * 60 * 24;
  }

  List<LineChartBarData> _buildBars(BuildContext context, List<AssessmentEntry> history) {
    List<LineChartBarData> bars = [];
    final localization = AppLocalizations.of(context)!;

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
