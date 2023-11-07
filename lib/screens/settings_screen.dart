import 'package:flutter/material.dart';
import 'package:self_examintion/utils/local_storage.dart';
import 'package:self_examintion/widgets/dsgvo_dialog.dart';
import 'package:self_examintion/widgets/question_set_selection.dart';

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
          title: Text('Warnung'),
          content: Text('Alle gespeicherten Fortschritte für ${localStorage.getCurrentAuthor()} werden gelöscht und für immer verloren gehen. Möchten Sie fortfahren?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                localStorage.clearAllAssesmentEntries();
                Navigator.of(context).pop(); // User confirmed the delete
              },
              child: Text('Ja'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // User canceled the delete
              },
              child: Text('Nein'),
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
        title: Text('Einstellungen'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Text("Fragenset wählen"), // Title des Fragensets
            title: QuestionSetSelection(
              onSetSelected: (selectedSet) {
                // Handle the selected set (e.g., update settings)
                print('Selected Set: $selectedSet');
              },
            ),
          ),
        ListTile(
          leading: Text("Daten löschen"),
          title: IconButton(
              onPressed: (){clearAllAssesmentEntries(context);},
              icon: Icon(Icons.delete_forever,color: Colors.red,)
          )),
          ListTile(
            leading: Text("Enable Reminder"),
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
            leading: Text("Reminder Frequency"),
            title: DropdownButton<String>(
              value: reminderFrequency,
              items: ['daily', 'weekly', 'monthly'].map((String frequency) {
                return DropdownMenuItem<String>(
                  value: frequency,
                  child: Text(frequency),
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
            leading: Text("DSGVO Dialog"),
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
