import 'package:flutter/material.dart';
import 'package:self_examintion/data/self_assesment_questions.dart';
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

  @override
  void initState() {
    super.initState();
    selectedSet = LocalStorage().getCurrentAuthor();
    if (selectedSet == null || SelfAssessmentQuestions.questionMap[selectedSet]== null || selectedSet =="none"){
      //just set it to the first set as default
      selectedSet=questionSets[0];
      // and save it :)
      LocalStorage().setCurrentAuthor(selectedSet!);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Select Question Set: "),
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
      ],
    );
  }
}
