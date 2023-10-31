import 'package:flutter/material.dart';
import 'package:self_examintion/data/self_assesment_questions.dart';
import 'package:self_examintion/models/assessment_entry.dart';
import 'package:self_examintion/models/question.dart';
import 'package:self_examintion/screens/chart_screen.dart';
import 'package:self_examintion/utils/local_storage.dart';
import 'package:self_examintion/widgets/question_card.dart';


class AssessmentScreen extends StatefulWidget {
  final SelfAssessmentQuestionSet questionSet;
  final LocalStorage localStorage;

  AssessmentScreen({required this.localStorage,required this.questionSet});

  @override
  _AssessmentScreenState createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  List<QuestionCard> questionCards = [];
  List<AssessmentEntry> assessmentHistory = [];

  bool allQuestionsAnswered = false;

  @override
  void initState() {
    super.initState();
    for (Question question in widget.questionSet.questions) {
      questionCards.add(QuestionCard(question: question));
    }
  }

  // Check if all questions are answered
  bool areAllQuestionsAnswered() {
    for (QuestionCard card in questionCards) {
      if (card.question.answer == 0) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Self-Assessment'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: questionCards,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Add notes...',
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (areAllQuestionsAnswered()) {
                await saveAssessmentResults(); // Speichere die Ergebnisse
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChartScreen( assessmentHistory:assessmentHistory ),

                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Bitte beantworten Sie alle Fragen.'),
                  ),
                );
              }
            },
            child: Text('Commit'),
          )
        ],
      ),
    );
  }


  Future<void> saveAssessmentResults() async {
    AssessmentEntry assessmentEntry = AssessmentEntry(
      timestamp: DateTime.now(),
      questionSet: widget.questionSet,
      answers: Map.fromEntries(
        questionCards.asMap().entries.map(
              (entry) => MapEntry(entry.key, entry.value.question.answer),
        ),
      ),
    );
    await widget.localStorage.saveAssessmentEntry(assessmentEntry);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Daten gespeichert.'),
      ),
    );
  }
}