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

  const ChartControlWidget({
    super.key,
    required this.assessmentHistory,
    required this.selectedQuestions,
    required this.currentTimeRange,
    required this.onQuestionToggle,
    required this.onTimeRangeChange,
    required this.onNavigateTime,
    required this.onTodayPressed,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final authorKey = LocalStorage().getCurrentAuthor();
    final questionSet = localization.questionMap[authorKey];

    if (questionSet == null) return const SizedBox.shrink();

    return Column(
      children: [
        _buildTimeRangeSelector(context),
        const Divider(height: 1),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            itemCount: questionSet.questions.length,
            itemBuilder: (context, qIndex) {
              final color = globalColorMap[qIndex + 1] ?? Colors.grey;
              final isSelected = selectedQuestions[qIndex];
              final questionText = questionSet.questions[qIndex].text;

              // Extract notes specific to THIS question
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
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                elevation: isSelected ? 2 : 0,
                color: isSelected ? null : Theme.of(context).disabledColor.withValues(alpha: 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        radius: 14,
                        backgroundColor: isSelected ? color : Colors.grey.shade300,
                        child: Text(
                          "${qIndex + 1}",
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                        questionText,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? null : Colors.grey,
                        ),
                      ),
                      trailing: Checkbox(
                        value: isSelected,
                        activeColor: color,
                        onChanged: (val) => onQuestionToggle(qIndex, val ?? false),
                      ),
                    ),
                    if (isSelected && questionNotes.isNotEmpty)
                      _buildNotesCarousel(context, questionNotes, color),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimeRangeSelector(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.today, size: 20),
            onPressed: onTodayPressed,
            tooltip: "Heute",
          ),
          IconButton(
            icon: const Icon(Icons.chevron_left, size: 20),
            onPressed: () => onNavigateTime(false),
          ),
          ...TimeRange.values.map((range) {
            final isSelected = range == currentTimeRange;
            return ChoiceChip(
              label: Text(_rangeLabel(range), style: const TextStyle(fontSize: 10)),
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

  Widget _buildNotesCarousel(BuildContext context, List<Map<String, dynamic>> notes, Color color) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(52, 0, 16, 8),
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

  String _rangeLabel(TimeRange range) {
    switch (range) {
      case TimeRange.twoDays: return "2T";
      case TimeRange.week: return "1W";
      case TimeRange.month: return "1M";
      case TimeRange.year: return "1J";
      case TimeRange.all: return "Alle";
    }
  }
}
