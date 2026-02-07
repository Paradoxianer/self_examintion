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
  final noteController = TextEditingController();

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.localStorage.assessmentNotifier,
      builder: (context, _) {
        final localization = AppLocalizations.of(context)!;
        final questionSet = localization.questionMap[widget.localStorage.getCurrentAuthor()] ??
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
          body: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: questionSet.questions.length,
                  itemBuilder: (context, index) {
                    return QuestionCard(
                      key: ValueKey(questionSet.questions[index].hashCode),
                      cardNumber: index + 1,
                      question: questionSet.questions[index],
                      onSliderChanged: (double value) {
                        questionSet.questions[index].value = value;
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: localization.noteHint,
                  ),
                  controller: noteController,
                ),
              ),
              TextButton(
                onPressed: () async {
                  await saveAssessmentResults(questionSet);
                  if (mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ChartScreen()),
                    );
                  }
                },
                child: Text(localization.commit),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> saveAssessmentResults(SelfAssessmentQuestionSet questionSet) async {
    AssessmentEntry assessmentEntry = AssessmentEntry(
        timestamp: DateTime.now(),
        questionSet: widget.localStorage.getCurrentAuthor(),
        values: questionSet.questions.map((q) => q.value).toList(),
        questionNotes: questionSet.questions.map((q) => q.note).toList(),
        note: noteController.text.isNotEmpty ? noteController.text : null);
    await widget.localStorage.saveAssessmentEntry(assessmentEntry);
  }
}
