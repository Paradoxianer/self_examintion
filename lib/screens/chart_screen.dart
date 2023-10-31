import 'package:flutter/material.dart';
import 'package:self_examintion/models/assessment_entry.dart';
import 'package:self_examintion/widgets/chart_widget.dart';

class ChartScreen extends Scaffold {
  final List<AssessmentEntry> assessmentHistory;

  ChartScreen({required this.assessmentHistory})
      : super(
    appBar: AppBar(
      title: Text('Entwicklungsdiagramm'),
    ),
    body: ChartWidget(assessmentHistory: assessmentHistory),
  );

}

