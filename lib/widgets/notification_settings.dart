import 'package:flutter/material.dart';
import 'package:self_examintion/utils/local_storage.dart';

class NotificationsSettings extends StatefulWidget {
  final bool reminderEnabled;
  final String reminderFrequency;
  final Function(bool enabled, String frequency) onChanged;

  NotificationsSettings({
    required this.reminderEnabled,
    required this.reminderFrequency,
    required this.onChanged,
  });

  @override
  _NotificationsSettingsState createState() => _NotificationsSettingsState();
}

class _NotificationsSettingsState extends State<NotificationsSettings> {
  bool _notificationOn =false;
  String _selectedFrequency ="daily";

  @override
  void initState() {
    super.initState();
    _notificationOn = widget.reminderEnabled;
    _selectedFrequency = widget.reminderFrequency;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Enable Notifications"),
            Switch(
              value: _notificationOn,
              onChanged: (value) {
                setState(() {
                  _notificationOn = value;
                  // Store the enabled/disabled state in LocalStorage
                  LocalStorage().setBool('notificationsEnabled', value);
                  widget.onChanged(value, _selectedFrequency);
                });
              },
            ),
          ],
        ),
        RadioListTile(
          title: Text('Daily'),
          value: 'daily',
          groupValue: _selectedFrequency,
          onChanged: (value) {
            setState(() {
              _selectedFrequency = value!;
              // Store the frequency setting in LocalStorage
              LocalStorage().setString('notificationFrequency', value);
              widget.onChanged(_notificationOn, value);
            });
          },
        ),
        RadioListTile(
          title: Text('Weekly'),
          value: 'weekly',
          groupValue: _selectedFrequency,
          onChanged: (value) {
            setState(() {
              _selectedFrequency = value!;
              // Store the frequency setting in LocalStorage
              LocalStorage().setString('notificationFrequency', value);
              widget.onChanged(_notificationOn, value);
            });
          },
        ),
        RadioListTile(
          title: Text('Monthly'),
          value: 'monthly',
          groupValue: _selectedFrequency,
          onChanged: (value) {
            setState(() {
              _selectedFrequency = value!;
              // Store the frequency setting in LocalStorage
              LocalStorage().setString('notificationFrequency', value);
              widget.onChanged(_notificationOn, value);
            });
          },
        ),
      ],
    );
  }
}
