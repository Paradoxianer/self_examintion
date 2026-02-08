/// Represents a complete self-assessment session at a specific point in time.
class AssessmentEntry {
  /// The exact time when this assessment was saved.
  final DateTime timestamp;
  /// The key/ID of the question set used (e.g., 'William Booth').
  final String questionSet;
  /// The 0.0 - 1.0 values for each question in the set.
  final List<double> values;
  /// The individual notes for each question (may contain null or empty strings).
  final List<String?> questionNotes;
  /// An optional global summary note for the entire assessment.
  final String? note;

  AssessmentEntry({
    required this.timestamp,
    required this.questionSet,
    required this.values,
    required this.questionNotes,
    this.note,
  });

  /// Converts the entry into a Map for JSON storage.
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'authorName': questionSet,
      'values': values,
      'questionNotes': questionNotes,
      'note': note
    };
  }

  /// Creates an entry from a JSON Map.
  factory AssessmentEntry.fromMap(Map<String, dynamic> map) {
    return AssessmentEntry(
        timestamp: DateTime.parse(map['timestamp']),
        questionSet: map['authorName'].toString(),
        values: List<double>.from(map['values'] ?? []),
        questionNotes: List<String?>.from(map['questionNotes'] ?? []),
        note: map['note']);
  }
}
