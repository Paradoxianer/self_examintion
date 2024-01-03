import 'package:flutter/material.dart';
import 'package:self_examintion/localizations/app_localizations.dart';
import 'package:self_examintion/utils/globals.dart';
import 'package:self_examintion/utils/local_storage.dart';
import 'package:self_examintion/widgets/dsgvo_dialog.dart';
import 'package:self_examintion/widgets/question_set_selection.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';


class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final LocalStorage localStorage = LocalStorage();
  final DSGVODialog _dsgvoDialog = DSGVODialog();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();

  bool reminderEnabled = false;
  String reminderFrequency = 'daily';

  @override
  void initState() {
    super.initState();
    loadSettings();
    initializeNotifications(); // Initialize notifications
  }


  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(id: id, title: title, body: body, payload: payload));
      },
    );
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
      },
    );
  }


  void loadSettings() {
    setState(() {
      reminderEnabled = localStorage.getBool('notificationsEnabled');
      reminderFrequency = localStorage.getString('notificationFrequency') ?? 'daily';
    });
  }

  void saveSettings() {
    localStorage.setBool('notificationsEnabled', reminderEnabled);
    localStorage.setString('notificationFrequency', reminderFrequency);

    if (reminderEnabled) {
      // Cancel any previously scheduled notifications
      flutterLocalNotificationsPlugin.cancelAll();
      RepeatInterval interval = RepeatInterval.daily; // Adjust the time and day as needed
      switch (reminderFrequency) {
        case "daily":
          break;
        case "weekly":
          interval = RepeatInterval.weekly;
          break;
        case "monthly":
        //todo somehow support this also there exist no RepeatInterval vor this..
          break;
        case "annual":
        //todo somehow support this also there exist no RepeatInterval vor this..
          break;
      }

      final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'selfexaminaton_notification','regular_reminder',
      );
      final NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
      );
      flutterLocalNotificationsPlugin.periodicallyShow(0, AppLocalizations.of(context)!.reminderTitle, AppLocalizations.of(context)!.reminderBody,interval,notificationDetails);
      // Add more cases for monthly and annual reminders as needed
    }
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
              //todo somehow localize this one
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
