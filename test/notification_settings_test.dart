import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:self_examination/widgets/notification_settings_section.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/utils/local_storage.dart';

void main() {
  Widget makeTestableWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('de'),
      home: const Scaffold(body: NotificationSettingsSection()),
    );
  }

  group('NotificationSettingsSection', () {
    testWidgets('is off by default and hides time/frequency controls', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await LocalStorage().initialize();

      await tester.pumpWidget(makeTestableWidget());
      await tester.pumpAndSettle();

      final switchFinder = find.byType(SwitchListTile);
      expect(switchFinder, findsOneWidget);
      expect(tester.widget<SwitchListTile>(switchFinder).value, false);
      expect(find.byIcon(Icons.access_time), findsNothing);
      expect(find.byType(ChoiceChip), findsNothing);
    });

    testWidgets('reflects persisted enabled state with time and frequency controls', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        'notificationsEnabled': true,
        'notificationHour': 7,
        'notificationMinute': 30,
        'notificationFrequency': 'weekly',
      });
      await LocalStorage().initialize();

      await tester.pumpWidget(makeTestableWidget());
      await tester.pumpAndSettle();

      expect(tester.widget<SwitchListTile>(find.byType(SwitchListTile)).value, true);
      expect(find.text('07:30'), findsOneWidget);
      expect(find.byType(ChoiceChip), findsNWidgets(3));

      final weeklyChip = tester.widget<ChoiceChip>(find.widgetWithText(ChoiceChip, 'wöchentlich'));
      expect(weeklyChip.selected, true);
    });
  });
}
