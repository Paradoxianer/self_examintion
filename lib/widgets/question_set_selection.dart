import 'package:flutter/material.dart';
import 'package:self_examination/data/self_assesment_questions.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/utils/local_storage.dart';

class QuestionSetSelection extends StatefulWidget {
  final Function(String)? onSetSelected;
  final bool showDelete;

  const QuestionSetSelection(
      {super.key, this.onSetSelected, this.showDelete = false});

  @override
  State<QuestionSetSelection> createState() => _QuestionSetSelectionState();
}

class _QuestionSetSelectionState extends State<QuestionSetSelection> {
  final MenuController _menuController = MenuController();

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
                child: MenuAnchor(
                  controller: _menuController,
                  alignmentOffset: const Offset(0, 10),
                  builder: (context, controller, child) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
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
                            Icon(
                              controller.isOpen 
                                  ? Icons.arrow_drop_up 
                                  : Icons.arrow_drop_down, 
                              size: 20
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  menuChildren: questionSets.entries.map((entry) {
                    final isSelected = entry.key == selectedSet;
                    return MenuItemButton(
                      // Das Haupt-Item schließt das Menü und wählt das Set aus
                      onPressed: () {
                        if (entry.key != selectedSet) {
                          localStorage.setCurrentAuthor(entry.key);
                          if (widget.onSetSelected != null) widget.onSetSelected!(entry.key);
                        }
                        _menuController.close();
                      },
                      requestFocusOnHover: false,
                      style: MenuItemButton.styleFrom(
                        backgroundColor: isSelected 
                            ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3)
                            : null,
                      ),
                      leadingIcon: isSelected 
                          ? Icon(Icons.check, size: 16, color: Theme.of(context).colorScheme.primary)
                          : const SizedBox(width: 16),
                      trailingIcon: IconButton(
                        icon: const Icon(Icons.info_outline, size: 18),
                        onPressed: () async {
                          // Dialog anzeigen, OHNE das Menü zu schließen
                          await _showSetInfoDialog(context, entry.key, questionSets);
                          // Nachdem der Dialog geschlossen wurde, stellen wir sicher,
                          // dass das Menü noch als offen wahrgenommen wird (falls nötig)
                          if (!_menuController.isOpen) {
                             _menuController.open();
                          }
                        },
                      ),
                      child: Text(
                        entry.value.authorName,
                        style: TextStyle(
                          fontSize: 14, 
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const VerticalDivider(width: 8, indent: 8, endIndent: 8),
              // Globaler INFO BUTTON für das aktuell gewählte Set
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.info_outline, size: 18),
                onPressed: () =>
                    _showSetInfoDialog(context, selectedSet, questionSets),
              ),
              if (widget.showDelete) ...[
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

  Future<void> _showSetInfoDialog(BuildContext context, String selectedKey,
      Map<String, SelfAssessmentQuestionSet> questionSets) async {
    final questionSet = questionSets[selectedKey]!;
    final colorScheme = Theme.of(context).colorScheme;

    await showDialog(
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
