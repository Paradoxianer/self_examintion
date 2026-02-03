import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/widgets/dsgvo_dialog.dart';
import 'package:self_examination/widgets/question_set_selection.dart';

class SettingsScreen extends StatelessWidget {
  final LocalStorage localStorage = LocalStorage();
  final DSGVODialog _dsgvoDialog = DSGVODialog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsTitle),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Text(AppLocalizations.of(context)!.chooseQuestionSet),
            title: QuestionSetSelection(), // Listens to assessmentNotifier internally
          ),
          ListTile(
              leading: Text(AppLocalizations.of(context)!.delete),
              title: IconButton(
                  onPressed: () => _confirmDeleteDialog(context),
                  icon: Icon(Icons.delete_forever, color: Colors.red,)
              )),
          ListenableBuilder(
            listenable: localStorage.settingsNotifier,
            builder: (context, _) {
              String reminderFrequency = localStorage.getString('notificationFrequency') ?? 'daily';
              return ListTile(
                leading: Text(AppLocalizations.of(context)!.notificationFrequency),
                title: DropdownButton<String>(
                  value: reminderFrequency,
                  items: examineFrequenze.map((String frequency) {
                    return DropdownMenuItem<String>(
                      value: frequency,
                      child: Text(AppLocalizations.of(context)!.frequenze[examineFrequenze.indexOf(frequency)]),
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
            leading: Text(AppLocalizations.of(context)!.datasecurityDialog),
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
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.warningTitle),
          content: Text(AppLocalizations.of(context)!.warningDel(localStorage.getCurrentAuthor(),localStorage.getCurrentAuthor())),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                localStorage.clearAllAssesmentEntries();
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.ok),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
          ],
        );
      },
    );
  }
}
