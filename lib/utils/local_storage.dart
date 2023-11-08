import 'package:self_examintion/models/assessment_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorage {
  static final LocalStorage _singleton = LocalStorage._internal();
  SharedPreferences? _prefs;
  String _currentAuthor = "none";
  List<Function> _assessmentDataChangedCallbacks = [];


  factory LocalStorage([Function? callback = null]) {
    if (callback!=null)
      _singleton.addAssessmentDataChangedCallback(callback);
    return _singleton;
  }

  LocalStorage._internal() {
    // Try to load the current author on creation
    loadCurrentAutor();
  }

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Set a callback function for assessment data changes
  void addAssessmentDataChangedCallback(Function callback) {
    _assessmentDataChangedCallbacks.add(callback);
  }

  void removeAssessmentDataChangedCallback(Function callback) {
    _assessmentDataChangedCallbacks.remove(callback);
  }

  void setCurrentAuthor(String authorName) {
    //ToDo check if it is a valid Name
    _currentAuthor = authorName;
    _prefs?.setString('currentAuthor', authorName);
    _notifyAssessmentDataChanged();
  }

  String getCurrentAuthor(){
    return _currentAuthor;
  }

  loadCurrentAutor(){
    //ToDO check if we need tocall notifyAssement
    String? tmpStr= _prefs?.getString('currentAuthor');
    if (tmpStr != null)
      _currentAuthor = tmpStr;
  }
  // Methode zum Speichern eines Booleans in SharedPreferences
  Future<void> setBool(String key, bool value) async {
    if (_prefs != null) {
      await _prefs!.setBool(key, value);
    }
  }

  // Methode zum Abrufen eines Booleans aus SharedPreferences
  bool getBool(String key, {bool defaultValue = false}) {
    if (_prefs != null) {
      return _prefs!.getBool(key) ?? defaultValue;
    }
    return defaultValue;
  }

  // Methode zum Speichern eines Doubles in SharedPreferences
  Future<void> setDouble(String key, double value) async {
    if (_prefs != null) {
      await _prefs!.setDouble(key, value);
    }
  }

  // Methode zum Abrufen eines String aus SharedPreferences
  String? getString(String key) {
    if (_prefs != null) {
      return _prefs!.getString(key);
    }
    return null;
  }

  Future<void> setString(String key, String value) async {
    if (_prefs != null) {
      await _prefs!.setString(key, value);
    }
  }

  // Methode zum Abrufen eines Double aus SharedPreferences
  double? getDouble(String key) {
    if (_prefs != null) {
      return _prefs!.getDouble(key);
    }
    return null;
  }

  Future<void> saveAssessmentEntry(AssessmentEntry entry) async {
    if (_currentAuthor == null) {
      throw Exception('Author not set. Please set the author before saving.');
    }

    final key = '$_currentAuthor${entry.timestamp.millisecondsSinceEpoch}';
    final entryJson = jsonEncode(entry.toMap());
    await _prefs?.setString(key, entryJson);
    _notifyAssessmentDataChanged();
  }

  Future<void> clearAllAssesmentEntries() async {
    if (_currentAuthor == null) {
      throw Exception('Author not set. Please set the author before loading.');
    }
    final keys = _prefs?.getKeys();
    if (keys != null) {
      for (final key in keys) {
        if (key.startsWith('$_currentAuthor')) {
          _prefs!.remove(key);
        }
      }
      _notifyAssessmentDataChanged();
    }

  }


  Future<List<AssessmentEntry>> loadAssessmentEntries() async {
    if (_currentAuthor == null) {
      throw Exception('Author not set. Please set the author before loading.');
    }

    final keys = _prefs?.getKeys();
    final entries = <AssessmentEntry>[];
    if (keys != null) {
      for (final key in keys) {
        if (key.startsWith('$_currentAuthor')) {
          final entryJson = _prefs?.getString(key);
          if (entryJson != null) {
            final entryMap = jsonDecode(entryJson);
            final entry = AssessmentEntry.fromMap(entryMap);
            entries.add(entry);
          }
        }
      }
    }

    // Sort the entries by timestamp
    entries.sort((entry1, entry2) => entry1.timestamp.compareTo(entry2.timestamp));
    return entries;
  }
  void _notifyAssessmentDataChanged() {
    for (var callback in _assessmentDataChangedCallbacks) {
      callback();
    }
  }
}