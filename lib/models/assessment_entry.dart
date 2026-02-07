class AssessmentEntry {
  final DateTime timestamp;
  final String questionSet;
  final List<double> values; // Die 0-1.0 Werte für jede Frage
  final List<String?> questionNotes; // Notizen für jede einzelne Frage
  final String? note; // Globale Notiz (optional)

  AssessmentEntry({
    required this.timestamp,
    required this.questionSet,
    required this.values,
    required this.questionNotes,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'authorName': questionSet,
      'values': values,
      'questionNotes': questionNotes,
      'note': note
    };
  }

  factory AssessmentEntry.fromMap(Map<String, dynamic> map) {
    return AssessmentEntry(
        timestamp: DateTime.parse(map['timestamp']),
        questionSet: map['authorName'].toString(),
        values: List<double>.from(map['values'] ?? []),
        questionNotes: List<String?>.from(map['questionNotes'] ?? []),
        note: map['note']);
  }
}
