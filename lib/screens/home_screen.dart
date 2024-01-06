import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/screens/assessment_screen.dart';
import 'package:self_examination/screens/chart_screen.dart';
import 'package:self_examination/screens/settings_screen.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/widgets/dsgvo_dialog.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    bool agreedToDSGVO = LocalStorage().getBool('agreedToDSGVO');
    if (agreedToDSGVO == false)
      Future.delayed(Duration.zero, () => DSGVODialog().showDSGVODialog(context));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.greetings,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AssessmentScreen(
                      localStorage: LocalStorage()
                    ),
                  ),
                );
              },
              child: Text(AppLocalizations.of(context)!.start),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChartScreen(),
                  ),
                );
              },
              child: Text(AppLocalizations.of(context)!.results),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ),
                );
              },
              child: Text(AppLocalizations.of(context)!.settings),
            ),
          ],
        ),
      ),
    );
  }
}
