import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
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
          
          _buildSectionHeader(context, localization.settingsTitle), 
          _buildLanguageTile(context, localization),

          _buildSectionHeader(context, localization.settingsExportHeader),
          _buildExportTile(context, icon: Icons.download, title: localization.settingsExportAll, type: ExportType.all),
          _buildExportTile(context, icon: Icons.table_chart_outlined, title: localization.settingsExportValues, type: ExportType.valuesAndAverage),
          _buildExportTile(context, icon: Icons.show_chart, title: localization.settingsExportAverage, type: ExportType.averageOnly),

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
          fontSize: 12, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary, letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildLanguageTile(BuildContext context, AppLocalizations localization) {
    return ListenableBuilder(
      listenable: localStorage.settingsNotifier,
      builder: (context, _) {
        // If no locale is saved, show "System Default"
        final String currentLanguageName = localStorage.locale == null 
            ? localization.systemDefault 
            : _getLanguageName(localStorage.locale!.languageCode);
        
        return ListTile(
          leading: const Icon(Icons.language),
          title: Text(localization.settingsLanguage),
          subtitle: Text(currentLanguageName),
          onTap: () => _showLanguageDialog(context),
        );
      },
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'de': return 'Deutsch';
      case 'en': return 'English';
      case 'ko': return '한국어 (Korean)';
      case 'es': return 'Español';
      case 'pl': return 'Polski';
      case 'lt': return 'Lietuvių';
      case 'uk': return 'Українська';
      case 'ru': return 'Русский';
      default: return code;
    }
  }

  void _showLanguageDialog(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localization.chooseLanguage),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: AppLocalizations.supportedLocales.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return ListTile(
                    title: Text(localization.systemDefault),
                    selected: localStorage.locale == null,
                    onTap: () {
                      localStorage.setLocale(null);
                      Navigator.pop(context);
                    },
                  );
                }
                final locale = AppLocalizations.supportedLocales[index - 1];
                return ListTile(
                  title: Text(_getLanguageName(locale.languageCode)),
                  selected: localStorage.locale?.languageCode == locale.languageCode,
                  onTap: () {
                    localStorage.setLocale(locale);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildExportTile(BuildContext context, {required IconData icon, required String title, required ExportType type}) {
    final bool isEnabled = !kIsWeb;
    return Builder(
      builder: (innerContext) {
        return ListTile(
          leading: Icon(icon, color: isEnabled ? null : Theme.of(context).disabledColor),
          title: Text(title, style: TextStyle(color: isEnabled ? null : Theme.of(context).disabledColor)),
          subtitle: isEnabled ? null : const Text("Nur auf Mobilgeräten verfügbar", style: TextStyle(fontSize: 10)),
          onTap: isEnabled ? () => _handleExport(innerContext, type) : null,
        );
      }
    );
  }

  Widget _buildSecuritySwitch(BuildContext context, AppLocalizations localization) {
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
            final String reason = localization.unlock;
            if (value) {
              bool canAuth = await securityService.canAuthenticate();
              if (canAuth) {
                bool success = await securityService.authenticate(localizedReason: reason);
                if (success) securityService.setSecurityEnabled(true);
              }
            } else {
              bool success = await securityService.authenticate(localizedReason: reason);
              if (success) securityService.setSecurityEnabled(false);
            }
          },
        );
      },
    );
  }

  void _showAbout(BuildContext context) async {
    final localization = AppLocalizations.of(context)!;
    final packageInfo = await PackageInfo.fromPlatform();
    
    if (!context.mounted) return;

    showAboutDialog(
      context: context,
      applicationName: "Self-Examination",
      applicationVersion: "${packageInfo.version}+${packageInfo.buildNumber}",
      applicationIcon: ClipOval(
        child: Image.asset(
          "assets/icon/self_examination_light_blue.png",
          width: 48, height: 48, fit: BoxFit.cover,
        ),
      ),
      applicationLegalese: localization.aboutContent,
      children: [
        const SizedBox(height: 24),
        InkWell(
          onTap: () => _launchURL("https://github.com/Paradoxianer/self_examintion"),
          child: Row(
            children: [
              const Icon(Icons.code, size: 20, color: Colors.blue),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  localization.githubRepository,
                  style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showImprint(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localization.imprint),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(localization.imprintContent),
            const SizedBox(height: 12),
            InkWell(
              onTap: () => _launchURL("mailto:matthias.lindner@heilsarmee.de"),
              child: const Text(
                "matthias.lindner@heilsarmee.de",
                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _launchURL("https://github.com/Paradoxianer/self_examintion"),
              child: Text(
                localization.githubRepository,
                style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 13),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(localization.ok)),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
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

    // Identify the origin for iPad popover
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    final Rect? sharePositionOrigin = box != null 
        ? box.localToGlobal(Offset.zero) & box.size 
        : null;

    await exportService.exportData(context, history, type, sharePositionOrigin: sharePositionOrigin);
  }
}
