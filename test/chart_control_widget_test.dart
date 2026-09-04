import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:self_examination/widgets/chart_control_widget.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/localizations/app_localizations.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({'currentAuthor': 'William Booth'});
    final storage = LocalStorage();
    await storage.initialize();
  });

  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('de'), // Force German for deterministic text matching
      home: Scaffold(body: child),
    );
  }

  group('ChartControlWidget Tests', () {
    testWidgets('Should display correct number of question cards and average', (WidgetTester tester) async {
      final history = <AssessmentEntry>[];
      final selected = List.generate(11, (index) => true);

      await tester.pumpWidget(makeTestableWidget(
        child: ChartControlWidget(
          assessmentHistory: history,
          selectedQuestions: selected,
          currentTimeRange: TimeRange.all,
          referenceDate: DateTime.now(),
          onQuestionToggle: (_, __) {},
          onToggleAll: (_) {},
          onTimeRangeChange: (_) {},
          onNavigateTime: (_) {},
          onTodayPressed: () {},
          showAverage: true,
        ),
      ));

      await tester.pumpAndSettle();

      // Check for first question number
      expect(find.text('1'), findsOneWidget);

      // Scroll down until the average icon is visible
      final averageIconFinder = find.byIcon(Icons.functions);
      await tester.dragUntilVisible(
        averageIconFinder,
        find.byType(ListView),
        const Offset(0, -200),
      );
      await tester.pumpAndSettle();
      
      expect(averageIconFinder, findsOneWidget);
    });

    testWidgets('Tapping a checkbox should trigger onQuestionToggle', (WidgetTester tester) async {
      int? toggledIndex;
      bool? newValue;

      await tester.pumpWidget(makeTestableWidget(
        child: ChartControlWidget(
          assessmentHistory: const [],
          selectedQuestions: List.generate(11, (index) => true),
          currentTimeRange: TimeRange.all,
          referenceDate: DateTime.now(),
          onQuestionToggle: (index, val) {
            toggledIndex = index;
            newValue = val;
          },
          onToggleAll: (_) {},
          onTimeRangeChange: (_) {},
          onNavigateTime: (_) {},
          onTodayPressed: () {},
        ),
      ));

      await tester.pumpAndSettle();

      // Tap the first checkbox (In the new UI, the first checkbox is the "Select All" toggle)
      // So we tap the second one for the first question card.
      await tester.tap(find.byType(Checkbox).at(1));
      await tester.pump();

      expect(toggledIndex, 0);
      expect(newValue, false);
    });

    testWidgets('Notes outside the selected time range are not shown (#59)', (WidgetTester tester) async {
      // Reference "today" for the week filter (a Wednesday, so the day
      // before it still falls inside the same Mon-Sun week).
      final referenceDate = DateTime(2026, 6, 17);
      final history = [
        AssessmentEntry(
          timestamp: DateTime(2026, 6, 16), // inside the reference week
          questionSet: 'William Booth',
          values: List.generate(11, (_) => 0.5),
          questionNotes: [
            'In-range note',
            ...List<String?>.generate(10, (_) => null),
          ],
        ),
        AssessmentEntry(
          timestamp: DateTime(2026, 1, 1), // months outside the reference week
          questionSet: 'William Booth',
          values: List.generate(11, (_) => 0.5),
          questionNotes: [
            'Out-of-range note',
            ...List<String?>.generate(10, (_) => null),
          ],
        ),
      ];

      await tester.pumpWidget(makeTestableWidget(
        child: ChartControlWidget(
          assessmentHistory: history,
          selectedQuestions: List.generate(12, (index) => true),
          currentTimeRange: TimeRange.week,
          referenceDate: referenceDate,
          onQuestionToggle: (_, __) {},
          onToggleAll: (_) {},
          onTimeRangeChange: (_) {},
          onNavigateTime: (_) {},
          onTodayPressed: () {},
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('In-range note'), findsOneWidget);
      expect(find.text('Out-of-range note'), findsNothing);
    });
  });
}
