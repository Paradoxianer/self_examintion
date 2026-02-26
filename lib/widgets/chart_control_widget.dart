import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/utils/local_storage.dart';

/// Defines the available time intervals for chart filtering.
enum TimeRange { twoDays, week, month, year, all }

/// A unified control panel for all charts, providing question filtering,
/// time range selection, and a scrollable carousel of historical notes.
class ChartControlWidget extends StatelessWidget {
  final List<AssessmentEntry> assessmentHistory;
  final List<bool> selectedQuestions;
  final TimeRange currentTimeRange;
  final Function(int, bool) onQuestionToggle;
  final Function(bool) onToggleAll;
  final Function(TimeRange) onTimeRangeChange;
  final Function(bool next) onNavigateTime;
  final VoidCallback onTodayPressed;
  final bool showAverage;

  const ChartControlWidget({
    super.key,
    required this.assessmentHistory,
    required this.selectedQuestions,
    required this.currentTimeRange,
    required this.onQuestionToggle,
    required this.onToggleAll,
    required this.onTimeRangeChange,
    required this.onNavigateTime,
    required this.onTodayPressed,
    this.showAverage = false,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final authorKey = LocalStorage().getCurrentAuthor();
    final questionSet = localization.questionMap[authorKey];

    if (questionSet == null) return const SizedBox.shrink();

    final int questionCount = questionSet.questions.length;
    final int itemCount = showAverage ? questionCount + 1 : questionCount;

    return Column(
      children: [
        _buildTimeRangeSelector(context, localization),
        const Divider(height: 1),
        _buildSelectionControls(context, localization),
        const Divider(height: 1),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (showAverage && index == questionCount) {
                return _buildAverageCard(context, localization, index);
              }
              // Safety check to prevent index out of bounds during set transitions
              if (index >= questionCount) return const SizedBox.shrink();
              
              return _buildQuestionCard(context, index, questionSet.questions[index].text);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSelectionControls(BuildContext context, AppLocalizations localization) {
    // Determine the tristate value
    bool? tristateValue;
    if (selectedQuestions.isEmpty) {
      tristateValue = false;
    } else {
      final bool allSelected = selectedQuestions.every((q) => q);
      final bool noneSelected = selectedQuestions.every((q) => !q);
      
      if (allSelected) {
        tristateValue = true;
      } else if (noneSelected) {
        tristateValue = false;
      } else {
        tristateValue = null; // Indeterminate state
      }
    }

    final primaryColor = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          Container(
            width: 50,
            alignment: Alignment.center,
            child: Checkbox(
              value: tristateValue,
              tristate: true,
              activeColor: primaryColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (_) {
                // If currently all are selected, deselect all.
                // In all other cases (none or partial), select all.
                onToggleAll(tristateValue != true);
              },
            ),
          ),
          const SizedBox(width: 12),
          Text(
            localization.all,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: tristateValue == true ? primaryColor : Colors.grey[700],
            ),
          ),
          const Spacer(),
          Text(
            localization.filterQuestions,
            style: TextStyle(fontSize: 11, color: Colors.grey[600], fontStyle: FontStyle.italic),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context, int qIndex, String questionText) {
    final color = globalColorMap[qIndex + 1] ?? Colors.grey;
    final isSelected = qIndex < selectedQuestions.length ? selectedQuestions[qIndex] : false;

    final questionNotes = assessmentHistory
        .where((entry) =>
            qIndex < entry.questionNotes.length &&
            entry.questionNotes[qIndex] != null &&
            entry.questionNotes[qIndex]!.isNotEmpty)
        .map((entry) => {
              'date': entry.timestamp,
              'note': entry.questionNotes[qIndex]!,
            })
        .toList();

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      elevation: isSelected ? 2 : 0,
      color: isSelected ? null : Theme.of(context).disabledColor.withValues(alpha: 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                decoration: BoxDecoration(
                  color: isSelected ? color.withValues(alpha: 0.5) : Colors.grey.withValues(alpha: 0.2),
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      "${qIndex + 1}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Checkbox(
                      value: isSelected,
                      activeColor: color,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: (val) => onQuestionToggle(qIndex, val ?? false),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
                  child: Text(
                    questionText,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? null : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isSelected && questionNotes.isNotEmpty)
            _buildNotesCarousel(context, questionNotes, color, 62),
        ],
      ),
    );
  }

  Widget _buildAverageCard(BuildContext context, AppLocalizations localization, int avgIndex) {
    final bool isSelected = avgIndex < selectedQuestions.length ? selectedQuestions[avgIndex] : false;
    const color = Colors.red;

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      elevation: isSelected ? 2 : 0,
      color: isSelected ? color.withValues(alpha: 0.1) : Theme.of(context).disabledColor.withValues(alpha: 0.05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            decoration: BoxDecoration(
              color: isSelected ? color.withValues(alpha: 0.5) : Colors.grey.withValues(alpha: 0.2),
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    const Icon(Icons.functions, size: 20),
                    const SizedBox(height: 4),
                    Checkbox(
                      value: isSelected,
                      activeColor: color, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: (val) => onQuestionToggle(avgIndex, val ?? false),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    localization.total,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? color : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }

  Widget _buildTimeRangeSelector(BuildContext context, AppLocalizations localization) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.today, size: 20),
            onPressed: onTodayPressed,
            tooltip: localization.today,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_left, size: 20),
            onPressed: () => onNavigateTime(false),
          ),
          ...TimeRange.values.map((range) {
            final isSelected = range == currentTimeRange;
            return ChoiceChip(
              label: Text(localization.timeRangeShort[range.index], style: const TextStyle(fontSize: 10)),
              selected: isSelected,
              onSelected: (_) => onTimeRangeChange(range),
              visualDensity: VisualDensity.compact,
              selectedColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(color: isSelected ? Colors.white : null),
            );
          }),
          IconButton(
            icon: const Icon(Icons.chevron_right, size: 20),
            onPressed: () => onNavigateTime(true),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesCarousel(BuildContext context, List<Map<String, dynamic>> notes, Color color, double leftPadding) {
    return SizedBox(
      height: 75,
      child: ListView.builder(
        reverse: true, 
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(16, 0, leftPadding, 8),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final noteData = notes[notes.length - 1 - index];
          final DateTime date = noteData['date'];
          final String noteText = noteData['note'];

          return Container(
            width: 200,
            margin: const EdgeInsets.only(left: 8),
            child: Card(
              elevation: 0,
              color: color.withValues(alpha: 0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: color.withValues(alpha: 0.2)),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => _showNoteDetailDialog(context, date, noteText, color),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('dd.MM.yy').format(date),
                        style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: color),
                      ),
                      const SizedBox(height: 2),
                      Expanded(
                        child: Text(
                          noteText,
                          style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showNoteDetailDialog(BuildContext context, DateTime date, String note, Color color) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color.alphaBlend(
                color.withValues(alpha: 0.05),
                Theme.of(context).cardColor,
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd.MM.yy').format(date),
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: SingleChildScrollView(
                    child: Text(
                      note,
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
