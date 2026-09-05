import 'package:self_examination/data/prefs_assessment_repository.dart';
import 'package:self_examination/models/assessment_entry.dart';

/// Storage backend for [AssessmentEntry] records, scoped per question set
/// (the "author key", e.g. 'William Booth').
///
/// Two implementations exist: [PrefsAssessmentRepository] (used on web,
/// where there's no SQLite) and a SQLite-backed one for mobile/desktop
/// (see #33) that can filter by date range at the query level instead of
/// loading everything into memory.
abstract class AssessmentRepository {
  Future<void> save(AssessmentEntry entry);

  Future<List<AssessmentEntry>> loadAll(String questionSet);

  Future<List<AssessmentEntry>> loadInRange(String questionSet, DateTime start, DateTime end);

  Future<void> clearAll(String questionSet);
}
