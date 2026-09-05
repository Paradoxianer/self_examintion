import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/models/assessment_entry.dart';

void main() {
  group('SharedPreferences -> SQLite migration (#33)', () {
    test('legacy entries are imported into SQLite on first launch', () async {
      // Simulate pre-existing data in the old SharedPreferences format,
      // written directly (bypassing LocalStorage, which now always writes
      // to SQLite) plus a few unrelated settings keys of other types —
      // these must not break the migration scan.
      final legacyEntry = AssessmentEntry(
        timestamp: DateTime(2025, 5, 1),
        questionSet: 'Legacy Author',
        values: [0.4, 0.6],
        questionNotes: ['old note', null],
      );
      SharedPreferences.setMockInitialValues({
        'Legacy Author${legacyEntry.timestamp.millisecondsSinceEpoch}': jsonEncode(legacyEntry.toMap()),
        'isSecurityEnabled': false,
        'lastChartIndex': 2,
        'currentAuthor': 'Legacy Author',
      });

      final storage = LocalStorage();
      await storage.initialize(assessmentDatabasePath: ':memory:');

      final migrated = await storage.loadAssessmentEntries();
      expect(migrated.length, 1);
      expect(migrated.first.questionSet, 'Legacy Author');
      expect(migrated.first.questionNotes.first, 'old note');
    });

    test('migration does not duplicate entries on a second initialize()', () async {
      // Uses a real (temp) file rather than ':memory:' so it actually
      // persists across both initialize() calls below, like the real app's
      // database does across a warm restart — an in-memory DB would just
      // start empty again the second time, which isn't what this checks.
      final dbPath = p.join(Directory.systemTemp.path, 'migration_test_${DateTime.now().microsecondsSinceEpoch}.db');
      addTearDown(() {
        final file = File(dbPath);
        if (file.existsSync()) file.deleteSync();
      });

      final legacyEntry = AssessmentEntry(
        timestamp: DateTime(2025, 5, 2),
        questionSet: 'Once Author',
        values: [0.5],
        questionNotes: ['note'],
      );
      SharedPreferences.setMockInitialValues({
        'Once Author${legacyEntry.timestamp.millisecondsSinceEpoch}': jsonEncode(legacyEntry.toMap()),
        'currentAuthor': 'Once Author',
      });

      final storage = LocalStorage();
      await storage.initialize(assessmentDatabasePath: dbPath);
      // A second initialize() (e.g. a warm restart) must see the
      // migration-done flag and skip re-importing into the same database.
      await storage.initialize(assessmentDatabasePath: dbPath);

      final entries = await storage.loadAssessmentEntries();
      expect(entries.length, 1);
    });
  });
}
