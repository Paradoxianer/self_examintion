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
            title: const QuestionSetSelection(showDelete: true),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Wähle ein Set zum Bearbeiten oder Löschen der Daten.",
                style: TextStyle(
                    fontSize: 12, color: Theme.of(context).colorScheme.outline),
              ),
            ),
          ),
          _buildSectionHeader(context, "Daten-Export"),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text("Alles exportieren"),
            onTap: () => _handleExport(context, ExportType.all),
          ),
          ListTile(
            leading: const Icon(Icons.table_chart_outlined),
            title: const Text("Werte & Durchschnitt"),
            onTap: () => _handleExport(context, ExportType.valuesAndAverage),
          ),
          _buildSectionHeader(context, "Sicherheit & Datenschutz"),
          ListenableBuilder(
            listenable: localStorage.settingsNotifier,
            builder: (context, _) {
              return SwitchListTile(
                secondary: const Icon(Icons.lock_outline),
                title: const Text("App-Sperre aktivieren"),
                value: securityService.isSecurityEnabled(),
                onChanged: (bool value) async {
                  if (value) {
                    bool canAuth = await securityService.canAuthenticate();
                    if (canAuth) {
                      bool success = await securityService.authenticate();
                      if (success) securityService.setSecurityEnabled(true);
                    }
                  } else {
                    bool success = await securityService.authenticate();
                    if (success) securityService.setSecurityEnabled(false);
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
          _buildSectionHeader(context, localization.notificationFrequency),
          ListenableBuilder(
            listenable: localStorage.settingsNotifier,
            builder: (context, _) {
              String reminderFrequency =
                  localStorage.getString('notificationFrequency') ?? 'daily';
              return ListTile(
                leading: const Icon(Icons.notifications_none),
                title: Text(localization.notificationFrequency),
                trailing: DropdownButton<String>(
                  value: reminderFrequency,
                  underline: const SizedBox(),
                  items: examineFrequenze.map((String frequency) {
                    return DropdownMenuItem<String>(
                      value: frequency,
                      child: Text(localization
                          .frequenze[examineFrequenze.indexOf(frequency)]),
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Keine Daten zum Exportieren vorhanden.")));
      return;
    }
    await exportService.exportData(context, history, type);
  }
}
