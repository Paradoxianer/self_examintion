import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/widgets/comparison_chart.dart';
import 'package:self_examination/widgets/question_set_selection.dart';
import 'package:self_examination/widgets/radar_chart_widget.dart';
import 'package:self_examination/widgets/time_chart_widget.dart';

class ChartScreen extends StatelessWidget {
  final LocalStorage localStorage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: localStorage.assessmentNotifier,
      builder: (context, _) {
        return FutureBuilder<List<AssessmentEntry>>(
          future: localStorage.loadAssessmentEntries(),
          builder: (context, snapshot) {
            final history = snapshot.data ?? [];
            final localization = AppLocalizations.of(context)!;

            return DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  title: QuestionSetSelection(),
                  bottom: TabBar(
                    tabs: [
                      Tab(text: localization.compareChart),
                      Tab(text: localization.timeChart),
                      Tab(text: "Radar Chart"),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    history.isEmpty
                        ? Center(child: Text(localization.noHistory))
                        : ComparisonChartWidget(assessmentHistory: history),
                    history.isEmpty
                        ? Center(child: Text(localization.noHistory))
                        : TimeChartWidget(assessmentHistory: history),
                    history.isEmpty
                        ? Center(child: Text(localization.noHistory))
                        : RadarChartWidget(assessmentHistory: history),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
