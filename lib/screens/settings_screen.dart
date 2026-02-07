import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/utils/security_service.dart';
import 'package:self_examination/utils/export_service.dart';
import 'package:self_examination/widgets/dsgvo_dialog.dart';
import 'package:self_examination/widgets/question_set_selection.dart';

class SettingsScreen extends StatelessWidget {
  final LocalStorage localStorage = LocalStorage();
  final SecurityService securityService = SecurityService();
  final ExportService exportService = ExportService();
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
          _buildSectionHeader(context, localization.chooseQuestionSet),
          ListTile(
            title: QuestionSetSelection(),
          ),
          
          _buildSectionHeader(context, "Daten-Export"), // TODO: Localize
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text("Alles exportieren"), // TODO: Localize
            subtitle: const Text("Werte, Notizen und Durchschnitt"), // TODO: Localize
            onTap: () => _handleExport(context, ExportType.all),
          ),
          ListTile(
            leading: const Icon(Icons.table_chart_outlined),
            title: const Text("Werte & Durchschnitt"), // TODO: Localize
            onTap: () => _handleExport(context, ExportType.valuesAndAverage),
          ),
          ListTile(
            leading: const Icon(Icons.show_chart),
            title: const Text("Nur Durchschnitt"), // TODO: Localize
            onTap: () => _handleExport(context, ExportType.averageOnly),
          ),

          _buildSectionHeader(context, "Sicherheit & Datenschutz"), // TODO: Localize
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
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(localization.datasecurityDialog),
            onTap: () => _dsgvoDialog.showDSGVODialog(context),
          ),

          _buildSectionHeader(context, "Erinnerung"), // TODO: Localize
          ListenableBuilder(
            listenable: localStorage.settingsNotifier,
            builder: (context, _) {
              String reminderFrequency = localStorage.getString('notificationFrequency') ?? 'daily';
              return ListTile(
                leading: const Icon(Icons.notifications_none),
                title: Text(localization.notificationFrequency),
                trailing: DropdownButton<String>(
                  value: reminderFrequency,
                  underline: const SizedBox(),
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

          _buildSectionHeader(context, "Gefahrenzone"), // TODO: Localize
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: Text(localization.delete, style: const TextStyle(color: Colors.red)),
            onTap: () => _confirmDeleteDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  void _handleExport(BuildContext context, ExportType type) async {
    final history = await localStorage.loadAssessmentEntries();
    if (history.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Keine Daten zum Exportieren vorhanden."))
      );
      return;
    }
    await exportService.exportData(context, history, type);
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
              onPressed: () => Navigator.of(context).pop(),
              child: Text(localization.cancel),
            ),
            TextButton(
              onPressed: () {
                localStorage.clearAllAssesmentEntries();
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text(localization.ok),
            ),
          ],
        );
      },
    );
  }
}
