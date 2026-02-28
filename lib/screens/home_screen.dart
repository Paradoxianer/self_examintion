import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/screens/assessment_screen.dart';
import 'package:self_examination/screens/chart_screen.dart';
import 'package:self_examination/screens/onboarding_screen.dart';
import 'package:self_examination/screens/settings_screen.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/widgets/dsgvo_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkFirstStart(context));
  }

  void _checkFirstStart(BuildContext context) async {
    final localStorage = LocalStorage();
    bool agreedToDSGVO = localStorage.getBool('agreedToDSGVO');
    bool onboardingCompleted = localStorage.getBool('onboardingCompleted');

    if (!agreedToDSGVO) {
      // 1. Show DSGVO Dialog
      bool? result = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => DSGVODialog(),
      );
      
      if (result == true && !onboardingCompleted) {
        // 2. Directly show Onboarding after DSGVO consent
        _showOnboarding(context);
      }
    } else if (!onboardingCompleted) {
      // Show Onboarding if DSGVO was already agreed but onboarding was skipped/not finished
      _showOnboarding(context);
    }
  }

  void _showOnboarding(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    builder: (context) =>
                        AssessmentScreen(localStorage: LocalStorage()),
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
