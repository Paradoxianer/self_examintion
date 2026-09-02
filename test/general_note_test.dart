import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:self_examination/screens/assessment_screen.dart';
import 'package:self_examination/screens/chart_screen.dart';
import 'package:self_examination/widgets/chart_control_widget.dart';
import 'package:self_examination/widgets/general_note_card.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/localizations/app_localizations.dart';

void main() {
  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('de'),
      home: child,
    );
  }

  group('General Note (journaling) feature', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({
        'isSecurityEnabled': false,
        'agreedToDSGVO': true,
        'onboardingCompleted': true,
        'currentAuthor': 'William Booth',
      });
      await LocalStorage().initialize();
    });

    testWidgets('AssessmentScreen shows a GeneralNoteCard below the questions and persists it', (WidgetTester tester) async {
      final storage = LocalStorage();
      await tester.pumpWidget(makeTestableWidget(child: AssessmentScreen(localStorage: storage)));
      await tester.pumpAndSettle();

      // Scroll down to reveal the general note field below the question list.
      final noteFieldFinder = find.byType(GeneralNoteCard);
      await tester.dragUntilVisible(
        noteFieldFinder,
        find.byType(ListView),
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();

      expect(noteFieldFinder, findsOneWidget);

      await tester.enterText(
        find.descendant(of: noteFieldFinder, matching: find.byType(TextField)),
        'Heute war ein ruhiger, aber nachdenklicher Tag.',
      );
      await tester.pumpAndSettle();

      // Save via the FAB; confirm the "incomplete" warning since we didn't answer every slider.
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      if (find.text('Auswertung erstellen').evaluate().isNotEmpty) {
        await tester.tap(find.text('Auswertung erstellen'));
        await tester.pumpAndSettle();
      }

      expect(find.byType(ChartScreen), findsOneWidget);

      final history = await LocalStorage().loadAssessmentEntries();
      expect(history.length, 1);
      expect(history.first.note, 'Heute war ein ruhiger, aber nachdenklicher Tag.');
    });

    testWidgets('ChartControlWidget shows the general note under the Total card', (WidgetTester tester) async {
      // The 'William Booth' set has 11 questions; selectedQuestions needs one
      // extra slot (index 11) for the "Total" average card to be selected.
      final history = [
        AssessmentEntry(
          timestamp: DateTime(2026, 1, 1),
          questionSet: 'William Booth',
          values: List.generate(11, (_) => 0.5),
          questionNotes: List.generate(11, (_) => null),
          note: 'Insgesamt ein Tag voller Dankbarkeit.',
        ),
      ];

      await tester.pumpWidget(makeTestableWidget(
        child: Scaffold(
          body: ChartControlWidget(
            assessmentHistory: history,
            selectedQuestions: List.generate(12, (index) => true),
            currentTimeRange: TimeRange.all,
            onQuestionToggle: (_, __) {},
            onToggleAll: (_) {},
            onTimeRangeChange: (_) {},
            onNavigateTime: (_) {},
            onTodayPressed: () {},
            showAverage: true,
          ),
        ),
      ));
      await tester.pumpAndSettle();

      final averageIconFinder = find.byIcon(Icons.functions);
      await tester.dragUntilVisible(
        averageIconFinder,
        find.byType(ListView),
        const Offset(0, -200),
      );
      await tester.pumpAndSettle();

      expect(find.text('Insgesamt ein Tag voller Dankbarkeit.'), findsOneWidget);
    });
  });
}
