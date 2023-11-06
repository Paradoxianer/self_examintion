import 'package:flutter/material.dart';
import 'package:self_examintion/data/self_assesment_questions.dart';
import 'package:self_examintion/models/assessment_entry.dart';
import 'package:self_examintion/screens/chart_screen.dart';
import 'package:self_examintion/screens/settings_screen.dart';
import 'package:self_examintion/utils/local_storage.dart';
import 'package:self_examintion/widgets/question_card.dart';


class AssessmentScreen extends StatefulWidget {
  final LocalStorage localStorage;

  AssessmentScreen({required this.localStorage});

  @override
  _AssessmentScreenState createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  List<QuestionCard> questionCards = [];
  SelfAssessmentQuestionSet questionSet=SelfAssessmentQuestions.questionMap.values.first;


  bool allQuestionsAnswered = false;

  @override
  void initState() {
    super.initState();
    questionSet = SelfAssessmentQuestions.questionMap[widget.localStorage.getCurrentAuthor()]?? SelfAssessmentQuestions.questionMap.values.first;
    for(var i = 0; i < questionSet.questions.length; i++){
      questionCards.add(QuestionCard(cardNumber: i+1,question: questionSet.questions[i]));
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
        actions: [
          IconButton(
              onPressed:  () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ),
                );
              },
              icon:  Icon(
                Icons.settings))
        ],
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
                    builder: (context) => ChartScreen(),
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
            child: Text('Fertig'),
          )
        ],
      ),
    );
  }


  Future<void> saveAssessmentResults() async {
    AssessmentEntry assessmentEntry = AssessmentEntry(
      timestamp: DateTime.now(),
      questionSet: questionSet,
      answers: questionCards.asMap().entries.map((entry) => entry.value.question.answer).toList()

      /*Map.fromEntries(
        questionCards.asMap().entries.map(
              (entry) => MapEntry(entry.key, entry.value.question.answer),
        ),
      ),*/
    );
    await widget.localStorage.saveAssessmentEntry(assessmentEntry);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Daten gespeichert.'),
      ),
    );
  }
}