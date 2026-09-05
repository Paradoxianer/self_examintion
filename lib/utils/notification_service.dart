import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import 'package:self_examination/utils/local_storage.dart';

/// How often the daily-examination reminder should repeat.
enum ReminderFrequency { daily, weekly, monthly }

/// Manages the local (on-device) reminder notification (#3).
///
/// This never talks to a push/remote server — it just schedules an
/// OS-level recurring notification at a user-chosen time. Not supported
/// on web (no reliable background delivery there), so callers should
/// guard UI with `kIsWeb` before offering this.
class NotificationService {
  static const int _reminderNotificationId = 100;
  static const String _channelId = 'daily_reminder';

  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  final LocalStorage _localStorage = LocalStorage();
  bool _initialized = false;

  bool get isEnabled => _localStorage.getBool('notificationsEnabled', defaultValue: false);
  int get hour => _localStorage.getInt('notificationHour', defaultValue: 20);
  int get minute => _localStorage.getInt('notificationMinute', defaultValue: 0);

  ReminderFrequency get frequency {
    final String? stored = _localStorage.getString('notificationFrequency');
    return ReminderFrequency.values.firstWhere(
      (f) => f.name == stored,
      orElse: () => ReminderFrequency.daily,
    );
  }

  /// Requests the OS notification permission and, if granted, persists the
  /// settings and schedules the reminder. Returns whether it ended up enabled.
  Future<bool> enable({
    required int hour,
    required int minute,
    required ReminderFrequency frequency,
    required String title,
    required String body,
  }) async {
    if (kIsWeb) return false;

    try {
      await _ensureInitialized();
      final bool granted = await _requestPermission();
      if (!granted) {
        await _localStorage.setBool('notificationsEnabled', false);
        return false;
      }

      await _localStorage.setBool('notificationsEnabled', true);
      await _localStorage.setInt('notificationHour', hour);
      await _localStorage.setInt('notificationMinute', minute);
      await _localStorage.setString('notificationFrequency', frequency.name);

      await _schedule(hour: hour, minute: minute, frequency: frequency, title: title, body: body);
      return true;
    } catch (e) {
      debugPrint('NotificationService.enable failed: $e');
      await _localStorage.setBool('notificationsEnabled', false);
      return false;
    }
  }

  Future<void> disable() async {
    await _localStorage.setBool('notificationsEnabled', false);
    if (kIsWeb) return;
    try {
      await _ensureInitialized();
      await _plugin.cancel(id: _reminderNotificationId);
    } catch (e) {
      debugPrint('NotificationService.disable failed: $e');
    }
  }

  /// Re-schedules the reminder from persisted settings, e.g. after the
  /// user changed the app language (notification text is localized).
  /// No-op if reminders aren't currently enabled.
  Future<void> rescheduleIfEnabled({required String title, required String body}) async {
    if (!isEnabled || kIsWeb) return;
    try {
      await _ensureInitialized();
      await _schedule(hour: hour, minute: minute, frequency: frequency, title: title, body: body);
    } catch (e) {
      debugPrint('NotificationService.rescheduleIfEnabled failed: $e');
    }
  }

  Future<void> _ensureInitialized() async {
    if (_initialized) return;

    tz_data.initializeTimeZones();
    try {
      final String timeZoneName = (await FlutterTimezone.getLocalTimezone()).identifier;
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (e) {
      debugPrint('NotificationService: could not resolve local timezone, defaulting to UTC: $e');
    }

    const androidSettings = AndroidInitializationSettings('@mipmap/launcher_icon');
    const iosSettings = DarwinInitializationSettings();
    await _plugin.initialize(
      settings: const InitializationSettings(android: androidSettings, iOS: iosSettings),
    );
    _initialized = true;
  }

  Future<bool> _requestPermission() async {
    final androidImpl = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl != null) {
      return await androidImpl.requestNotificationsPermission() ?? false;
    }

    final iosImpl = _plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    if (iosImpl != null) {
      return await iosImpl.requestPermissions(alert: true, badge: true, sound: true) ?? false;
    }

    // Desktop platforms don't gate on a runtime permission.
    return true;
  }

  Future<void> _schedule({
    required int hour,
    required int minute,
    required ReminderFrequency frequency,
    required String title,
    required String body,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    final DateTimeComponents matchComponents = switch (frequency) {
      ReminderFrequency.daily => DateTimeComponents.time,
      ReminderFrequency.weekly => DateTimeComponents.dayOfWeekAndTime,
      ReminderFrequency.monthly => DateTimeComponents.dayOfMonthAndTime,
    };

    await _plugin.zonedSchedule(
      id: _reminderNotificationId,
      title: title,
      body: body,
      scheduledDate: scheduled,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          'Reminders',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      // Inexact is enough for a personal daily reminder and avoids needing
      // the SCHEDULE_EXACT_ALARM permission (extra Play Store scrutiny).
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: matchComponents,
    );
  }
}
