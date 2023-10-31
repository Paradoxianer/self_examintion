import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:self_examintion/models/assessment_entry.dart';

class ChartWidget extends StatelessWidget {
  final List<AssessmentEntry> assessmentHistory;

  ChartWidget({required this.assessmentHistory});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: getOverallScores(),
              isCurved: true,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
              color: Colors.blue,
            ),
            for (int i = 0; i < assessmentHistory[0].answers.length; i++)
              LineChartBarData(
                spots: getQuestionScores(i),
                isCurved: true,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(show: false),
                color: Colors.red,
              ),
          ],
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: true),
        ),
      ),
    );
  }

  List<FlSpot> getOverallScores() {
    List<FlSpot> spots = [];

    for (int i = 0; i < assessmentHistory.length; i++) {
      int totalScore = calculateTotalScore(assessmentHistory[i]);
      DateTime timestamp = assessmentHistory[i].timestamp;
      spots.add(FlSpot(timestamp.millisecondsSinceEpoch.toDouble(), totalScore.toDouble()));
    }

    return spots;
  }

  List<FlSpot> getQuestionScores(int questionIndex) {
    List<FlSpot> spots = [];

    for (int i = 0; i < assessmentHistory.length; i++) {
      int answer = assessmentHistory[i].answers[questionIndex]!;
      int convertedAnswer = answer;
      if (assessmentHistory[i].questionSet.questions[questionIndex].isNegative) {
        convertedAnswer = 4 - answer; // Umkehrung der Werte
      }
      DateTime timestamp = assessmentHistory[i].timestamp;
      spots.add(FlSpot(timestamp.millisecondsSinceEpoch.toDouble(), convertedAnswer.toDouble()));
    }

    return spots;
  }

  int calculateTotalScore(AssessmentEntry assessmentEntry) {
    int totalScore = 0;

    for (int i = 0; i < assessmentEntry.answers.length; i++) {
      int answer = assessmentEntry.answers[i]!;
      if (assessmentEntry.questionSet.questions[i].isNegative) {
        answer = 4 - answer; // Umkehrung der Werte
      }
      totalScore += answer;
    }

    return totalScore;
  }
}