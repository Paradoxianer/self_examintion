import 'package:flutter/material.dart';
import 'package:self_examintion/data/self_assesment_questions.dart';
import 'package:self_examintion/localizations/app_localizations.dart';
import 'package:self_examintion/utils/local_storage.dart';

class QuestionSetSelection extends StatefulWidget {
  final Function(String) onSetSelected;

  QuestionSetSelection({required this.onSetSelected});

  @override
  _QuestionSetSelectionState createState() => _QuestionSetSelectionState();
}

class _QuestionSetSelectionState extends State<QuestionSetSelection> {
  String? selectedSet;
  List<String> questionSets = SelfAssessmentQuestions.questionMap.keys.toList();
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    //this will not work since we should only use the localized Applocalizations map
    selectedSet = LocalStorage().getCurrentAuthor();
  }

  void showSetInfoDialog(BuildContext context) {
    questionSets =AppLocalizations.of(context)!.questionMap.keys.toList();
    showDialog(
      context: context,
      builder: (context) {
        SelfAssessmentQuestionSet questionSet =
        AppLocalizations.of(context)!.questionMap[selectedSet]!;
        return AlertDialog(
          title: ListTile(
              title: Text(questionSet.authorName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text(questionSet.description)),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: questionSet.questions.length,
              itemBuilder: (context, index) {
                final question = questionSet.questions[index];
                return ListTile(
                  leading: Text((index + 1).toString()),
                  title: Text(question.text),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    questionSets =AppLocalizations.of(context)!.questionMap.keys.toList();
    return Row(
      children: [
        DropdownButton<String>(
          value: selectedSet,
          items: questionSets.map((String authorName) {
            return DropdownMenuItem<String>(
              value: authorName,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.menu_book,
                    color: authorName == selectedSet
                        ? Theme.of(context).primaryColor
                        : null,
                  ),
                  SizedBox(width: 8),
                  Text(authorName),
                ],
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            print("geändert zu $newValue\n");
            if (newValue != selectedSet) {
              setState(() {
                selectedSet = newValue;
              });
              // Update the selected author in LocalStorage
              LocalStorage().setCurrentAuthor(selectedSet!);
              widget.onSetSelected(selectedSet!);
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.info),
          onPressed: () {
            showSetInfoDialog(context);
          },
        ),
      ],
    );
  }
}
