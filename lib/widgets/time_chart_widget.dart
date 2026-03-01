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

    final double minX = (currentTimeRange == TimeRange.all) 
        ? displayHistory.first.timestamp.millisecondsSinceEpoch.toDouble()
        : start.millisecondsSinceEpoch.toDouble();
    final double maxX = (currentTimeRange == TimeRange.all)
        ? displayHistory.last.timestamp.millisecondsSinceEpoch.toDouble()
        : end.millisecondsSinceEpoch.toDouble();

    double adjustedMinX = minX;
    double adjustedMaxX = maxX;
    if ((currentTimeRange == TimeRange.twoDays || currentTimeRange == TimeRange.week) && displayHistory.length >= 2) {
      final diff = maxX - minX;
      adjustedMinX -= diff * 0.05;
      adjustedMaxX += diff * 0.05;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 24, 16),
      child: LineChart(
        LineChartData(
          minX: adjustedMinX,
          maxX: adjustedMaxX,
          minY: 0,
          maxY: 1.05,
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (spot) => Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.95),
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                // Get the date from the first touched spot
                final date = DateTime.fromMillisecondsSinceEpoch(touchedSpots.first.x.toInt());
                final dateStr = DateFormat.yMd(localization.localeName).format(date);

                return touchedSpots.map((LineBarSpot touchedSpot) {
                  final textStyle = TextStyle(
                    color: touchedSpot.bar.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  );
                  
                  final val = "${(touchedSpot.y * 100).round()}%";
                  
                  // For the first item, show the date header
                  String header = "";
                  if (touchedSpots.indexOf(touchedSpot) == 0) {
                    header = "$dateStr\n";
                  }

                  // Identify if it's the Total line (red) or a specific question
                  if (touchedSpot.bar.color == Colors.red) {
                    return LineTooltipItem("$header${localization.total}: $val", textStyle);
                  } else {
                    // Search for the question number based on the color in globalColorMap
                    int questionNr = -1;
                    final barColor = touchedSpot.bar.color;
                    
                    globalColorMap.forEach((nr, color) {
                      // Fix: Secure access to color and compare values safely
                      if (color.value == barColor.value) {
                         questionNr = nr;
                      }
                    });
                    
                    String label = (questionNr != -1) ? "$questionNr" : "?";
                    return LineTooltipItem("$header$label: $val", textStyle);
                  }
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
          gridData: const FlGridData(
            show: true, 
            horizontalInterval: 0.2,
            drawVerticalLine: false,
          ),
          borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey.withValues(alpha: 0.1))),
        ),
      ),
    );
  }

  List<LineChartBarData> _buildBars(BuildContext context, List<AssessmentEntry> history) {
    if (history.isEmpty) return [];
    final localization = AppLocalizations.of(context)!;
    final List<LineChartBarData> bars = [];
    final String currentSetKey = history.first.questionSet;
    final questionSet = localization.questionMap[currentSetKey];

    // Average Bar (Red)
    if (selectedQuestions.isNotEmpty && selectedQuestions.last) {
      bars.add(LineChartBarData(
        spots: history.map((e) => FlSpot(
          e.timestamp.millisecondsSinceEpoch.toDouble(), 
          AssessmentCalculator.calculateAverage(e, questionSet)
        )).toList(),
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

    // Question Bars
    for (int i = 0; i < selectedQuestions.length - 1; i++) {
      if (selectedQuestions[i]) {
        final color = globalColorMap[i + 1] ?? Colors.blue;
        final bool isPos = (questionSet != null && i < questionSet.questions.length) 
            ? questionSet.questions[i].isPositive : false;

        bars.add(LineChartBarData(
          spots: history.map((e) {
            final double val = (i < e.values.length) ? e.values[i] : -1.0;
            return FlSpot(e.timestamp.millisecondsSinceEpoch.toDouble(), AssessmentCalculator.getChartValue(val, isPos));
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
    return SideTitleWidget(meta: meta, space: 4, child: Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)));
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta, BuildContext context) =>
      SideTitleWidget(meta: meta, child: Text("${(value * 100).toInt()}%", style: const TextStyle(fontSize: 8)));
}
