import 'package:self_examination/models/assessment_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorage {
  static final LocalStorage _singleton = LocalStorage._internal();
  SharedPreferences? _prefs;
  String _currentAuthor = "none";
  List<Function> _assessmentDataChangedCallbacks = [];
  List<Function> _settingsChangedCallbacks = [];


  factory LocalStorage([Function? assessmentCallback = null,Function? settingsCallback = null]) {
    if (assessmentCallback !=null)
      _singleton.addAssessmentDataChangedCallback(assessmentCallback);
    if (settingsCallback !=null)
      _singleton.addSettingsChangedCallback(settingsCallback);
    return _singleton;
  }

  LocalStorage._internal() {
    // Try to load the current author on creation
    loadCurrentAutor();
  }

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    await loadCurrentAutor();
  }

  // Set a callback function for assessment data changes
  void addAssessmentDataChangedCallback(Function callback) {
    _assessmentDataChangedCallbacks.add(callback);
  }

  void removeAssessmentDataChangedCallback(Function callback) {
    _assessmentDataChangedCallbacks.remove(callback);
  }

  // Set a callback function for settings data changes
  void addSettingsChangedCallback(Function callback) {
    _settingsChangedCallbacks.add(callback);
  }

  void removeSettingsChangedCallback(Function callback) {
    _settingsChangedCallbacks.remove(callback);
  }

  void setCurrentAuthor(String authorName) {
    //ToDo check if it is a valid Name
    if (authorName.compareTo(_currentAuthor) !=0) {
      _currentAuthor = authorName;
      _prefs?.setString('currentAuthor', authorName);
      _notifyAssessmentDataChanged();
    }
  }

  String getCurrentAuthor(){
    return _currentAuthor;
  }

  loadCurrentAutor() async{
    //ToDO check if we need tocall notifyAssement
    String? tmpStr= await _prefs?.getString('currentAuthor');
    if (tmpStr != null) {
      if (tmpStr!= _currentAuthor) _notifyAssessmentDataChanged();
      _currentAuthor = tmpStr;
    }
    else
      _currentAuthor = "William Booth";
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
   //disable for now _notifyAssessmentDataChanged();
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

  void _notifySettingsChanged() {
    for (var callback in _settingsChangedCallbacks) {
      callback();
    }
  }
}