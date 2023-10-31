import 'package:flutter/material.dart';

//ToDo
/*
 return ExpansionTile(
          onExpansionChanged: _onExpansionChanged,
          // IgnorePointeer propogates touch down to tile
          trailing: IgnorePointer(
            child: Switch(
                value: isExpanded,
                onChanged: (_) {},
             ),
          ),
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(root.title),
          ]),
          children: root.children.map((entry) => EntryItem(entry)).toList(),
        );
 */

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
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Mich an meine Selbstprüfungsfragen regelmäßig erinnern"),
            Switch(
              value: widget.reminderEnabled,
              onChanged: (value) {
                setState(() {
                  if (value) {
                    _isExpanded = true;
                  }
                  widget.onChanged(value, widget.reminderFrequency ?? 'daily');
                });
              },
            ),
          ],
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: _isExpanded ? 100.0 : 0.0,
          child: Column(
            children: [
              RadioListTile(
                title: Text('Täglich'),
                value: 'daily',
                groupValue: widget.reminderFrequency,
                onChanged: (value) {
                  widget.onChanged(widget.reminderEnabled, value!);
                },
              ),
              RadioListTile(
                title: Text('Wöchentlich'),
                value: 'weekly',
                groupValue: widget.reminderFrequency,
                onChanged: (value) {
                  widget.onChanged(widget.reminderEnabled, value!);
                },
              ),
              RadioListTile(
                title: Text('Monatlich'),
                value: 'monthly',
                groupValue: widget.reminderFrequency,
                onChanged: (value) {
                  widget.onChanged(widget.reminderEnabled, value!);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}