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

  // Speichert eine Liste von Booleans als JSON-String
  Future<void> setBoolList(String key, List<bool> values) async {
    final String json = jsonEncode(values);
    await _prefs?.setString(key, json);
    // Wir notifizieren hier nicht automatisch, da dies oft Teil einer größeren Änderung ist
  }

  // Lädt eine Liste von Booleans
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
