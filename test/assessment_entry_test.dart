import 'package:flutter_test/flutter_test.dart';
import 'package:self_examination/models/assessment_entry.dart';

void main() {
  group('AssessmentEntry Serialization Tests', () {

    test('toMap() should convert object to correct Map structure', () {
      final now = DateTime.now();
      final entry = AssessmentEntry(
        timestamp: now,
        questionSet: 'William Booth',
        values: [0.5, 1.0, 0.0],
        questionNotes: ['Note 1', '', null],
        note: 'Global note'
      );

      final map = entry.toMap();

      expect(map['timestamp'], now.toIso8601String());
      expect(map['authorName'], 'William Booth');
      expect(map['values'], [0.5, 1.0, 0.0]);
      expect(map['questionNotes'], ['Note 1', '', null]);
      expect(map['note'], 'Global note');
    });

    test('fromMap() should recreate object accurately from Map', () {
      final isoDate = "2024-03-20T12:00:00.000Z";
      final map = {
        'timestamp': isoDate,
        'authorName': 'John Wesley',
        'values': [0.2, 0.8],
        'questionNotes': ['Test', 'Note'],
        'note': 'Summary'
      };

      final entry = AssessmentEntry.fromMap(map);

      expect(entry.timestamp, DateTime.parse(isoDate));
      expect(entry.questionSet, 'John Wesley');
      expect(entry.values, [0.2, 0.8]);
      expect(entry.questionNotes, ['Test', 'Note']);
      expect(entry.note, 'Summary');
    });

    test('fromMap() should handle missing or null fields gracefully', () {
       final map = {
        'timestamp': DateTime.now().toIso8601String(),
        'authorName': 'Unknown',
        // values and questionNotes missing
      };

      final entry = AssessmentEntry.fromMap(map);
      expect(entry.values, isA<List<double>>());
      expect(entry.values, isEmpty);
      expect(entry.questionNotes, isA<List<String?>>());
      expect(entry.questionNotes, isEmpty);
    });
  });
}
