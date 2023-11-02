import 'package:flutter/material.dart';
import 'package:self_examintion/models/assessment_entry.dart';
import 'package:self_examintion/widgets/chart_widget.dart';
import 'package:self_examintion/utils/local_storage.dart';

class ChartScreen extends StatefulWidget {
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<AssessmentEntry> assessmentHistory = [];
  final LocalStorage _localStorage = LocalStorage();

  @override
  void initState() {
    super.initState();
    loadAssessmentHistory();
  }

  Future<void> loadAssessmentHistory() async {
    try {
      await _localStorage.initialize();
      final history = await _localStorage.loadAssessmentEntries();
      setState(() {
        assessmentHistory = history;
      });
    } catch (e) {
      // Handle any errors when loading data
      print('Error loading assessment history: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entwicklungsdiagramm'),
      ),
      body: assessmentHistory.isEmpty
          ? Center(child: Text('No assessment history available.'))
          : ChartWidget(assessmentHistory: assessmentHistory),
    );
  }
}