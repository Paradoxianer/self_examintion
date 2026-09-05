import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:self_examination/data/assessment_repository.dart';
import 'package:self_examination/models/assessment_entry.dart';

const String _tableName = 'assessment_entries';

/// SQLite-backed storage (#33) for mobile/desktop. Indexed by question set
/// and timestamp so date-range queries (used by the charts' time filters)
/// run at the query level instead of loading the entire history into memory.
class SqliteAssessmentRepository implements AssessmentRepository {
  /// Overrides the database path — used by tests to get an isolated,
  /// throwaway database (e.g. `':memory:'') instead of the real app file.
  final String? databasePathOverride;

  Database? _db;

  SqliteAssessmentRepository({this.databasePathOverride});

  Future<Database> _open() async {
    final existing = _db;
    if (existing != null) return existing;

    final String path = databasePathOverride ?? join(await getDatabasesPath(), 'assessments.db');
    final db = await openDatabase(
      path,
      version: 1,
      // sqflite's default singleInstance:true caches connections by path
      // string. That's desirable for the real app file, but with an
      // override path (tests reusing ':memory:') it would silently hand
      // back a previous test's in-memory database instead of a fresh one.
      singleInstance: databasePathOverride == null,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            question_set TEXT NOT NULL,
            timestamp TEXT NOT NULL,
            values_json TEXT NOT NULL,
            question_notes_json TEXT NOT NULL,
            note TEXT,
            updated_at TEXT NOT NULL
          )
        ''');
        await db.execute(
          'CREATE INDEX idx_assessment_question_set_timestamp ON $_tableName(question_set, timestamp)',
        );
      },
    );
    _db = db;
    return db;
  }

  /// Closes the underlying connection. Only needed by tests that open a
  /// fresh in-memory database per test case.
  Future<void> close() async {
    await _db?.close();
    _db = null;
  }

  @override
  Future<void> save(AssessmentEntry entry) async {
    final db = await _open();
    await db.insert(_tableName, _toRow(entry), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<AssessmentEntry>> loadAll(String questionSet) async {
    final db = await _open();
    final rows = await db.query(
      _tableName,
      where: 'question_set = ?',
      whereArgs: [questionSet],
      orderBy: 'timestamp ASC',
    );
    return rows.map(_fromRow).toList();
  }

  @override
  Future<List<AssessmentEntry>> loadInRange(String questionSet, DateTime start, DateTime end) async {
    final db = await _open();
    final rows = await db.query(
      _tableName,
      where: 'question_set = ? AND timestamp >= ? AND timestamp <= ?',
      whereArgs: [questionSet, start.toIso8601String(), end.toIso8601String()],
      orderBy: 'timestamp ASC',
    );
    return rows.map(_fromRow).toList();
  }

  @override
  Future<void> clearAll(String questionSet) async {
    final db = await _open();
    await db.delete(_tableName, where: 'question_set = ?', whereArgs: [questionSet]);
  }

  Map<String, Object?> _toRow(AssessmentEntry entry) => {
        'id': entry.id,
        'question_set': entry.questionSet,
        'timestamp': entry.timestamp.toIso8601String(),
        'values_json': jsonEncode(entry.values),
        'question_notes_json': jsonEncode(entry.questionNotes),
        'note': entry.note,
        'updated_at': entry.updatedAt.toIso8601String(),
      };

  AssessmentEntry _fromRow(Map<String, Object?> row) => AssessmentEntry(
        id: row['id'] as String,
        questionSet: row['question_set'] as String,
        timestamp: DateTime.parse(row['timestamp'] as String),
        values: (jsonDecode(row['values_json'] as String) as List).map((v) => (v as num).toDouble()).toList(),
        questionNotes: (jsonDecode(row['question_notes_json'] as String) as List).map((v) => v as String?).toList(),
        note: row['note'] as String?,
        updatedAt: DateTime.parse(row['updated_at'] as String),
      );
}
