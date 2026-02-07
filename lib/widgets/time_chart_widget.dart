import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/utils/local_storage.dart';

class TimeChartWidget extends StatefulWidget {
  final List<AssessmentEntry> assessmentHistory;

  TimeChartWidget({required this.assessmentHistory});

  @override
  _TimeChartWidgetState createState() => _TimeChartWidgetState();
}

class _TimeChartWidgetState extends State<TimeChartWidget> {
  List<bool> selectedQuestions = [];

  @override
  void initState() {
    super.initState();
    if (widget.assessmentHistory.isNotEmpty) {
      selectedQuestions = List.generate(
        widget.assessmentHistory[0].values.length,
        (index) => true,
      );
    }
  }

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
              child: LineChart(
                LineChartData(
                  minX: calculateMinX(),
                  maxX: calculateMaxX(),
                  minY: 0,
                  maxY: 1.1,
                  lineBarsData: [
                    LineChartBarData(
                      spots: getOverallScores(context),
                      isCurved: true,
                      color: Colors.red,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                    ),
                    for (int i = 0; i < selectedQuestions.length; i++)
                      if (selectedQuestions[i])
                        LineChartBarData(
                          spots: getQuestionScores(context, i),
                          isCurved: true,
                          color: globalColorMap[i + 1] ?? Colors.blue,
                          barWidth: 2,
                          dotData: const FlDotData(show: false),
                        ),
                  ],
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) => bottomTitleWidgets(value, meta, context),
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) => leftTitleWidgets(value, meta, context),
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  gridData: const FlGridData(show: true, horizontalInterval: 0.2),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: selectedQuestions.length,
            itemBuilder: (context, index) {
              final authorKey = LocalStorage().getCurrentAuthor();
              final questionSet = AppLocalizations.of(context)!.questionMap[authorKey];
              return Card(
                child: ListTile(
                  leading: Checkbox(
                    value: selectedQuestions[index],
                    activeColor: globalColorMap[index + 1],
                    onChanged: (value) {
                      setState(() {
                        selectedQuestions[index] = value!;
                      });
                    },
                  ),
                  title: Text(
                    questionSet?.questions[index].text ?? 'Question ${index + 1}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  double calculateMinX() {
    if (widget.assessmentHistory.isEmpty) return 0;
    return widget.assessmentHistory.first.timestamp.millisecondsSinceEpoch.toDouble();
  }

  double calculateMaxX() {
    if (widget.assessmentHistory.isEmpty) return 100;
    return widget.assessmentHistory.last.timestamp.millisecondsSinceEpoch.toDouble();
  }

  List<FlSpot> getOverallScores(BuildContext context) {
    return widget.assessmentHistory.map((entry) {
      double avg = 0;
      int count = 0;
      for (var val in entry.values) {
        if (val != -1.0) {
          avg += val;
          count++;
        }
      }
      return FlSpot(
        entry.timestamp.millisecondsSinceEpoch.toDouble(),
        count > 0 ? avg / count : 0,
      );
    }).toList();
  }

  List<FlSpot> getQuestionScores(BuildContext context, int index) {
    List<FlSpot> spots = [];
    for (var entry in widget.assessmentHistory) {
      if (index < entry.values.length && entry.values[index] != -1.0) {
        spots.add(FlSpot(
          entry.timestamp.millisecondsSinceEpoch.toDouble(),
          entry.values[index],
        ));
      }
    }
    return spots;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    return SideTitleWidget(
      meta: meta,
      child: Text("${date.day}.${date.month}.", style: const TextStyle(fontSize: 8)),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    return SideTitleWidget(
      meta: meta,
      child: Text("${(value * 100).toInt()}%", style: const TextStyle(fontSize: 8)),
    );
  }
}
