import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/widgets/dsgvo_dialog.dart';
import 'package:self_examination/widgets/question_set_selection.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final LocalStorage localStorage = LocalStorage();
  final DSGVODialog _dsgvoDialog = DSGVODialog();

  bool reminderEnabled = false;
  String reminderFrequency = 'daily';

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  void loadSettings() {
    setState(() {
      reminderEnabled = localStorage.getBool('notificationsEnabled');
      reminderFrequency = localStorage.getString('notificationFrequency') ?? 'daily';
    });
  }

  void saveSettings() {
    localStorage.setBool('notificationsEnabled',reminderEnabled);
    localStorage.setString('notificationFrequency',reminderFrequency);
  }

  void clearAllAssesmentEntries(BuildContext context) async {
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
                Navigator.of(context).pop(); // User confirmed the delete
              },
              child: Text(AppLocalizations.of(context)!.ok),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // User canceled the delete
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsTitle),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Text(AppLocalizations.of(context)!.chooseQuestionSet), // Title des Fragensets
            title: QuestionSetSelection(
              onSetSelected: (selectedSet) {
                // Handle the selected set (e.g., update settings)
                print('Selected Set: $selectedSet');
              },
            ),
          ),
        ListTile(
          leading: Text(AppLocalizations.of(context)!.delete),
          title: IconButton(
              onPressed: (){clearAllAssesmentEntries(context);},
              icon: Icon(Icons.delete_forever,color: Colors.red,)
          )),
          ListTile(
            leading: Text(AppLocalizations.of(context)!.notification),
            title: Switch(
              value: reminderEnabled,
              onChanged: (value) {
                setState(() {
                  reminderEnabled = value;
                });
                saveSettings();
              },
            ),
          ),
          ListTile(
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
                setState(() {
                  reminderFrequency = newValue!;
                });
                saveSettings();
              },
            ),
          ),
          ListTile(
            leading: Text(AppLocalizations.of(context)!.datasecurityDialog),
            title: IconButton(
              icon: Icon(Icons.info),
              onPressed: (){_dsgvoDialog.showDSGVODialog(context);},
            ),
          ),
          // Weitere Einstellungen
        ],
      ),
    );
  }
}
