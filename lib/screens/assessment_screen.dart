import 'package:flutter/material.dart';
import 'package:self_examintion/data/self_assesment_questions.dart';
import 'package:self_examintion/localizations/app_localizations.dart';
import 'package:self_examintion/models/assessment_entry.dart';
import 'package:self_examintion/screens/chart_screen.dart';
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
  final noteController = TextEditingController();
  SelfAssessmentQuestionSet? questionSet = null;
  bool allQuestionsAnswered = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    noteController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.localStorage.addAssessmentDataChangedCallback(questionsetChanged);
  }

  questionsetChanged(){
    questionCards.clear();
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



  loadQuestionSet(BuildContext context){
    questionSet = AppLocalizations.of(context)!.questionMap[
    widget.localStorage.getCurrentAuthor()] ??
        AppLocalizations.of(context)!.questionMap.values.first;
    if (questionSet!=null) {
      for (var i = 0; i < questionSet!.questions.length; i++) {
        questionCards.add(QuestionCard(
            cardNumber: i + 1,
            question: questionSet!.questions[i],
            // Pass the slider values to the QuestionCard
            onSliderChanged: (double value) {
              setState(() {
                questionSet!.questions[i].answer = value.toInt();
                // Update the Question object
              });
            }));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if  (questionCards.isEmpty)  loadQuestionSet(context);
    return Scaffold(
      appBar: AppBar(
        title:
            Text("${AppLocalizations.of(context)!.examinTitle} - ${widget.localStorage.getCurrentAuthor()}", overflow: TextOverflow.ellipsis),
     /*   actions: [
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
        ],*/
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
                hintText: AppLocalizations.of(context)!.noteHint,
              ),
              controller: noteController,
            ),
          ),
          TextButton(
            onPressed: () async {
              if (areAllQuestionsAnswered()) {
                await saveAssessmentResults(); // Speichere die Ergebnisse
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ChartScreen(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.pleasAnswer),
                  ),
                );
              }
            },
            child: Text(AppLocalizations.of(context)!.commit),
          )
        ],
      ),
    );
  }


  Future<void> saveAssessmentResults() async {
    AssessmentEntry assessmentEntry = AssessmentEntry(
      timestamp: DateTime.now(),
      questionSet: questionSet!.authorName,
      answers: questionCards.asMap().entries.map((entry) => entry.value.question.answer).toList(),
      note: noteController.text.length>1 ?  noteController.text : null
    );
      await widget.localStorage.saveAssessmentEntry(assessmentEntry);
      print("Data saved");
  }
}