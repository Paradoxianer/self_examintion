import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:self_examintion/localizations/app_localizations.dart';
import 'package:self_examintion/models/assessment_entry.dart';
import 'package:self_examintion/utils/globals.dart';
import 'package:self_examintion/utils/local_storage.dart';

class MonthChartWidget extends StatefulWidget {
  final List<AssessmentEntry> assessmentHistory;

  MonthChartWidget({required this.assessmentHistory});

  @override
  _MonthChartWidgetState createState() => _MonthChartWidgetState();
}

class _MonthChartWidgetState extends State<MonthChartWidget> {
  List<bool> selectedQuestions = [];

  @override
  void initState() {
    super.initState();
    // Initialize the selectedQuestions list with all questions selected
    selectedQuestions = List.generate(
      widget.assessmentHistory[0].answers.length,
          (index) => true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AspectRatio(
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
                    for (int i = 0;
                    i < widget.assessmentHistory[0].answers.length;
                    i++)
                      if (selectedQuestions[i])
                        LineChartBarData(
                          spots: getQuestionScores(context, i),
                          isCurved: true,
                          isStrokeCapRound: true,
                          belowBarData: BarAreaData(show: true),
                          color: globalColorMap[i + 1],
                        ),
                  ],
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      drawBelowEverything: true,
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return bottomTitleWidgets(value, meta, context);
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        // Checkbox list for selecting questions
        Expanded(
                child: ListView.builder(
                  itemCount: selectedQuestions.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Card(
                          color: globalColorMap[index+1],
                          child: Checkbox(
                            value: selectedQuestions[index],
                            onChanged: (value) {
                              setState(() {
                                selectedQuestions[index] = value!;
                              });
                            },
                          ),
                        ),
                        title: Text(
                          '${AppLocalizations.of(context)!.questionMap[LocalStorage().getCurrentAuthor()]!.questions[index].text}'
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
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

    for (int i = 0; i < widget.assessmentHistory.length; i++) {
      int totalScore = calculateTotalScore(context,  widget.assessmentHistory[i]);
      DateTime timestamp =  widget.assessmentHistory[i].timestamp;
      spots.add(FlSpot(
          timestamp.millisecondsSinceEpoch.toDouble(), totalScore.toDouble()));
    }

    return spots;
  }

  List<FlSpot> getQuestionScores(BuildContext context, int questionIndex) {
    List<FlSpot> spots = [];

    for (int i = 0; i <  widget.assessmentHistory.length; i++) {
      int answer =  widget.assessmentHistory[i].answers[questionIndex];
      int convertedAnswer = answer;
      if (AppLocalizations.of(context)!.questionMap[ widget.assessmentHistory[i]
          .questionSet]!.questions[questionIndex].isPositive) {
        convertedAnswer = 5 - answer; // Invert the values
      }
      DateTime timestamp =  widget.assessmentHistory[i].timestamp;
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
      if (AppLocalizations.of(context)!.questionMap[ widget.assessmentHistory[0]
          .questionSet]!.questions[i].isPositive) {
        answer = 5 - answer; // Invert the values
      }
      totalScore += answer;
    }
    return totalScore;
  }


  //build the main axis...
  Widget bottomTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    String? freq = LocalStorage().getString("notificationFrequency");
    
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