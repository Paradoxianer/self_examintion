import 'package:flutter/material.dart';
import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/utils/local_storage.dart';

class QuestionSetSelection extends StatelessWidget {
  final Function(String)? onSetSelected;
  final bool showDelete;

  const QuestionSetSelection(
      {super.key, this.onSetSelected, this.showDelete = false});

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

        final authorName = questionSets[selectedSet]?.authorName ?? selectedSet;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: PopupMenuButton<String>(
                  initialValue: selectedSet,
                  tooltip: localization.chooseQuestionSet,
                  onSelected: (String newValue) {
                    if (newValue != selectedSet) {
                      localStorage.setCurrentAuthor(newValue);
                      if (onSetSelected != null) onSetSelected!(newValue);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return questionSets.entries.map((entry) {
                      return PopupMenuItem<String>(
                        value: entry.key,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                entry.value.authorName,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.info_outline, size: 18),
                              onPressed: () {
                                Navigator.of(context).pop(); // Menü schließen
                                _showSetInfoDialog(context, entry.key, questionSets);
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            authorName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
              const VerticalDivider(width: 8, indent: 8, endIndent: 8),
              // INFO BUTTON (für das aktuell ausgewählte Set)
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.info_outline, size: 18),
                onPressed: () =>
                    _showSetInfoDialog(context, selectedSet, questionSets),
              ),
              // OPTIONAL DELETE BUTTON (Only in Settings)
              if (showDelete) ...[
                const SizedBox(width: 4),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.delete_outline,
                      size: 18, color: Colors.red),
                  onPressed: () =>
                      _confirmDeleteDialog(context, selectedSet, authorName),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _showSetInfoDialog(BuildContext context, String selectedKey,
      Map<String, SelfAssessmentQuestionSet> questionSets) {
    final questionSet = questionSets[selectedKey]!;
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.menu_book, color: colorScheme.primary),
              const SizedBox(width: 12),
              Expanded(
                  child: Text(questionSet.authorName,
                      style: const TextStyle(fontSize: 18))),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    questionSet.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 12),
                  ),
                ),
                const Divider(),
                const SizedBox(height: 8),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: questionSet.questions.length,
                    itemBuilder: (context, index) {
                      final color = globalColorMap[index + 1] ?? Colors.grey;
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        clipBehavior: Clip.antiAlias,
                        elevation: 0,
                        color: colorScheme.surfaceContainerLow,
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: 32,
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.5),
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(12)),
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  child: Text(
                                    questionSet.questions[index].text,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                child: const Text('OK')),
          ],
        );
      },
    );
  }

  void _confirmDeleteDialog(
      BuildContext context, String authorKey, String authorName) {
    final localization = AppLocalizations.of(context)!;
    final localStorage = LocalStorage();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localization.warningTitle),
          content: Text(localization.warningDel(authorName, authorName)),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(localization.cancel)),
            TextButton(
              onPressed: () {
                localStorage.clearAllAssesmentEntries();
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text(localization.ok),
            ),
          ],
        );
      },
    );
  }
}
