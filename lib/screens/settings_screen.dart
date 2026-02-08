import 'package:flutter/foundation.dart';
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
                localization.settingsQuestionSetSubtitle,
                style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline),
              ),
            ),
          ),
          
          _buildSectionHeader(context, localization.settingsExportHeader),
          _buildExportTile(
            context, 
            icon: Icons.download, 
            title: localization.settingsExportAll, 
            type: ExportType.all
          ),
          _buildExportTile(
            context, 
            icon: Icons.table_chart_outlined, 
            title: localization.settingsExportValues, 
            type: ExportType.valuesAndAverage
          ),
          _buildExportTile(
            context, 
            icon: Icons.show_chart, 
            title: localization.settingsExportAverage, 
            type: ExportType.averageOnly
          ),

          _buildSectionHeader(context, localization.settingsSecurityHeader),
          _buildSecuritySwitch(context, localization),
          
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(localization.datasecurityDialog),
            onTap: () => _dsgvoDialog.showDSGVODialog(context),
          ),

          _buildSectionHeader(context, localization.about),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: Text(localization.about),
            onTap: () => _showAbout(context),
          ),
          ListTile(
            leading: const Icon(Icons.gavel_outlined),
            title: Text(localization.imprint),
            onTap: () => _showImprint(context),
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

  Widget _buildExportTile(BuildContext context, {required IconData icon, required String title, required ExportType type}) {
    // Feature-Guard for Web: Export is currently mobile-only due to file system sharing
    final bool isEnabled = !kIsWeb;
    
    return ListTile(
      leading: Icon(icon, color: isEnabled ? null : Theme.of(context).disabledColor),
      title: Text(title, style: TextStyle(color: isEnabled ? null : Theme.of(context).disabledColor)),
      subtitle: isEnabled ? null : const Text("Nur auf Mobilgeräten verfügbar", style: TextStyle(fontSize: 10)),
      onTap: isEnabled ? () => _handleExport(context, type) : null,
    );
  }

  Widget _buildSecuritySwitch(BuildContext context, AppLocalizations localization) {
    // Feature-Guard for Web: Local Auth is mobile-only
    if (kIsWeb) {
      return ListTile(
        leading: Icon(Icons.lock_outline, color: Theme.of(context).disabledColor),
        title: Text(localization.settingsSecurityLock, style: TextStyle(color: Theme.of(context).disabledColor)),
        subtitle: const Text("Biometrie nicht im Web verfügbar", style: TextStyle(fontSize: 10)),
      );
    }

    return ListenableBuilder(
      listenable: localStorage.settingsNotifier,
      builder: (context, _) {
        return SwitchListTile(
          secondary: const Icon(Icons.lock_outline),
          title: Text(localization.settingsSecurityLock), 
          value: securityService.isSecurityEnabled(),
          onChanged: (bool value) async {
            if (value) {
              bool canAuth = await securityService.canAuthenticate();
              if (canAuth) {
                bool success = await securityService.authenticate();
                if (success) securityService.setSecurityEnabled(true);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Sicherheitssperre auf diesem Gerät nicht möglich."))
                );
              }
            } else {
              bool success = await securityService.authenticate();
              if (success) securityService.setSecurityEnabled(false);
            }
          },
        );
      },
    );
  }

  void _showAbout(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    showAboutDialog(
      context: context,
      applicationName: "Self-Examination",
      applicationVersion: "1.0.0-beta.1",
      applicationIcon: ClipOval(
        child: Image.asset(
          "assets/icon/self_examination_light_blue.png",
          width: 48,
          height: 48,
          fit: BoxFit.cover,
        ),
      ),
      applicationLegalese: localization.aboutContent,
    );
  }

  void _showImprint(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localization.imprint),
        content: Text(localization.imprintContent),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(localization.ok)),
        ],
      ),
    );
  }

  void _handleExport(BuildContext context, ExportType type) async {
    final localization = AppLocalizations.of(context)!;
    final history = await localStorage.loadAssessmentEntries();
    if (history.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localization.settingsNoDataToExport))
      );
      return;
    }
    await exportService.exportData(context, history, type);
  }
}
