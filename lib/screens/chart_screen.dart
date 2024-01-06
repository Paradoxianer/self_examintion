import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/screens/settings_screen.dart';
import 'package:self_examination/widgets/comparison_chart.dart';
import 'package:self_examination/widgets/time_chart_widget.dart';
import 'package:self_examination/utils/local_storage.dart';

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${AppLocalizations.of(context)!.chartTitle} - ${LocalStorage().getCurrentAuthor()}",overflow: TextOverflow.ellipsis,),
     /*     actions: [
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
          ],*/
          bottom: TabBar(
            tabs: [
              Tab(text: AppLocalizations.of(context)!.compareChart),
              Tab(text: AppLocalizations.of(context)!.timeChart)
            ],
          ),
        ),
        body:
             TabBarView(
                children: [
        assessmentHistory.isEmpty ?
                Center(child: Text(AppLocalizations.of(context)!.noHistory))
                 :  ComparisonChartWidget(
                    assessmentHistory: assessmentHistory,
                  ),
    assessmentHistory.isEmpty ?
    Center(child: Text(AppLocalizations.of(context)!.noHistory))
        :TimeChartWidget(
                    assessmentHistory: assessmentHistory,
                  ),
                ],
          )
    )
    );

  }
}
