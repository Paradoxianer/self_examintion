import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:self_examination/widgets/question_set_selection.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/localizations/app_localizations.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({'currentAuthor': 'Salvation Army Chemnitz'});
    final storage = LocalStorage();
    await storage.initialize();
  });

  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('de'),
      home: Scaffold(
        appBar: AppBar(
          // Geben wir dem Widget in der AppBar explizit Breite
          title: child,
        ),
      ),
    );
  }

  group('QuestionSetSelection Widget Tests', () {
    testWidgets('Should display selected author name in dropdown', (WidgetTester tester) async {
      // Größere Testfläche definieren
      await tester.binding.setSurfaceSize(const Size(1200, 800));

      await tester.pumpWidget(makeTestableWidget(
        child: const QuestionSetSelection(),
      ));
      await tester.pumpAndSettle();

      // Wir suchen nach dem Text im Dropdown
      expect(find.text('Heilsarmee Chemnitz'), findsOneWidget);

      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('Tapping info icon should open detailed dialog', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));

      await tester.pumpWidget(makeTestableWidget(
        child: const QuestionSetSelection(),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.info_outline));
      await tester.pumpAndSettle();

      // Dialog sollte jetzt offen sein
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);

      await tester.binding.setSurfaceSize(null);
    });
  });
}
