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
          onQuestionToggle: (_, __) {},
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

      // Tap the first checkbox
      await tester.tap(find.byType(Checkbox).first);
      await tester.pump();

      expect(toggledIndex, 0);
      expect(newValue, false);
    });
  });
}
