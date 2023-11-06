import 'package:flutter/material.dart';
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
          title: Text('Zustimmung verweigert'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Die App kann leider nur funktionieren, wenn Sie zustimmen.'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Close the app when the user disagrees
                  // This can be achieved by calling exit(0) from the dart:io library
                  // Ensure you have 'dart:io' in your imports
                  // import 'dart:io';
                  // exit(0);
                },
                child: Text('Ok'),
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
      title: Text('Datenschutz und Zustimmung'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              'Um Ihre persönliche geistliche Entwicklung zu verfolgen, speichern wir Ihre Antworten auf die gestellten Fragen. Diese Daten werden anonymisiert und lokal auf Ihrem Gerät gespeichert.',
            ),
            SizedBox(height: 16),
            Text(
              'Bitte beachten Sie, dass Personen, die Zugriff auf Ihr Gerät und die App haben, möglicherweise auf diese Daten zugreifen können.',
            ),
            SizedBox(height: 16),
            Text(
              'Indem Sie unten auf "Zustimmen" klicken, erklären Sie sich damit einverstanden, dass Ihre Daten wie oben beschrieben gespeichert werden. Wenn Sie nicht zustimmen, werden keine Daten erfasst.',
            ),
            SizedBox(height: 16),
            if (!agreedToDSGVO)  // Show buttons only if not agreed
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      saveAgreement(true);
                      Navigator.of(context).pop();
                    },
                    child: Text('Zustimmen'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      showDisagreeDialog(context);
                    },
                    child: Text('Widersprechen'),
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
                'Zustimmung erteilt',
                style: TextStyle(color: Colors.green),
              ),
              TextButton(
                onPressed: () {
                  saveAgreement(false);
                },
                child: Text('Widersprechen'),
              ),
            ],
          ),
      ],
    );
  }
}
