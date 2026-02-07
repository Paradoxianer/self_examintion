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
            // Erhöhtes Bottom-Padding, um Überlagerung durch Steuerbalken zu verhindern
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: questionSet.questions.length,
            itemBuilder: (context, qIndex) {
              final color = globalColorMap[qIndex + 1] ?? Colors.grey;
              final isSelected = selectedQuestions[qIndex];
              final questionText = questionSet.questions[qIndex].text;

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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 50,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: isSelected ? color.withValues(alpha: 0.5) : Colors.grey.withValues(alpha: 0.2),
                                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20)),
                                ),
                                child: Center(
                                  child: Text(
                                    "${qIndex + 1}",
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Checkbox(
                                value: isSelected,
                                activeColor: color,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                onChanged: (val) => onQuestionToggle(qIndex, val ?? false),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0, right: 8.0),
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
      height: 75,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(58, 0, 16, 8),
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
