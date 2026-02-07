import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/utils/security_service.dart';
import 'package:self_examination/widgets/dsgvo_dialog.dart';
import 'package:self_examination/widgets/question_set_selection.dart';

class SettingsScreen extends StatelessWidget {
  final LocalStorage localStorage = LocalStorage();
  final SecurityService securityService = SecurityService();
  final DSGVODialog _dsgvoDialog = DSGVODialog();

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.settingsTitle),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Text(localization.chooseQuestionSet),
            title: QuestionSetSelection(),
          ),
          ListTile(
              leading: Text(localization.delete),
              title: IconButton(
                  onPressed: () => _confirmDeleteDialog(context),
                  icon: const Icon(Icons.delete_forever, color: Colors.red,)
              )),
          
          // SECURITY SETTING
          ListenableBuilder(
            listenable: localStorage.settingsNotifier,
            builder: (context, _) {
              return SwitchListTile(
                secondary: const Icon(Icons.lock_outline),
                title: const Text("App-Sperre aktivieren"), 
                subtitle: const Text("Schützt deine Daten mit PIN oder Biometrie"),
                value: securityService.isSecurityEnabled(),
                onChanged: (bool value) async {
                  if (value) {
                    bool canAuth = await securityService.canAuthenticate();
                    if (canAuth) {
                      bool success = await securityService.authenticate();
                      if (success) {
                        securityService.setSecurityEnabled(true);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Dein Gerät unterstützt keine Sicherheitssperre."))
                      );
                    }
                  } else {
                    bool success = await securityService.authenticate();
                    if (success) {
                      securityService.setSecurityEnabled(false);
                    }
                  }
                },
              );
            },
          ),

          ListenableBuilder(
            listenable: localStorage.settingsNotifier,
            builder: (context, _) {
              String reminderFrequency = localStorage.getString('notificationFrequency') ?? 'daily';
              return ListTile(
                leading: Text(localization.notificationFrequency),
                title: DropdownButton<String>(
                  value: reminderFrequency,
                  items: examineFrequenze.map((String frequency) {
                    return DropdownMenuItem<String>(
                      value: frequency,
                      child: Text(localization.frequenze[examineFrequenze.indexOf(frequency)]),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      localStorage.setString('notificationFrequency', newValue);
                    }
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Text(localization.datasecurityDialog),
            title: IconButton(
              icon: Icon(Icons.info),
              onPressed: () => _dsgvoDialog.showDSGVODialog(context),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteDialog(BuildContext context) async {
    final localization = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localization.warningTitle),
          content: Text(localization.warningDel(localStorage.getCurrentAuthor(), localStorage.getCurrentAuthor())),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                localStorage.clearAllAssesmentEntries();
                Navigator.of(context).pop();
              },
              child: Text(localization.ok),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(localization.cancel),
            ),
          ],
        );
      },
    );
  }
}
