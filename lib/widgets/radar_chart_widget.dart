import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/utils/local_storage.dart';

class RadarChartWidget extends StatefulWidget {
  final List<AssessmentEntry> assessmentHistory;

  RadarChartWidget({required this.assessmentHistory});

  @override
  _RadarChartWidgetState createState() => _RadarChartWidgetState();
}

class _RadarChartWidgetState extends State<RadarChartWidget> {
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
              child: RadarChart(
                RadarChartData(
                  radarBackgroundColor: Colors.white,
                  // Set the background color of the radar chart
                  dataSets: latestAnswerScore(context),
                ),
                swapAnimationDuration: Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear, // Optional
              ),
            ),
          ),
        ),
      ],
    );
  }

  //returns the ideal dataset and the last answerd dataset
  List<RadarDataSet> latestAnswerScore(BuildContext context){

    List<RadarDataSet> radarSet = [];
    // Check if there are assessments for comparison
    if (widget.assessmentHistory.isEmpty) {
      return radarSet;
    }

    AssessmentEntry latestAssessment = widget.assessmentHistory.last;
    //add ideal Dataset
    radarSet.add(RadarDataSet(
        borderColor: Colors.red,
    ));
    //add current Dataset
    radarSet.add(RadarDataSet(
      borderColor: Colors.green
    ));
    //check if the
    if (!AppLocalizations.of(context)!.questionMap.containsKey(latestAssessment.questionSet))
      return radarSet;
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
      radarSet[0].dataEntries.add(RadarEntry(value: maxAnswer.toDouble()));
      radarSet[1].dataEntries.add(RadarEntry(value: convertedLatestAnswer.toDouble()));
    }
    return radarSet;

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
  
}