import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:self_examination/widgets/question_set_selection.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/localizations/app_localizations.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({'currentAuthor': 'Salvation Army Chemnitz'});
    await LocalStorage().initialize();
  });

  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(appBar: AppBar(title: child)),
    );
  }

  group('QuestionSetSelection Widget Tests', () {
    testWidgets('Should display selected author name in dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(
        child: const QuestionSetSelection(),
      ));
      await tester.pumpAndSettle();

      // Check if the author name is visible
      expect(find.text('Heilsarmee Chemnitz'), findsOneWidget);
    });

    testWidgets('Tapping info icon should open detailed dialog', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(
        child: const QuestionSetSelection(),
      ));
      await tester.pumpAndSettle();

      // Tap the info icon
      await tester.tap(find.byIcon(Icons.info_outline));
      await tester.pumpAndSettle();

      // Check if dialog content is visible (e.g., the title)
      expect(find.text('Heilsarmee Chemnitz'), findsNWidgets(2)); // Once in dropdown, once in dialog
      expect(find.text('OK'), findsOneWidget);
    });
  });
}
