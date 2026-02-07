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

  const ChartControlWidget({
    super.key,
    required this.assessmentHistory,
    required this.selectedQuestions,
    required this.currentTimeRange,
    required this.onQuestionToggle,
    required this.onTimeRangeChange,
    required this.onNavigateTime,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final authorKey = LocalStorage().getCurrentAuthor();
    final questionSet = localization.questionMap[authorKey];

    if (questionSet == null) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTimeRangeSelector(context),
        const Divider(height: 1),
        _buildQuestionFilter(questionSet.questions),
        const SizedBox(height: 8),
        _buildNoteInspector(context),
      ],
    );
  }

  // --- Ebene 1: Zeitsteuerung ---
  Widget _buildTimeRangeSelector(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => onNavigateTime(false),
          ),
          ...TimeRange.values.map((range) {
            final isSelected = range == currentTimeRange;
            return ChoiceChip(
              label: Text(_rangeLabel(range)),
              selected: isSelected,
              onSelected: (_) => onTimeRangeChange(range),
              visualDensity: VisualDensity.compact,
              labelStyle: TextStyle(fontSize: 10, color: isSelected ? Colors.white : null),
            );
          }),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => onNavigateTime(true),
          ),
        ],
      ),
    );
  }

  // --- Ebene 2: Fragenfilter (Horizontale Chips) ---
  Widget _buildQuestionFilter(List<dynamic> questions) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: questions.length,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          final color = globalColorMap[index + 1] ?? Colors.grey;
          final isSelected = selectedQuestions[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Text("${index + 1}"),
              selected: isSelected,
              onSelected: (val) => onQuestionToggle(index, val),
              selectedColor: color,
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : null,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }

  // --- Ebene 3: Notiz-Inspektor (Horizontaler Scroller) ---
  Widget _buildNoteInspector(BuildContext context) {
    // Filtere alle Einträge, die überhaupt Notizen haben
    final entriesWithNotes = assessmentHistory.where((entry) => 
      entry.questionNotes.any((note) => note != null && note.isNotEmpty)
    ).toList().reversed.toList();

    if (entriesWithNotes.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: entriesWithNotes.length,
        itemBuilder: (context, index) {
          final entry = entriesWithNotes[index];
          return _buildNoteCard(context, entry);
        },
      ),
    );
  }

  Widget _buildNoteCard(BuildContext context, AssessmentEntry entry) {
    // Sammle alle Notizen für diesen Tag
    final notes = entry.questionNotes
        .asMap()
        .entries
        .where((e) => e.value != null && e.value!.isNotEmpty)
        .toList();

    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('dd.MM.yyyy').format(entry.timestamp),
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blueGrey),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: ListView(
                  children: notes.map((n) => Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${n.key + 1}: ", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: globalColorMap[n.key+1])),
                        Expanded(child: Text(n.value!, style: const TextStyle(fontSize: 11), maxLines: 2, overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  )).toList(),
                ),
              ),
            ],
          ),
        ),
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
