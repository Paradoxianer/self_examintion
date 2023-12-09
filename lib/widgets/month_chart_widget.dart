import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:self_examintion/localizations/app_localizations.dart';
import 'package:self_examintion/models/assessment_entry.dart';
import 'package:self_examintion/utils/globals.dart';
import 'package:self_examintion/utils/local_storage.dart';

class MonthChartWidget extends StatelessWidget {
  final List<AssessmentEntry> assessmentHistory;

  MonthChartWidget({required this.assessmentHistory});

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
                belowBarData: BarAreaData(show: true),
                color: Colors.red, // Use red for the calculated score
              ),
              for (int i = 0; i < assessmentHistory[0].answers.length; i++)
                LineChartBarData(
                  spots: getQuestionScores(context, i),
                  isCurved: true,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(show: true),
                  color: globalColorMap[i +
                      1],
                ),
            ],
            //calculate minX and maxX according to the month today the minx should be the first day in this month the maxX should be last day in the current month
            /*minX: calculateMinX(),
            maxX: calculateMaxX(),*/
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
                      return bottomTitleWidgets(value,meta,context);
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

  // Funktion zum Berechnen des minimalen x-Werts (erster Tag des aktuellen Monats)
  double calculateMinX() {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    return firstDayOfMonth.millisecondsSinceEpoch.toDouble();
  }

  // Funktion zum Berechnen des maximalen x-Werts (letzter Tag des aktuellen Monats)
  double calculateMaxX() {
    DateTime now = DateTime.now();
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    return lastDayOfMonth.millisecondsSinceEpoch.toDouble();
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
          .questionSet]!.questions[questionIndex].isPositive) {
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
          .questionSet]!.questions[i].isPositive) {
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
        title = dailyTitles(value, meta, context);
        break;
      case "weekly":
        title = weeklyTitles(value, meta, context);
        break;
      case "monthly":
        title = monthlyTitles(value, meta, context);
        break;
      case "annual":
        title = annualTitles(value, meta, context);
        break;
      default:
        title = Container();
        break;
    }
    return title; // Änderung: Direkt das Widget zurückgeben, nicht in ein SideTitleWidget einbetten
  }


  Widget dailyTitles(double value, TitleMeta meta, BuildContext context) {
    final timestamp = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    // Prüfe, ob der Tag ungerade ist (alle zwei Tage anzeigen)
    if (timestamp.day % 2 != 0) {
      return Container(); // Zeige nichts an
    }

    return FittedBox(
      fit: BoxFit.fitHeight,
      child: Column(
        children: [
          Text(
            '${timestamp.day}.${timestamp.month}.${timestamp.year.toString().substring(timestamp.year.toString().length - 2)}',
            style: style,
          ),
          Text('${timestamp.hour}:${timestamp.minute}', style: style),
        ],
      ),
    );
  }

  Widget weeklyTitles(double value, TitleMeta meta, BuildContext context) {
    final timestamp = DateTime.fromMillisecondsSinceEpoch(
        value.toInt());
    return Text('${timestamp.day}.${timestamp.month}.${timestamp.year.toString().substring(timestamp.year.toString().length - 2)}');
  }

  Widget monthlyTitles(double value, TitleMeta meta, BuildContext context) {
    final timestamp = DateTime.fromMillisecondsSinceEpoch(
        value.toInt());
    final month =timestamp.month;
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (month) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget annualTitles(double value, TitleMeta meta, BuildContext context) {
    return Container();
  }

}