import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/utils/notification_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NotificationService', () {
    test('exposes sensible defaults when nothing is persisted yet', () async {
      SharedPreferences.setMockInitialValues({});
      await LocalStorage().initialize();

      final service = NotificationService();
      expect(service.isEnabled, false);
      expect(service.hour, 20);
      expect(service.minute, 0);
      expect(service.frequency, ReminderFrequency.daily);
    });

    test('reads back a previously persisted reminder configuration', () async {
      SharedPreferences.setMockInitialValues({
        'notificationsEnabled': true,
        'notificationHour': 7,
        'notificationMinute': 45,
        'notificationFrequency': 'monthly',
      });
      await LocalStorage().initialize();

      final service = NotificationService();
      expect(service.isEnabled, true);
      expect(service.hour, 7);
      expect(service.minute, 45);
      expect(service.frequency, ReminderFrequency.monthly);
    });

    test('enable() fails closed (disabled) when the OS notification plugin is unavailable', () async {
      // There's no platform channel implementation for flutter_local_notifications
      // in the test environment, so this exercises NotificationService's
      // try/catch fallback path rather than a real permission grant.
      SharedPreferences.setMockInitialValues({});
      await LocalStorage().initialize();

      final service = NotificationService();
      final bool granted = await service.enable(
        hour: 9,
        minute: 15,
        frequency: ReminderFrequency.weekly,
        title: 'title',
        body: 'body',
      );

      expect(granted, false);
      expect(service.isEnabled, false);
    });

    test('disable() persists the disabled flag', () async {
      SharedPreferences.setMockInitialValues({'notificationsEnabled': true});
      await LocalStorage().initialize();

      final service = NotificationService();
      expect(service.isEnabled, true);

      await service.disable();
      expect(service.isEnabled, false);
    });
  });
}
