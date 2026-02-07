import 'package:flutter/material.dart';
import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/utils/local_storage.dart';

class QuestionSetSelection extends StatelessWidget {
  final Function(String)? onSetSelected;

  const QuestionSetSelection({super.key, this.onSetSelected});

  @override
  Widget build(BuildContext context) {
    final localStorage = LocalStorage();
    final localization = AppLocalizations.of(context)!;
    final questionSets = localization.questionMap;

    return ListenableBuilder(
      listenable: localStorage.assessmentNotifier,
      builder: (context, _) {
        String selectedSet = localStorage.getCurrentAuthor();

        if (!questionSets.containsKey(selectedSet)) {
          selectedSet = questionSets.keys.first;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            localStorage.setCurrentAuthor(selectedSet);
          });
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Constrain the width to prevent AppBar overflow
              Flexible(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedSet,
                      isDense: true,
                      isExpanded: false, // Prevents taking infinite width
                      icon: const Icon(Icons.arrow_drop_down, size: 20),
                      items: questionSets.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(
                            entry.value.authorName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
                  ),
                ),
              ),
              const VerticalDivider(width: 8, indent: 8, endIndent: 8),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.info_outline, size: 18),
                onPressed: () => _showSetInfoDialog(context, selectedSet, questionSets),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSetInfoDialog(BuildContext context, String selectedKey, Map<String, SelfAssessmentQuestionSet> questionSets) {
    final questionSet = questionSets[selectedKey]!;
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.menu_book, color: colorScheme.primary),
              const SizedBox(width: 12),
              Expanded(child: Text(questionSet.authorName)),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    questionSet.description,
                    style: TextStyle(fontStyle: FontStyle.italic, color: colorScheme.onSurfaceVariant),
                  ),
                ),
                const Divider(),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: questionSet.questions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: 12,
                          backgroundColor: colorScheme.secondaryContainer,
                          child: Text("${index + 1}", style: TextStyle(fontSize: 10, color: colorScheme.onSecondaryContainer)),
                        ),
                        title: Text(
                          questionSet.questions[index].text,
                          style: const TextStyle(fontSize: 13),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
