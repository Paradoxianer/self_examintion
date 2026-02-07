import 'package:flutter/material.dart';
import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/screens/chart_screen.dart';
import 'package:self_examination/screens/settings_screen.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/widgets/question_card.dart';
import 'package:self_examination/widgets/question_set_selection.dart';

class AssessmentScreen extends StatefulWidget {
  final LocalStorage localStorage;

  AssessmentScreen({required this.localStorage});

  @override
  _AssessmentScreenState createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.localStorage.assessmentNotifier,
      builder: (context, _) {
        final localization = AppLocalizations.of(context)!;
        final questionSet =
            localization.questionMap[widget.localStorage.getCurrentAuthor()] ??
                localization.questionMap.values.first;

        return Scaffold(
          appBar: AppBar(
            title: QuestionSetSelection(),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
              ),
            ],
          ),
          body: ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: questionSet.questions.length,
            itemBuilder: (context, index) {
              return QuestionCard(
                key: ValueKey(questionSet.questions[index].id),
                cardNumber: index + 1,
                question: questionSet.questions[index],
                onSliderChanged: (double value) {
                  questionSet.questions[index].value = value;
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _validateAndSave(context, questionSet),
            label: Text(localization.commit),
            icon: const Icon(Icons.check),
          ),
        );
      },
    );
  }

  void _validateAndSave(
      BuildContext context, SelfAssessmentQuestionSet questionSet) async {
    final localization = AppLocalizations.of(context)!;
    bool hasUnanswered = questionSet.questions.any((q) => q.value == -1.0);

    if (hasUnanswered) {
      bool? proceed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(localization.warningTitle),
          content: Text(localization.pleasAnswer),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(localization.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(localization.ok),
            ),
          ],
        ),
      );

      if (proceed != true) return;
    }

    // Unbeantwortete Fragen auf 0.0 setzen vor dem Speichern
    for (var q in questionSet.questions) {
      if (q.value == -1.0) q.value = 0.0;
    }

    await saveAssessmentResults(questionSet);
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ChartScreen()),
      );
    }
  }

  Future<void> saveAssessmentResults(
      SelfAssessmentQuestionSet questionSet) async {
    AssessmentEntry assessmentEntry = AssessmentEntry(
        timestamp: DateTime.now(),
        questionSet: widget.localStorage.getCurrentAuthor(),
        values: questionSet.questions.map((q) => q.value).toList(),
        questionNotes: questionSet.questions.map((q) => q.note).toList(),
        note: null);
    await widget.localStorage.saveAssessmentEntry(assessmentEntry);
  }
}
