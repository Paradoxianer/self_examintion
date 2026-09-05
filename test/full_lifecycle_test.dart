import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:self_examination/main.dart';
import 'package:self_examination/screens/assessment_screen.dart';
import 'package:self_examination/screens/chart_screen.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/widgets/question_card.dart';
import 'package:self_examination/localizations/app_localizations.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'isSecurityEnabled': false,
      'agreedToDSGVO': true,
      'onboardingCompleted': true,
      'currentAuthor': 'William Booth'
    });
    final storage = LocalStorage();
    await storage.initialize(assessmentDatabasePath: ':memory:');
  });

  Widget makeTestableWidget() {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('de'),
      home: AuthWrapper(),
    );
  }

  testWidgets('Full Lifecycle: Start -> Slider -> Note -> Save -> Chart', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());
    await tester.pumpAndSettle();

    // 1. Home Screen - Starten
    final startButton = find.text('Starten');
    expect(startButton, findsOneWidget);
    await tester.tap(startButton);
    await tester.pumpAndSettle();

    // 2. Assessment Screen
    expect(find.byType(AssessmentScreen), findsOneWidget);
    
    // Interact with first slider
    final slider = find.byType(Slider).first;
    await tester.drag(slider, const Offset(100.0, 0.0));
    await tester.pumpAndSettle();

    // Add a note
    final noteIcon = find.byIcon(Icons.note_add_outlined).first;
    await tester.tap(noteIcon);
    await tester.pumpAndSettle();
    
    final textField = find.byType(TextField).first;
    await tester.enterText(textField, 'Test Notiz Lifecycle');
    await tester.pumpAndSettle();

    // 3. Save
    final saveButton = find.byType(FloatingActionButton);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    // Handle "Please answer all" if it appears (we only moved one slider)
    if (find.text('Auswertung erstellen').evaluate().isNotEmpty) {
      await tester.tap(find.text('Auswertung erstellen'));
      await tester.pumpAndSettle();
    }

    // 4. Chart Screen
    expect(find.byType(ChartScreen), findsOneWidget);
    
    // Verify data in LocalStorage
    final history = await LocalStorage().loadAssessmentEntries();
    expect(history.length, 1);
    expect(history.first.questionNotes.any((n) => n == 'Test Notiz Lifecycle'), true);
  });
}
