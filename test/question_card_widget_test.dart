import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:self_examination/models/question.dart';
import 'package:self_examination/widgets/question_card.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  /// Helper to wrap the widget under test with localization support.
  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    );
  }

  group('QuestionCard Widget Tests', () {
    testWidgets('Should display question text and card number', (WidgetTester tester) async {
      final question = Question(text: 'Test Question');
      
      await tester.pumpWidget(makeTestableWidget(
        child: QuestionCard(
          cardNumber: 1,
          question: question,
          onSliderChanged: (_) {},
        ),
      ));

      expect(find.text('Test Question'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('Tapping note icon should toggle note text field', (WidgetTester tester) async {
      final question = Question(text: 'Test Question');
      
      await tester.pumpWidget(makeTestableWidget(
        child: QuestionCard(
          cardNumber: 1,
          question: question,
          onSliderChanged: (_) {},
        ),
      ));

      // Initial state: No TextField
      expect(find.byType(TextField), findsNothing);

      // Tap note add icon
      await tester.tap(find.byIcon(Icons.note_add_outlined));
      await tester.pump();

      // Should now show TextField
      expect(find.byType(TextField), findsOneWidget);

      // Tap again to hide
      await tester.tap(find.byIcon(Icons.note));
      await tester.pump();
      expect(find.byType(TextField), findsNothing);
    });

    testWidgets('Moving slider should trigger callback', (WidgetTester tester) async {
      double? changedValue;
      final question = Question(text: 'Test Question', value: 0.5);
      
      await tester.pumpWidget(makeTestableWidget(
        child: QuestionCard(
          cardNumber: 1,
          question: question,
          onSliderChanged: (val) => changedValue = val,
        ),
      ));

      // Drag slider to the right
      await tester.drag(find.byType(Slider), const Offset(100.0, 0.0));
      await tester.pump();

      expect(changedValue, isNotNull);
      expect(changedValue! > 0.5, isTrue);
    });
  });
}
