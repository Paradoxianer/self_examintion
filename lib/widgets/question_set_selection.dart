import 'package:flutter/material.dart';
import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/utils/local_storage.dart';

class QuestionSetSelection extends StatelessWidget {
  final Function(String)? onSetSelected;

  QuestionSetSelection({this.onSetSelected});

  @override
  Widget build(BuildContext context) {
    final localStorage = LocalStorage();
    final questionSets = AppLocalizations.of(context)!.questionMap;

    return ListenableBuilder(
      listenable: localStorage.assessmentNotifier,
      builder: (context, _) {
        String selectedSet = localStorage.getCurrentAuthor();

        // Ensure selectedSet is valid
        if (!questionSets.containsKey(selectedSet)) {
          selectedSet = questionSets.keys.first;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            localStorage.setCurrentAuthor(selectedSet);
          });
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
              value: selectedSet,
              underline: Container(),
              items: questionSets.entries.map((entry) {
                return DropdownMenuItem<String>(
                  value: entry.key,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.menu_book,
                        color: entry.key == selectedSet
                            ? Theme.of(context).primaryColor
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        entry.value.authorName,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null && newValue != selectedSet) {
                  localStorage.setCurrentAuthor(newValue);
                  if (onSetSelected != null) onSetSelected!(newValue);
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () => _showSetInfoDialog(context, selectedSet, questionSets),
            ),
          ],
        );
      },
    );
  }

  void _showSetInfoDialog(BuildContext context, String selectedKey, Map<String, SelfAssessmentQuestionSet> questionSets) {
    final questionSet = questionSets[selectedKey]!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(questionSet.authorName),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: questionSet.questions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text("${index + 1}"),
                  title: Text(questionSet.questions[index].text),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Schließen'),
            ),
          ],
        );
      },
    );
  }
}
