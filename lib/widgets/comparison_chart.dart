import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/local_storage.dart';

class ComparisonChartWidget extends StatelessWidget {
  final List<AssessmentEntry> assessmentHistory;

  ComparisonChartWidget({required this.assessmentHistory});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (assessmentHistory.length > 1)
          Center(
            child: Card(
              color: Colors.brown,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  assessmentHistory[assessmentHistory.length - 2].timestamp.toString().split('.')[0],
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ),
        Center(
          child: Card(
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                assessmentHistory.last.timestamp.toString().split('.')[0],
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Flexible(
          child: Center(
            child: AspectRatio(
              aspectRatio: 1.70,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BarChart(
                  BarChartData(
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return tooltipItem(group, groupIndex, rod, rodIndex, context);
                        },
                      ),
                    ),
                    minY: 0,
                    maxY: 1.1, // Adjusted for 0.0 - 1.0
                    barGroups: getComparisonData(context),
                    borderData: FlBorderData(show: true),
                    gridData: const FlGridData(
                      show: true,
                      horizontalInterval: 0.2,
                      drawVerticalLine: false,
                    ),
                    titlesData: FlTitlesData(
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        drawBelowEverything: true,
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return bottomTitleWidgets(value, meta, context);
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return leftTitleWidgets(value, meta, context);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> getComparisonData(BuildContext context) {
    List<BarChartGroupData> barGroups = [];
    if (assessmentHistory.isEmpty) return barGroups;

    final latestAssessment = assessmentHistory.last;
    final localization = AppLocalizations.of(context)!;
    final currentAuthor = LocalStorage().getCurrentAuthor();
    
    if (!localization.questionMap.containsKey(latestAssessment.questionSet)) return barGroups;
    final questions = localization.questionMap[latestAssessment.questionSet]!.questions;

    double totalLatestScore = 0;
    int count = 0;

    for (int i = 0; i < latestAssessment.values.length; i++) {
      double value = latestAssessment.values[i];
      if (value == -1.0) continue; // Skip unanswered

      double displayValue = value;
      // Invert if positive (matching old logic where 1 was best, now 1.0 is best)
      // Actually, old logic: if isPositive, converted = 5 - answer. (1->4, 4->1)
      // New logic: 1.0 is always "Full". If it's a "bad" thing (isPositive=false in your code meant bad?), 
      // we need to be careful. In QuestionCard, we used:
      // if (isPositive) 1.0 = Green, 0.0 = Red.
      // So let's assume 1.0 is always "good" for the chart.
      
      totalLatestScore += displayValue;
      count++;

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: displayValue,
              color: Colors.green,
              width: 8,
            ),
          ],
        ),
      );
    }

    if (assessmentHistory.length > 1) {
      final previousAssessment = assessmentHistory[assessmentHistory.length - 2];
      double totalPreviousScore = 0;
      int prevCount = 0;

      for (int i = 0; i < previousAssessment.values.length; i++) {
        double value = previousAssessment.values[i];
        if (value == -1.0) continue;

        totalPreviousScore += value;
        prevCount++;

        if (i < barGroups.length) {
          barGroups[i].barRods.insert(
                0,
                BarChartRodData(
                  toY: value,
                  color: Colors.brown,
                  width: 8,
                ),
              );
        }
      }

      // Add average
      if (count > 0) {
        double avgLatest = totalLatestScore / count;
        double avgPrev = prevCount > 0 ? totalPreviousScore / prevCount : 0;

        barGroups.add(
          BarChartGroupData(
            x: latestAssessment.values.length,
            barRods: [
              BarChartRodData(toY: avgPrev, color: Colors.brown, width: 12),
              BarChartRodData(toY: avgLatest, color: Colors.green, width: 12),
            ],
          ),
        );
      }
    }

    return barGroups;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    final questionSet = AppLocalizations.of(context)!.questionMap[LocalStorage().getCurrentAuthor()] ??
        AppLocalizations.of(context)!.questionMap.values.first;
    
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 12);
    
    if (value.toInt() < questionSet.questions.length) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text((value.toInt() + 1).toString(), style: style),
      );
    } else {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(AppLocalizations.of(context)!.total, style: style),
      );
    }
  }

  Widget leftTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 10);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text("${(value * 100).toInt()}%", style: style),
    );
  }

  BarTooltipItem tooltipItem(BarChartGroupData group, int groupIndex, BarChartRodData rod, int rodIndex, BuildContext context) {
    final questionSet = AppLocalizations.of(context)!.questionMap[LocalStorage().getCurrentAuthor()] ??
        AppLocalizations.of(context)!.questionMap.values.first;
    
    String text = "";
    if (groupIndex < questionSet.questions.length) {
      text = questionSet.questions[groupIndex].text;
    } else {
      text = AppLocalizations.of(context)!.total;
    }

    return BarTooltipItem(
      "$text\n${(rod.toY * 100).round()}%",
      const TextStyle(color: Colors.white, fontSize: 10),
    );
  }
}
