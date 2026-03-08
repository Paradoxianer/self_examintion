import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:self_examination/screens/settings_screen.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/localizations/app_localizations.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final storage = LocalStorage();
    await storage.initialize();
  });

  Widget makeTestableWidget() {
    final storage = LocalStorage();
    return ListenableBuilder(
      listenable: storage.settingsNotifier,
      builder: (context, _) {
        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: storage.locale,
          home: SettingsScreen(),
        );
      },
    );
  }

  group('SettingsFlow Widget Tests', () {
    testWidgets('Changing language should rebuild UI with new localization', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget());
      await tester.pumpAndSettle();

      // 1. Initial State (English or System - but we forced null in setUp, so it uses system/default)
      // Let's assume it starts in English or German.
      // We look for the "Settings" title.
      
      // 2. Open Language Dialog
      final languageTile = find.byIcon(Icons.language);
      expect(languageTile, findsOneWidget);
      await tester.tap(languageTile);
      await tester.pumpAndSettle();

      // 3. Select "Deutsch"
      final germanOption = find.text('Deutsch');
      expect(germanOption, findsOneWidget);
      await tester.tap(germanOption);
      await tester.pumpAndSettle();

      // 4. Verify UI changed to German
      // "Settings" should now be "Einstellungen"
      expect(find.text('Einstellungen'), findsOneWidget);
      
      // 5. Change back to English
      await tester.tap(find.byIcon(Icons.language));
      await tester.pumpAndSettle();
      
      final englishOption = find.text('English');
      expect(englishOption, findsOneWidget);
      await tester.tap(englishOption);
      await tester.pumpAndSettle();
      
      // 6. Verify UI changed back to English
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('Language selection should persist in LocalStorage', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.language));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Deutsch'));
      await tester.pumpAndSettle();

      final storage = LocalStorage();
      expect(storage.locale?.languageCode, 'de');
    });
  });
}
