import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:self_examination/data/assessment_repository.dart';
import 'package:self_examination/data/prefs_assessment_repository.dart';
import 'package:self_examination/data/sqlite_assessment_repository.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const String _sqliteMigrationDoneKey = 'assessmentSqliteMigrationDone';

// Kleiner Helper, um notifyListeners() von außen aufrufbar zu machen
class ActivityNotifier extends ChangeNotifier {
  void notify() => notifyListeners();
}

class LocalStorage {
  static final LocalStorage _singleton = LocalStorage._internal();
  SharedPreferences? _prefs;
  String _currentAuthor = "none";
  Locale? _currentLocale;
  AssessmentRepository? _assessmentRepository;

  final ActivityNotifier assessmentNotifier = ActivityNotifier();
  final ActivityNotifier settingsNotifier = ActivityNotifier();

  factory LocalStorage() {
    return _singleton;
  }

  LocalStorage._internal();

  /// [assessmentDatabasePath] overrides where the SQLite database lives —
  /// used by tests to get an isolated database (e.g. `':memory:'`) instead
  /// of the real app file. Ignored on web, which has no SQLite backend.
  Future<void> initialize({String? assessmentDatabasePath}) async {
    _prefs = await SharedPreferences.getInstance();
    await loadCurrentAutor();
    _loadLocale();
    await _initializeAssessmentRepository(assessmentDatabasePath);
  }

  /// Sets up the assessment storage backend: SQLite on mobile/desktop (#33,
  /// so charts can filter by date range at the query level instead of
  /// loading everything into memory), plain SharedPreferences on web (no
  /// SQLite there). On first run on mobile/desktop, migrates any history
  /// from the old SharedPreferences format into SQLite.
  Future<void> _initializeAssessmentRepository(String? assessmentDatabasePath) async {
    if (kIsWeb) {
      _assessmentRepository = PrefsAssessmentRepository(_prefs!);
      return;
    }

    final sqliteRepo = SqliteAssessmentRepository(databasePathOverride: assessmentDatabasePath);
    if (!getBool(_sqliteMigrationDoneKey)) {
      final legacyEntries = PrefsAssessmentRepository(_prefs!).loadEverythingForMigration();
      for (final entry in legacyEntries) {
        await sqliteRepo.save(entry);
      }
      // Legacy SharedPreferences entries are intentionally left in place
      // (harmless, tiny) rather than deleted — this flag just prevents
      // re-importing them (and duplicating rows) on every future launch.
      await setBool(_sqliteMigrationDoneKey, true);
    }
    _assessmentRepository = sqliteRepo;
  }

  void setCurrentAuthor(String authorName) {
    if (authorName != _currentAuthor) {
      _currentAuthor = authorName;
      _prefs?.setString('currentAuthor', authorName);
      assessmentNotifier.notify();
    }
  }

  String getCurrentAuthor() {
    return _currentAuthor;
  }

  Future<void> loadCurrentAutor() async {
    String? tmpStr = _prefs?.getString('currentAuthor');
    if (tmpStr != null && tmpStr != _currentAuthor) {
      _currentAuthor = tmpStr;
      assessmentNotifier.notify();
    } else if (tmpStr == null) {
      // SET DEFAULT QUESTION SET TO WILLIAM BOOTH
      _currentAuthor = "William Booth";
    }
  }

  // --- Locale Management ---
  void _loadLocale() {
    String? languageCode = _prefs?.getString('languageCode');
    if (languageCode != null) {
      _currentLocale = Locale(languageCode);
    }
  }

  Locale? get locale => _currentLocale;

  Future<void> setLocale(Locale? locale) async {
    _currentLocale = locale;
    if (locale == null) {
      await _prefs?.remove('languageCode');
    } else {
      await _prefs?.setString('languageCode', locale.languageCode);
    }
    settingsNotifier.notify();
  }

  // --- Hilfsmethoden für Einstellungen ---
  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
    settingsNotifier.notify();
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
    settingsNotifier.notify();
  }

  int getInt(String key, {int defaultValue = 0}) {
    return _prefs?.getInt(key) ?? defaultValue;
  }

  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
    settingsNotifier.notify();
  }

  String? getString(String key) {
    return _prefs?.getString(key);
  }

  Future<void> setBoolList(String key, List<bool> values) async {
    final String json = jsonEncode(values);
    await _prefs?.setString(key, json);
  }

  List<bool>? getBoolList(String key) {
    final String? json = _prefs?.getString(key);
    if (json == null) return null;
    try {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.cast<bool>();
    } catch (e) {
      return null;
    }
  }

  // --- Assessment Methoden ---
  Future<void> saveAssessmentEntry(AssessmentEntry entry) async {
    await _assessmentRepository?.save(entry);
    assessmentNotifier.notify();
  }

  Future<List<AssessmentEntry>> loadAssessmentEntries() async {
    return await _assessmentRepository?.loadAll(_currentAuthor) ?? [];
  }

  /// Loads only the entries within [start]..[end] (inclusive) for the
  /// current author. On mobile/desktop this is a real indexed SQL query
  /// (#33) rather than loading the whole history and filtering in Dart.
  Future<List<AssessmentEntry>> loadAssessmentEntriesInRange(DateTime start, DateTime end) async {
    return await _assessmentRepository?.loadInRange(_currentAuthor, start, end) ?? [];
  }

  Future<void> clearAllAssesmentEntries() async {
    await _assessmentRepository?.clearAll(_currentAuthor);
    assessmentNotifier.notify();
  }
}
