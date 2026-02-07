import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:self_examination/utils/globals.dart';
import 'package:self_examination/utils/local_storage.dart';

enum TimeRange { twoDays, week, month, year, all }

class ChartControlWidget extends StatelessWidget {
  final List<AssessmentEntry> assessmentHistory;
  final List<bool> selectedQuestions;
  final TimeRange currentTimeRange;
  final Function(int, bool) onQuestionToggle;
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
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (showAverage && index == questionCount) {
                return _buildAverageCard(context, localization);
              }
              return _buildQuestionCard(context, index, questionSet.questions[index].text);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(BuildContext context, int qIndex, String questionText) {
    final color = globalColorMap[qIndex + 1] ?? Colors.grey;
    final isSelected = selectedQuestions[qIndex];

    final questionNotes = assessmentHistory
        .where((entry) =>
            qIndex < entry.questionNotes.length &&
            entry.questionNotes[qIndex] != null &&
            entry.questionNotes[qIndex]!.isNotEmpty)
        .map((entry) => {
              'date': entry.timestamp,
              'note': entry.questionNotes[qIndex]!,
            })
        .toList()
        .reversed
        .toList();

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      elevation: isSelected ? 2 : 0,
      color: isSelected ? null : Theme.of(context).disabledColor.withValues(alpha: 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // GESTALTETER LEADING-BEREICH (Zahl + Checkbox)
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: isSelected ? color.withValues(alpha: 0.5) : Colors.grey.withValues(alpha: 0.2),
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        "${qIndex + 1}",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Checkbox(
                        value: isSelected,
                        activeColor: color,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (val) => onQuestionToggle(qIndex, val ?? false),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // FRAGENTEXT
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
          ),
          if (isSelected && questionNotes.isNotEmpty)
            _buildNotesCarousel(context, questionNotes, color, 62),
        ],
      ),
    );
  }

  Widget _buildAverageCard(BuildContext context, AppLocalizations localization) {
    final int avgIndex = selectedQuestions.length - 1;
    final bool isSelected = selectedQuestions[avgIndex];
    const color = Colors.red;

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      elevation: isSelected ? 2 : 0,
      color: isSelected ? color.withValues(alpha: 0.1) : Theme.of(context).disabledColor.withValues(alpha: 0.05),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 50,
              decoration: BoxDecoration(
                color: isSelected ? color.withValues(alpha: 0.5) : Colors.grey.withValues(alpha: 0.2),
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const Icon(Icons.functions, size: 20),
                  const Spacer(),
                  Checkbox(
                    value: isSelected,
                    activeColor: color,
                    onChanged: (val) => onQuestionToggle(avgIndex, val ?? false),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Center(
              child: Text(
                localization.total,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? color : Colors.grey,
                ),
              ),
            ),
          ],
        ),
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
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(leftPadding, 0, 16, 8),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final noteData = notes[index];
          final DateTime date = noteData['date'];
          return Container(
            width: 200,
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.2)),
            ),
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
                    noteData['note'],
                    style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
