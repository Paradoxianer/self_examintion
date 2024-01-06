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
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                    ) {
                  return BarTooltipItem(
                    AppLocalizations.of(context)!.rating[rod.toY.toInt()-1],
                    TextStyle(
                      color: Colors.white,
                      fontSize: 8.0,
                    ),
                  );
                },
              )
            ),
            minY: 0,
            maxY: 6,
            barGroups: getComparisonData(context),
            borderData: FlBorderData(show: true),
            gridData: FlGridData(show: true,horizontalInterval: 1.0,drawVerticalLine: false),
            titlesData: FlTitlesData(
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                    drawBelowEverything: true,
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return bottomTitleWidgets(value, meta, context);
                      },
                    )),
                leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return leftTitleWidgets(value, meta, context);
                  },
                ))),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> getComparisonData(BuildContext context) {
    List<BarChartGroupData> barGroups = [];

    // Check if there are assessments for comparison
    if (assessmentHistory.isEmpty) {
      return barGroups;
    }

    AssessmentEntry latestAssessment = assessmentHistory.last;

    // Variables for calculating overall average
    int totalLatestScore = 0;

    //check if the
    if (!AppLocalizations.of(context)!.questionMap.containsKey(latestAssessment.questionSet))
      return barGroups;
    // Iterate through questions and get the answers
    for (int i = 0; i < latestAssessment.answers.length; i++) {
      int latestAnswer = latestAssessment.answers[i];

      int convertedLatestAnswer = latestAnswer;

      // Invert values if the question is negative
      if (AppLocalizations.of(context)!
          .questionMap[latestAssessment.questionSet]!
          .questions[i]
          .isPositive) {
        convertedLatestAnswer = 5 - latestAnswer;
      }

      // Update overall score
      totalLatestScore += convertedLatestAnswer;

      // Create a BarChartGroupData for each question
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: convertedLatestAnswer.toDouble(),
              color: Colors.blue,
            ),
          ],
        ),
      );
    }

    // If there is more than one assessment, include the comparison
    if (assessmentHistory.length > 1) {
      AssessmentEntry previousAssessment =
      assessmentHistory[assessmentHistory.length - 2];

      // Variables for calculating overall average
      int totalPreviousScore = 0;

      // Iterate through questions and compare the answers
      for (int i = 0; i < latestAssessment.answers.length; i++) {
        int previousAnswer = previousAssessment.answers[i];

        int convertedPreviousAnswer = previousAnswer;

        // Invert values if the question is negative
        if (AppLocalizations.of(context)!
            .questionMap[latestAssessment.questionSet]!
            .questions[i]
            .isPositive) {
          convertedPreviousAnswer = 5 - previousAnswer;
        }

        // Update overall scores
        totalPreviousScore += convertedPreviousAnswer;

        // Add the comparison data to the existing BarChartGroupData
        barGroups[i].barRods.add(
          BarChartRodData(
            toY: convertedPreviousAnswer.toDouble(),
            color: Colors.green,
          ),
        );
      }

      // Calculate overall averages
      double averageLatestScore =
          totalLatestScore / latestAssessment.answers.length;
      double averagePreviousScore =
          totalPreviousScore / previousAssessment.answers.length;

      // Add a BarChartGroupData for the overall average
      barGroups.add(
        BarChartGroupData(
          x: latestAssessment.answers.length, // Position it at the end
          barRods: [
            BarChartRodData(
              toY: averageLatestScore,
              width: 20, // Adjust the width as needed
              color: Colors.red, // Use your preferred color
            ),
            BarChartRodData(
              toY: averagePreviousScore,
              width: 20, // Adjust the width as needed
              color: Colors.yellow, // Use your preferred color
            ),
          ],
        ),
      );
    }

    return barGroups;
  }

  Widget bottomTitleWidgets(
      double value, TitleMeta meta, BuildContext context) {
    SelfAssessmentQuestionSet questionSet = AppLocalizations.of(context)!
            .questionMap[LocalStorage().getCurrentAuthor()] ??
        AppLocalizations.of(context)!.questionMap.values.first;
    if (questionSet != null) {
      const style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      );
      if (value.toInt() < questionSet.questions.length)
      return Tooltip(
        message: questionSet.questions[value.toInt()].text,
        child: Text((value.toInt()+1).toString(),
          softWrap: true, style: style, maxLines: 10, overflow: TextOverflow.ellipsis,),
      );
      else
        return Text(AppLocalizations.of(context)!.total);
    }

    return Container();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    if (double.parse(value.toStringAsFixed(2)) % 1 == 0 && value >= 1 && value < 5) {
      String answerText = AppLocalizations.of(context)!.rating[5-value.toInt()-1];
      const style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 9,
      );
      return Flexible(
        child: Text(answerText, style: style, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
      );
    }
    return Container();
  }
}
