import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:self_examination/data/assessment_repository.dart';
import 'package:self_examination/models/assessment_entry.dart';

/// The original SharedPreferences-backed storage: one JSON string per entry,
/// keyed by "questionSet + millisecond timestamp". Kept as the storage
/// backend for web (no SQLite there) and as the read source for the
/// one-time migration into SQLite on mobile/desktop.
class PrefsAssessmentRepository implements AssessmentRepository {
  final SharedPreferences prefs;

  PrefsAssessmentRepository(this.prefs);

  @override
  Future<void> save(AssessmentEntry entry) async {
    final String key = '${entry.questionSet}${entry.timestamp.millisecondsSinceEpoch}';
    await prefs.setString(key, jsonEncode(entry.toMap()));
  }

  @override
  Future<List<AssessmentEntry>> loadAll(String questionSet) async {
    final List<AssessmentEntry> entries = [];
    for (final key in prefs.getKeys()) {
      if (!key.startsWith(questionSet)) continue;
      final entry = _decode(_readStringSafely(key));
      if (entry != null) entries.add(entry);
    }
    entries.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return entries;
  }

  @override
  Future<List<AssessmentEntry>> loadInRange(String questionSet, DateTime start, DateTime end) async {
    final all = await loadAll(questionSet);
    return all.where((e) => !e.timestamp.isBefore(start) && !e.timestamp.isAfter(end)).toList();
  }

  @override
  Future<void> clearAll(String questionSet) async {
    for (final key in prefs.getKeys().toList()) {
      if (key.startsWith(questionSet)) {
        await prefs.remove(key);
      }
    }
  }

  /// Every parseable entry across ALL question sets, regardless of the
  /// current author. Only used once, to migrate legacy data into SQLite —
  /// normal reads are always scoped to a single question set.
  List<AssessmentEntry> loadEverythingForMigration() {
    final List<AssessmentEntry> entries = [];
    for (final key in prefs.getKeys()) {
      final entry = _decode(_readStringSafely(key));
      if (entry != null) entries.add(entry);
    }
    return entries;
  }

  /// Settings are stored under the same SharedPreferences instance with
  /// their native type (bool/int/...); reading one of those via getString
  /// throws a cast error rather than returning null, so this has to guard
  /// against that when scanning ALL keys (loadAll/loadEverythingForMigration
  /// don't know ahead of time which keys are assessment entries).
  String? _readStringSafely(String key) {
    try {
      return prefs.getString(key);
    } catch (_) {
      return null;
    }
  }

  AssessmentEntry? _decode(String? json) {
    if (json == null) return null;
    try {
      final decoded = jsonDecode(json);
      if (decoded is! Map || !decoded.containsKey('timestamp') || !decoded.containsKey('authorName')) {
        return null;
      }
      return AssessmentEntry.fromMap(Map<String, dynamic>.from(decoded));
    } catch (_) {
      // Not an assessment entry (e.g. a settings key that happens to hold a string).
      return null;
    }
  }
}
