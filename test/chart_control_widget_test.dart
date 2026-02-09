import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:self_examination/widgets/chart_control_widget.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/localizations/app_localizations.dart';

void main() {
  setUp(() async {
    // Initialize LocalStorage with mock data
    SharedPreferences.setMockInitialValues({'currentAuthor': 'Salvation Army Chemnitz'});
    final storage = LocalStorage();
    await storage.initialize();
  });

  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    );
  }

  group('ChartControlWidget Tests', () {
    testWidgets('Should display correct number of question cards', (WidgetTester tester) async {
      final history = <AssessmentEntry>[];
      // Salvation Army set has 10 questions. We provide selection for all 10 + 1 for avg
      final selected = List.generate(11, (index) => true);

      await tester.pumpWidget(makeTestableWidget(
        child: ChartControlWidget(
          assessmentHistory: history,
          selectedQuestions: selected,
          currentTimeRange: TimeRange.all,
          onQuestionToggle: (_, __) {},
          onTimeRangeChange: (_) {},
          onNavigateTime: (_) {},
          onTodayPressed: () {},
          showAverage: true,
        ),
      ));

      // Wait for rendering to complete
      await tester.pumpAndSettle();

      // Check for first few question numbers
      expect(find.text('1'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
      
      // The average card uses an Icon
      expect(find.byIcon(Icons.functions), findsOneWidget);
    });

    testWidgets('Tapping a checkbox should trigger onQuestionToggle', (WidgetTester tester) async {
      int? toggledIndex;
      bool? newValue;

      await tester.pumpWidget(makeTestableWidget(
        child: ChartControlWidget(
          assessmentHistory: const [],
          selectedQuestions: List.generate(11, (index) => true),
          currentTimeRange: TimeRange.all,
          onQuestionToggle: (index, val) {
            toggledIndex = index;
            newValue = val;
          },
          onTimeRangeChange: (_) {},
          onNavigateTime: (_) {},
          onTodayPressed: () {},
        ),
      ));

      await tester.pumpAndSettle();

      // Find first checkbox and tap it
      // Note: Tap the Checkbox widget itself
      await tester.tap(find.byType(Checkbox).first);
      await tester.pump();

      expect(toggledIndex, 0);
      expect(newValue, false);
    });
  });
}
