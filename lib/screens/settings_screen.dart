import 'package:flutter/material.dart';
import 'package:self_examintion/utils/local_storage.dart';
import 'package:self_examintion/widgets/notification_settings.dart';
import 'package:self_examintion/widgets/question_set_selection.dart';

class SettingsScreen extends StatelessWidget {
  final LocalStorage localeStorage = LocalStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Einstellungen'),
      ),
      body: ListView(
        children: [
          QuestionSetSelection(
            onSetSelected: (selectedSet) {
              // Handle the selected set (e.g., update settings)
              print('Selected Set: $selectedSet');
            },
          ),
          NotificationsSettings(
            reminderEnabled: false,
            reminderFrequency: 'daily',
            onChanged: (bool, String) {},
          )
          // Weitere Einstellungen
        ],
      ),
    );
  }
}
