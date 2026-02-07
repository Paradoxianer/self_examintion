import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/globals.dart';

class RadarChartWidget extends StatefulWidget {
  final List<AssessmentEntry> assessmentHistory;

  const RadarChartWidget({super.key, required this.assessmentHistory});

  @override
  _RadarChartWidgetState createState() => _RadarChartWidgetState();
}

class _RadarChartWidgetState extends State<RadarChartWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.assessmentHistory.isEmpty) {
      return const Center(child: Text("No data available"));
    }

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
                  dataSets: latestAnswerScore(context),
                  getTitle: (index, angle) {
                    return RadarChartTitle(text: (index + 1).toString());
                  },
                ),
                duration: const Duration(milliseconds: 150),
                curve: Curves.linear,
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<RadarDataSet> latestAnswerScore(BuildContext context) {
    List<RadarDataSet> radarSet = [];
    if (widget.assessmentHistory.isEmpty) return radarSet;

    AssessmentEntry latestAssessment = widget.assessmentHistory.last;
    final localization = AppLocalizations.of(context)!;
    
    if (!localization.questionMap.containsKey(latestAssessment.questionSet)) return radarSet;

    List<RadarEntry> idealEntries = [];
    List<RadarEntry> currentEntries = [];

    for (int i = 0; i < latestAssessment.values.length; i++) {
      double value = latestAssessment.values[i];
      if (value == -1.0) value = 0.5; // Default for radar if not answered

      idealEntries.add(const RadarEntry(value: 1.0));
      currentEntries.add(RadarEntry(value: value));
    }

    radarSet.add(RadarDataSet(
      borderColor: Colors.red.withValues(alpha: 0.5),
      fillColor: Colors.red.withValues(alpha: 0.2),
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
