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
    // Start with a clean state
    SharedPreferences.setMockInitialValues({
      'isSecurityEnabled': false, // Disable lock for test flow
      'agreedToDSGVO': true,      // Skip GDPR dialog
      'currentAuthor': 'ten commandments'
    });
    await LocalStorage().initialize();
  });

  group('End-to-End Integration Flow', () {
    testWidgets('Complete assessment cycle and view results', (WidgetTester tester) async {
      // 1. Build the App with forced German locale
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale('de'),
          home: AuthWrapper(),
        ),
      );
      
      // Wait for AuthWrapper to initialize and redirect to HomeScreen
      await tester.pumpAndSettle();

      // 2. Navigate to AssessmentScreen
      final startButtonFinder = find.text('Starten');
      expect(startButtonFinder, findsOneWidget);
      await tester.tap(startButtonFinder);
      await tester.pumpAndSettle();

      // 3. Interact with the first QuestionCard
      expect(find.byType(QuestionCard), findsWidgets);
      
      // Drag the first slider to approx 80%
      await tester.drag(find.byType(Slider).first, const Offset(150.0, 0.0));
      await tester.pumpAndSettle();

      // 4. Save the Assessment
      final fabFinder = find.byType(FloatingActionButton);
      expect(fabFinder, findsOneWidget);
      await tester.tap(fabFinder);
      await tester.pumpAndSettle();

      // 5. Handle Unanswered Warning (if it appears)
      final okButtonFinder = find.text('OK');
      if (tester.any(okButtonFinder)) {
        await tester.tap(okButtonFinder);
        await tester.pumpAndSettle();
      }

      // 6. Verify Navigation to ChartScreen
      expect(find.byType(ChartScreen), findsOneWidget);
      expect(find.byType(PageView), findsOneWidget);
      
      // 7. Check if data persisted
      final history = await LocalStorage().loadAssessmentEntries();
      expect(history.isNotEmpty, true);
      expect(history.last.values.first > 0.5, true);
    });
  });
}
