import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';

class RadarChartWidget extends StatelessWidget {
  final List<AssessmentEntry> assessmentHistory;
  final List<bool> selectedQuestions;

  const RadarChartWidget({
    super.key,
    required this.assessmentHistory,
    required this.selectedQuestions,
  });

  @override
  Widget build(BuildContext context) {
    if (assessmentHistory.isEmpty) {
      return const Center(child: Text("No data available"));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RadarChart(
        RadarChartData(
          radarBackgroundColor: Colors.white,
          dataSets: latestAnswerScore(context),
          getTitle: (index, angle) {
            // Only show titles for selected questions
            if (index < selectedQuestions.length && selectedQuestions[index]) {
               return RadarChartTitle(text: (index + 1).toString());
            }
            return const RadarChartTitle(text: "");
          },
          tickCount: 5,
          ticksTextStyle: const TextStyle(fontSize: 8, color: Colors.grey),
          gridBorderData: const BorderSide(color: Colors.grey, width: 0.5),
        ),
        duration: const Duration(milliseconds: 150),
        curve: Curves.linear,
      ),
    );
  }

  List<RadarDataSet> latestAnswerScore(BuildContext context) {
    List<RadarDataSet> radarSet = [];
    if (assessmentHistory.isEmpty) return radarSet;

    AssessmentEntry latestAssessment = assessmentHistory.last;
    final localization = AppLocalizations.of(context)!;
    
    if (!localization.questionMap.containsKey(latestAssessment.questionSet)) return radarSet;

    List<RadarEntry> idealEntries = [];
    List<RadarEntry> currentEntries = [];

    for (int i = 0; i < latestAssessment.values.length; i++) {
      // Logic for Radar Chart: Filter entries based on selection
      double value = latestAssessment.values[i];
      
      // If question is not selected, we set it to 0.0 or a neutral value
      // Alternatively, we could remove the axis, but RadarChart usually has fixed axes.
      // Let's use 0.0 for unselected questions to "hide" them from the shape.
      bool isSelected = i < selectedQuestions.length && selectedQuestions[i];
      
      idealEntries.add(const RadarEntry(value: 1.0));
      currentEntries.add(RadarEntry(value: isSelected ? (value == -1.0 ? 0.0 : value) : 0.0));
    }

    radarSet.add(RadarDataSet(
      borderColor: Colors.red.withValues(alpha: 0.5),
      fillColor: Colors.red.withValues(alpha: 0.1),
      dataEntries: idealEntries,
    ));

    radarSet.add(RadarDataSet(
      borderColor: Colors.green,
      fillColor: Colors.green.withValues(alpha: 0.3),
      dataEntries: currentEntries,
    ));
    
    return radarSet;
  }
}
