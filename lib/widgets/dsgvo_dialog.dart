import 'dart:io';

import 'package:flutter/material.dart';
import 'package:self_examintion/localizations/app_localizations.dart';
import 'package:self_examintion/utils/local_storage.dart';

class DSGVODialog extends StatefulWidget {
  showDSGVODialog(BuildContext context) {
    showDialog(
      context: context,
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

  void showDisagreeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.dsgvoNo),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.dsgvoNoInfo),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Close the app when the user disagrees
                  // This can be achieved by calling exit(0) from the dart:io library
                  // Ensure you have 'dart:io' in your imports
                  // import 'dart:io';
                  exit(0);
                },
                child: Text(AppLocalizations.of(context)!.ok),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.dsgvoTitle),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.dsgvo1,
            ),
            SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.dsgvo2,
            ),
            SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.dsgvo3,
            ),
            SizedBox(height: 16),
            if (!agreedToDSGVO)  // Show buttons only if not agreed
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      saveAgreement(true);
                      Navigator.of(context).pop(true);
                    },
                    child: Text(AppLocalizations.of(context)!.dsgvoOK),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      showDisagreeDialog(context);
                    },
                    child: Text(AppLocalizations.of(context)!.dsgvoCancel),
                  ),
                ],
              ),
          ],
        ),
      ),
      actions: <Widget>[
        if (agreedToDSGVO)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.dsgvoYes,
                style: TextStyle(color: Colors.green),
              ),
              TextButton(
                onPressed: () {
                  saveAgreement(false);
                },
                child: Text(AppLocalizations.of(context)!.dsgvoCancel),
              ),
            ],
          ),
      ],
    );
  }
}
