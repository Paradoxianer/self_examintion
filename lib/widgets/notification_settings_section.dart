import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/utils/notification_service.dart';

/// Settings section for the daily-examination reminder (#3).
///
/// Not offered on web — local notifications aren't reliably delivered there
/// (no background scheduling without an open tab), so this just shows a
/// disabled row explaining that instead of a broken toggle.
class NotificationSettingsSection extends StatefulWidget {
  const NotificationSettingsSection({super.key});

  @override
  State<NotificationSettingsSection> createState() => _NotificationSettingsSectionState();
}

class _NotificationSettingsSectionState extends State<NotificationSettingsSection> {
  final NotificationService _service = NotificationService();
  late bool _enabled;
  late TimeOfDay _time;
  late ReminderFrequency _frequency;

  @override
  void initState() {
    super.initState();
    _enabled = _service.isEnabled;
    _time = TimeOfDay(hour: _service.hour, minute: _service.minute);
    _frequency = _service.frequency;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    if (kIsWeb) {
      return ListTile(
        leading: Icon(Icons.notifications_outlined, color: Theme.of(context).disabledColor),
        title: Text(localization.notification, style: TextStyle(color: Theme.of(context).disabledColor)),
      );
    }

    return Column(
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.notifications_outlined),
          title: Text(localization.notification),
          value: _enabled,
          onChanged: _onToggle,
        ),
        if (_enabled) ...[
          ListTile(
            leading: const Icon(Icons.access_time, size: 20),
            title: Text(_time.format(context)),
            onTap: _pickTime,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Wrap(
              spacing: 8,
              children: [
                _buildFrequencyChip(ReminderFrequency.daily, localization.daily),
                _buildFrequencyChip(ReminderFrequency.weekly, localization.weekly),
                _buildFrequencyChip(ReminderFrequency.monthly, localization.monthly),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFrequencyChip(ReminderFrequency value, String label) {
    return ChoiceChip(
      label: Text(label),
      selected: _frequency == value,
      onSelected: (_) => _onFrequencyChanged(value),
    );
  }

  Future<void> _onToggle(bool value) async {
    final localization = AppLocalizations.of(context)!;

    if (!value) {
      await _service.disable();
      if (!mounted) return;
      setState(() => _enabled = false);
      return;
    }

    final bool granted = await _service.enable(
      hour: _time.hour,
      minute: _time.minute,
      frequency: _frequency,
      title: localization.examinTitle,
      body: localization.notificationReminderBody,
    );

    if (!mounted) return;
    setState(() => _enabled = granted);

    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localization.notificationPermissionDenied)),
      );
    }
  }

  Future<void> _pickTime() async {
    final localization = AppLocalizations.of(context)!;
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: _time);
    if (picked == null || !mounted) return;

    setState(() => _time = picked);
    await _service.enable(
      hour: picked.hour,
      minute: picked.minute,
      frequency: _frequency,
      title: localization.examinTitle,
      body: localization.notificationReminderBody,
    );
  }

  Future<void> _onFrequencyChanged(ReminderFrequency value) async {
    final localization = AppLocalizations.of(context)!;
    setState(() => _frequency = value);
    await _service.enable(
      hour: _time.hour,
      minute: _time.minute,
      frequency: value,
      title: localization.examinTitle,
      body: localization.notificationReminderBody,
    );
  }
}
