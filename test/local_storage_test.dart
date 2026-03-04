import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/models/assessment_entry.dart';
import 'dart:convert';

void main() {
  group('LocalStorage Tests', () {
    late LocalStorage storage;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      storage = LocalStorage();
      await storage.initialize();
    });

    test('Initial author should be William Booth if none is set', () async {
      expect(storage.getCurrentAuthor(), 'William Booth');
    });

    test('Setting and getting author', () {
      storage.setCurrentAuthor('John Wesley');
      expect(storage.getCurrentAuthor(), 'John Wesley');
    });

    test('Saving and loading assessment entries', () async {
      final timestamp = DateTime(2024, 3, 4, 12, 0);
      final entry = AssessmentEntry(
        timestamp: timestamp,
        values: [0.5, 0.8],
        questionNotes: ['Note 1', 'Note 2'],
      );

      storage.setCurrentAuthor('Test Author');
      await storage.saveAssessmentEntry(entry);

      final loadedEntries = await storage.loadAssessmentEntries();
      expect(loadedEntries.length, 1);
      expect(loadedEntries.first.timestamp, timestamp);
      expect(loadedEntries.first.values, [0.5, 0.8]);
      expect(loadedEntries.first.questionNotes, ['Note 1', 'Note 2']);
    });

    test('Loading entries should be filtered by current author', () async {
      storage.setCurrentAuthor('Author A');
      await storage.saveAssessmentEntry(AssessmentEntry(
        timestamp: DateTime(2024, 1, 1),
        values: [0.1],
        questionNotes: ['A'],
      ));

      storage.setCurrentAuthor('Author B');
      await storage.saveAssessmentEntry(AssessmentEntry(
        timestamp: DateTime(2024, 1, 2),
        values: [0.2],
        questionNotes: ['B'],
      ));

      final entriesB = await storage.loadAssessmentEntries();
      expect(entriesB.length, 1);
      expect(entriesB.first.questionNotes.first, 'B');

      storage.setCurrentAuthor('Author A');
      final entriesA = await storage.loadAssessmentEntries();
      expect(entriesA.length, 1);
      expect(entriesA.first.questionNotes.first, 'A');
    });

    test('Clearing entries should only affect current author', () async {
      storage.setCurrentAuthor('Author A');
      await storage.saveAssessmentEntry(AssessmentEntry(
        timestamp: DateTime(2024, 1, 1),
        values: [0.1],
        questionNotes: ['A'],
      ));

      storage.setCurrentAuthor('Author B');
      await storage.saveAssessmentEntry(AssessmentEntry(
        timestamp: DateTime(2024, 1, 2),
        values: [0.2],
        questionNotes: ['B'],
      ));

      await storage.clearAllAssesmentEntries();
      
      final entriesB = await storage.loadAssessmentEntries();
      expect(entriesB.isEmpty, true);

      storage.setCurrentAuthor('Author A');
      final entriesA = await storage.loadAssessmentEntries();
      expect(entriesA.length, 1);
    });

    test('Setting and getting bool list', () async {
      final values = [true, false, true];
      await storage.setBoolList('test_list', values);
      
      final loaded = storage.getBoolList('test_list');
      expect(loaded, values);
    });

    test('LocalStorage should notify on changes', () async {
      bool notified = false;
      storage.assessmentNotifier.addListener(() {
        notified = true;
      });

      storage.setCurrentAuthor('New Author');
      expect(notified, true);
    });
  });
}
