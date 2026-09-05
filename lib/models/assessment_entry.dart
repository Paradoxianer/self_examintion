import 'package:uuid/uuid.dart';

/// Represents a complete self-assessment session at a specific point in time.
class AssessmentEntry {
  /// A stable identifier, independent of timestamp/device. Needed so a
  /// future cross-device sync (#42) can identify and merge the same record
  /// instead of relying on timestamps, which can collide or drift.
  final String id;
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
  /// When this record was last written. Distinct from [timestamp] (which is
  /// the assessment's own date) — this is bookkeeping for a future sync's
  /// last-write-wins conflict resolution.
  final DateTime updatedAt;

  AssessmentEntry({
    String? id,
    required this.timestamp,
    required this.questionSet,
    required this.values,
    required this.questionNotes,
    this.note,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        updatedAt = updatedAt ?? timestamp;

  /// Converts the entry into a Map for JSON storage.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'authorName': questionSet,
      'values': values,
      'questionNotes': questionNotes,
      'note': note,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Creates an entry from a JSON Map. Tolerates maps saved before [id] and
  /// [updatedAt] existed by generating/deriving sensible defaults for them.
  factory AssessmentEntry.fromMap(Map<String, dynamic> map) {
    final DateTime timestamp = DateTime.parse(map['timestamp']);
    return AssessmentEntry(
        id: map['id'] as String?,
        timestamp: timestamp,
        questionSet: map['authorName'].toString(),
        values: List<double>.from(map['values'] ?? []),
        questionNotes: List<String?>.from(map['questionNotes'] ?? []),
        note: map['note'],
        updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : timestamp);
  }
}
