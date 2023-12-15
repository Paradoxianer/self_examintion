import 'package:flutter/material.dart';
import 'package:self_examintion/localizations/app_localizations.dart';
import 'package:self_examintion/models/assessment_entry.dart';
import 'package:self_examintion/screens/settings_screen.dart';
import 'package:self_examintion/widgets/comparison_chart.dart';
import 'package:self_examintion/widgets/month_chart_widget.dart';
import 'package:self_examintion/utils/local_storage.dart';

class ChartScreen extends StatefulWidget {
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<AssessmentEntry> assessmentHistory = [];
  final LocalStorage _localStorage = LocalStorage();
  PageController _pageController = PageController();
  int _selectedChartIndex = 0;

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
        title: Row(
            children : [ Text(AppLocalizations.of(context)!.chartTitle),
        Expanded(
          child: Center(
            child: DropdownButton(
              value: _selectedChartIndex,
              items: [
                DropdownMenuItem(
                  child: Text(AppLocalizations.of(context)!.compareChart),
                  value: 0,
                ),
                DropdownMenuItem(
                  child: Text(AppLocalizations.of(context)!.timeChart),
                  value: 1,
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedChartIndex = value as int;
                  _pageController.animateToPage(
                    _selectedChartIndex,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                });
              },
            ),
          ),
        )]),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: assessmentHistory.isEmpty
          ? Center(child: Text(AppLocalizations.of(context)!.noHistory))
          : Column(
        children: [
          // Dropdown-Menü für die Auswahl des Charts
          // Anzeige des ausgewählten Charts im PageView
          Expanded(
            child: PageView(
              allowImplicitScrolling: true,
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              children: [
                ComparisonChartWidget(
                  assessmentHistory: assessmentHistory,
                ),
                MonthChartWidget(
                  assessmentHistory: assessmentHistory,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
