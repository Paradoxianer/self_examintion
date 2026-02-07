import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/local_storage.dart';

class ComparisonChartWidget extends StatelessWidget {
  final List<AssessmentEntry> assessmentHistory;
  final List<bool> selectedQuestions;

  const ComparisonChartWidget({
    super.key,
    required this.assessmentHistory,
    required this.selectedQuestions,
  });

  @override
  Widget build(BuildContext context) {
    if (assessmentHistory.isEmpty) {
      return const Center(child: Text("No data available"));
    }

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
                    maxY: 1.1,
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
    
    if (!localization.questionMap.containsKey(latestAssessment.questionSet)) return barGroups;

    double totalLatestScore = 0;
    int count = 0;

    for (int i = 0; i < latestAssessment.values.length; i++) {
      if (i < selectedQuestions.length && !selectedQuestions[i]) continue;

      double value = latestAssessment.values[i];
      if (value == -1.0) continue;

      totalLatestScore += value;
      count++;

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: value,
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

      int groupIdx = 0;
      for (int i = 0; i < previousAssessment.values.length; i++) {
        if (i < selectedQuestions.length && !selectedQuestions[i]) continue;

        double value = previousAssessment.values[i];
        if (value == -1.0) continue;

        totalPreviousScore += value;
        prevCount++;

        if (groupIdx < barGroups.length) {
          barGroups[groupIdx].barRods.insert(
                0,
                BarChartRodData(
                  toY: value,
                  color: Colors.brown,
                  width: 8,
                ),
              );
          groupIdx++;
        }
      }

      if (selectedQuestions.isNotEmpty && selectedQuestions.last && count > 0) {
        double avgLatest = totalLatestScore / count;
        double avgPrev = prevCount > 0 ? totalPreviousScore / prevCount : 0;

        barGroups.add(
          BarChartGroupData(
            x: 100,
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
    
    if (value == 100) {
      return SideTitleWidget(
        meta: meta,
        child: Text(AppLocalizations.of(context)!.total, style: style),
      );
    }

    if (value.toInt() < questionSet.questions.length) {
      return SideTitleWidget(
        meta: meta,
        child: Text((value.toInt() + 1).toString(), style: style),
      );
    }
    
    return const SizedBox.shrink();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 10);
    return SideTitleWidget(
      meta: meta,
      child: Text("${(value * 100).toInt()}%", style: style),
    );
  }

  BarTooltipItem tooltipItem(BarChartGroupData group, int groupIndex, BarChartRodData rod, int rodIndex, BuildContext context) {
    final questionSet = AppLocalizations.of(context)!.questionMap[LocalStorage().getCurrentAuthor()] ??
        AppLocalizations.of(context)!.questionMap.values.first;
    
    String text = "";
    if (group.x == 100) {
      text = AppLocalizations.of(context)!.total;
    } else if (group.x.toInt() < questionSet.questions.length) {
      text = questionSet.questions[group.x.toInt()].text;
    }

    return BarTooltipItem(
      "$text\n${(rod.toY * 100).round()}%",
      const TextStyle(color: Colors.white, fontSize: 10),
    );
  }
}
