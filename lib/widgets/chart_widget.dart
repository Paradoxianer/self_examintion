import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:self_examintion/localizations/app_localizations.dart';
import 'package:self_examintion/models/assessment_entry.dart';
import 'package:self_examintion/utils/globals.dart';
import 'package:self_examintion/utils/local_storage.dart';

class ChartWidget extends StatelessWidget {
  final List<AssessmentEntry> assessmentHistory;

  ChartWidget({required this.assessmentHistory});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
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
                  spots: getQuestionScores(context, i),
                  isCurved: true,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(show: false),
                  color: globalColorMap[i +
                      1], // Use the globalColorMap for other answers
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
                      final timestamp = DateTime.fromMillisecondsSinceEpoch(
                          value.toInt());
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
      ),
    );
  }

  List<FlSpot> getOverallScores(BuildContext context) {
    List<FlSpot> spots = [];

    for (int i = 0; i < assessmentHistory.length; i++) {
      int totalScore = calculateTotalScore(context, assessmentHistory[i]);
      DateTime timestamp = assessmentHistory[i].timestamp;
      spots.add(FlSpot(
          timestamp.millisecondsSinceEpoch.toDouble(), totalScore.toDouble()));
    }

    return spots;
  }

  List<FlSpot> getQuestionScores(BuildContext context, int questionIndex) {
    List<FlSpot> spots = [];

    for (int i = 0; i < assessmentHistory.length; i++) {
      int answer = assessmentHistory[i].answers[questionIndex];
      int convertedAnswer = answer;
      if (AppLocalizations.of(context)!.questionMap[assessmentHistory[i]
          .questionSet]!.questions[questionIndex].isNegative) {
        convertedAnswer = 4 - answer; // Invert the values
      }
      DateTime timestamp = assessmentHistory[i].timestamp;
      spots.add(FlSpot(timestamp.millisecondsSinceEpoch.toDouble(),
          convertedAnswer.toDouble()));
    }

    return spots;
  }

  int calculateTotalScore(BuildContext context,
      AssessmentEntry assessmentEntry) {
    int totalScore = 0;
    for (int i = 0; i < assessmentEntry.answers.length; i++) {
      int answer = assessmentEntry.answers[i];
      if (AppLocalizations.of(context)!.questionMap[assessmentHistory[0]
          .questionSet]!.questions[i].isNegative) {
        answer = 4 - answer; // Invert the values
      }
      totalScore += answer;
    }
    return totalScore;
  }


  //build the main axis...
  Widget bottomTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    String? freq = LocalStorage().getString("notificationFrequency");

    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget title;
    switch (freq) {
      case "daily":
        title = dailyTitles(value,meta,context);
        break;
      case "weekly":
        title = weeklyTitles(value,meta,context);
        break;
      case "montly":
        title = monthlyTitles(value,meta,context);
        break;
      case  "anual":
        title = annualTitles(value,meta,context);
        break;
      default:
        title = Container();
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: title,
    );
  }
  Widget dailyTitles(double value, TitleMeta meta, BuildContext context) {
    return Container();
  }

  Widget weeklyTitles(double value, TitleMeta meta, BuildContext context) {
    return Container();
  }

  Widget monthlyTitles(double value, TitleMeta meta, BuildContext context) {
    return Container();
  }

  Widget annualTitles(double value, TitleMeta meta, BuildContext context) {
    return Container();
  }

}