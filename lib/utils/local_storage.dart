import 'package:flutter/foundation.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Kleiner Helper, um notifyListeners() von außen aufrufbar zu machen
class ActivityNotifier extends ChangeNotifier {
  void notify() => notifyListeners();
}

class LocalStorage {
  static final LocalStorage _singleton = LocalStorage._internal();
  SharedPreferences? _prefs;
  String _currentAuthor = "none";

  // Die zwei "Aktivitäten", auf die man getrennt hören kann
  final ActivityNotifier assessmentNotifier = ActivityNotifier();
  final ActivityNotifier settingsNotifier = ActivityNotifier();

  factory LocalStorage() {
    return _singleton;
  }

  LocalStorage._internal();

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    await loadCurrentAutor();
  }

  void setCurrentAuthor(String authorName) {
    if (authorName != _currentAuthor) {
      _currentAuthor = authorName;
      _prefs?.setString('currentAuthor', authorName);
      // Benachrichtigt nur die Assessment-Widgets
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
      _currentAuthor = "Salvation Army Chemnitz";
    }
  }

  // --- Hilfsmethoden für Einstellungen (Nutzen settingsNotifier) ---
  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
    settingsNotifier.notify();
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
    settingsNotifier.notify();
  }

  String? getString(String key) {
    return _prefs?.getString(key);
  }

  // --- Assessment Methoden (Nutzen assessmentNotifier) ---
  Future<void> saveAssessmentEntry(AssessmentEntry entry) async {
    final key = '$_currentAuthor${entry.timestamp.millisecondsSinceEpoch}';
    final entryJson = jsonEncode(entry.toMap());
    await _prefs?.setString(key, entryJson);
    assessmentNotifier.notify();
  }

  Future<List<AssessmentEntry>> loadAssessmentEntries() async {
    final keys = _prefs?.getKeys();
    final entries = <AssessmentEntry>[];
    if (keys != null) {
      for (final key in keys) {
        if (key.startsWith('$_currentAuthor')) {
          final entryJson = _prefs?.getString(key);
          if (entryJson != null) {
            final entryMap = jsonDecode(entryJson);
            entries.add(AssessmentEntry.fromMap(entryMap));
          }
        }
      }
    }
    entries.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return entries;
  }

  Future<void> clearAllAssesmentEntries() async {
    final keys = _prefs?.getKeys();
    if (keys != null) {
      for (final key in keys) {
        if (key.startsWith('$_currentAuthor')) {
          _prefs!.remove(key);
        }
      }
      assessmentNotifier.notify();
    }
  }
}
