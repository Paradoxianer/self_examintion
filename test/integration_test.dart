import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:self_examination/main.dart';
import 'package:self_examination/screens/assessment_screen.dart';
import 'package:self_examination/screens/chart_screen.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/widgets/question_card.dart';

void main() {
  setUp(() async {
    // Start with a clean state
    SharedPreferences.setMockInitialValues({
      'isSecurityEnabled': false, // Disable lock for test flow
      'agreedToDSGVO': true,      // Skip GDPR dialog
      'currentAuthor': 'Salvation Army Chemnitz'
    });
    await LocalStorage().initialize();
  });

  group('End-to-End Integration Flow', () {
    testWidgets('Complete assessment cycle and view results', (WidgetTester tester) async {
      // 1. Build the App
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Ensure we are on the Assessment Screen (Start screen)
      // Note: Depending on your home_screen logic, we might need to tap "Start" first.
      // Assuming AuthWrapper redirects to HomeScreen and we tap Start.
      
      if (find.text('Starten').exists) { // German 'Start' button
         await tester.tap(find.text('Starten'));
         await tester.pumpAndSettle();
      }

      // 2. Interact with the first QuestionCard
      expect(find.byType(QuestionCard), findsWidgets);
      
      // Drag the first slider to 80% (approx)
      await tester.drag(find.byType(Slider).first, const Offset(150.0, 0.0));
      await tester.pumpAndSettle();

      // 3. Save the Assessment
      final fabFinder = find.byType(FloatingActionButton);
      expect(fabFinder, findsOneWidget);
      await tester.tap(fabFinder);
      await tester.pumpAndSettle();

      // 4. Handle Unanswered Warning (if it appears)
      if (find.byType(AlertDialog).exists) {
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();
      }

      // 5. Verify Navigation to ChartScreen
      expect(find.byType(ChartScreen), findsOneWidget);
      
      // Verify that at least one Chart is visible
      expect(find.byType(PageView), findsOneWidget);
      
      // 6. Check if data persisted
      final history = await LocalStorage().loadAssessmentEntries();
      expect(history.isNotEmpty, true);
      expect(history.last.values.first > 0.5, true); // Verified our 80% drag
    });
  });
}
