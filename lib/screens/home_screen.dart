import 'package:flutter/material.dart';
import 'package:self_examintion/data/self_assesment_questions.dart';
import 'package:self_examintion/screens/assessment_screen.dart';
import 'package:self_examintion/screens/settings_screen.dart';
import 'package:self_examintion/utils/local_storage.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Willkommen zum Selbstbewertungs-Tool',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AssessmentScreen(
                      localStorage: LocalStorage(),
                      questionSet: SelfAssessmentQuestions.questionSets.first,
                    ),
                  ),
                );
              },
              child: Text('Starten'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ),
                );
              },
              child: Text('Einstellungen'),
            ),
          ],
        ),
      ),
    );
  }
}
