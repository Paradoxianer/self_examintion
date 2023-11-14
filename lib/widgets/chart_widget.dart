import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:self_examintion/localizations/app_localizations.dart';
import 'package:self_examintion/models/assessment_entry.dart';
import 'package:self_examintion/utils/globals.dart';

class ChartWidget extends StatelessWidget {
  final List<AssessmentEntry> assessmentHistory;

  ChartWidget({required this.assessmentHistory});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: getOverallScores(context),
              isCurved: true,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
              color: Colors.red, // Use red for the calculated score
            ),
            for (int i = 0; i < assessmentHistory[0].answers.length; i++)
              LineChartBarData(
                spots: getQuestionScores(context,i),
                isCurved: true,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(show: false),
                color: globalColorMap[i + 1], // Use the globalColorMap for other answers
              ),
          ],
          titlesData: FlTitlesData(
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false
              )
            ),
            topTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: false
                )
            ),
            bottomTitles: AxisTitles(
              drawBelowEverything: true,
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final timestamp = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                  return FittedBox(
                      fit: BoxFit.fitHeight,
                    child: Column(
                    children: [
                      Text('${timestamp.day}.${timestamp.month}.${timestamp.year.toString().substring(timestamp.year.toString().length - 2)}'),
                      Text('${timestamp.hour}:${timestamp.minute}')
                    ],
                ),
                  );
                },
              )
            ),
          ),
          borderData: FlBorderData(show: true),
        ),
      ),
    );
  }

  List<FlSpot> getOverallScores(BuildContext context) {
    List<FlSpot> spots = [];

    for (int i = 0; i < assessmentHistory.length; i++) {
      int totalScore = calculateTotalScore(context,assessmentHistory[i]);
      DateTime timestamp = assessmentHistory[i].timestamp;
      spots.add(FlSpot(timestamp.millisecondsSinceEpoch.toDouble(), totalScore.toDouble()));
    }

    return spots;
  }

  List<FlSpot> getQuestionScores(BuildContext context,int questionIndex) {
    List<FlSpot> spots = [];

    for (int i = 0; i < assessmentHistory.length; i++) {
      int answer = assessmentHistory[i].answers[questionIndex];
      int convertedAnswer = answer;
      if (AppLocalizations.of(context)!.questionMap[assessmentHistory[i].questionSet]!.questions[questionIndex].isNegative) {
        convertedAnswer = 4 - answer; // Invert the values
      }
      DateTime timestamp = assessmentHistory[i].timestamp;
      spots.add(FlSpot(timestamp.millisecondsSinceEpoch.toDouble(), convertedAnswer.toDouble()));
    }

    return spots;
  }

  int calculateTotalScore(BuildContext context,AssessmentEntry assessmentEntry) {
    int totalScore = 0;
    for (int i = 0; i < assessmentEntry.answers.length; i++) {
      int answer = assessmentEntry.answers[i];
      if (AppLocalizations.of(context)!.questionMap[assessmentHistory[0].questionSet]!.questions[i].isNegative) {
        answer = 4 - answer; // Invert the values
      }
      totalScore += answer;
    }
    return totalScore;
  }
}