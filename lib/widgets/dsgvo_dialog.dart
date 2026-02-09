import 'dart:io';
import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/utils/local_storage.dart';

/// A dialog that provides detailed privacy information and handles GDPR consent.
class DSGVODialog extends StatefulWidget {
  
  /// Utility method to show the GDPR dialog.
  void showDSGVODialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // User must interact with the dialog
      builder: (BuildContext context) {
        return this;
      },
    );
  }

  @override
  _DSGVODialogState createState() => _DSGVODialogState();
}

class _DSGVODialogState extends State<DSGVODialog> {
  final LocalStorage localStorage = LocalStorage();
  bool agreedToDSGVO = false;

  @override
  void initState() {
    super.initState();
    agreedToDSGVO = localStorage.getBool('agreedToDSGVO');
  }

  void saveAgreement(bool value) {
    setState(() {
      agreedToDSGVO = value;
    });
    localStorage.setBool('agreedToDSGVO', value);
  }

  /// Shows a confirmation dialog if the user tries to decline.
  void showDisagreeDialog(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localization.dsgvoNo),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(localization.dsgvoNoInfo),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context), // Back to main GDPR dialog
                    child: Text(localization.cancel),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => exit(0), // Exit the app
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                    child: const Text("App beenden"), // Fallback or add to localization
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.security, color: colorScheme.primary),
              const SizedBox(width: 12),
              Expanded(child: Text(localization.dsgvoTitle)),
            ],
          ),
          if (agreedToDSGVO)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle, size: 14, color: Colors.green),
                    const SizedBox(width: 6),
                    Text(
                      localization.dsgvoYes,
                      style: const TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildPrivacyPoint(Icons.cloud_off, localization.dsgvo1, colorScheme),
              const SizedBox(height: 16),
              _buildPrivacyPoint(Icons.phonelink_lock, localization.dsgvo2, colorScheme),
              const SizedBox(height: 16),
              _buildPrivacyPoint(Icons.check_circle_outline, localization.dsgvo3, colorScheme),
              const SizedBox(height: 24),
              if (!agreedToDSGVO)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => showDisagreeDialog(context),
                        child: Text(localization.dsgvoCancel),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                        ),
                        onPressed: () {
                          saveAgreement(true);
                          Navigator.of(context).pop(true);
                        },
                        child: Text(localization.dsgvoOK),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        if (agreedToDSGVO)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => saveAgreement(false), // Revoke consent
                child: Text(
                  localization.dsgvoCancel,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(localization.close),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildPrivacyPoint(IconData icon, String text, ColorScheme colorScheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: colorScheme.secondary),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13, height: 1.4),
          ),
        ),
      ],
    );
  }
}
