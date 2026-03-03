import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/models/assessment_entry.dart';

void main() {
  // Ensure the Flutter test environment is initialized
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Performance Benchmarks (Issue #54)', () {
    late LocalStorage storage;

    setUp(() async {
      // Mocking SharedPreferences to start with a clean state for each test
      SharedPreferences.setMockInitialValues({});
      storage = LocalStorage();
      await storage.initialize();
      storage.setCurrentAuthor("BenchmarkAuthor");
    });

    test('Data Loading Scaling Performance', () async {
      // We test various history sizes to see where the JSON/SharedPreferences approach breaks down
      final sizes = [10, 100, 500, 1000];
      final results = <int, int>{};

      for (var size in sizes) {
        // 1. Prepare Data
        await _generateMockData(storage, size);

        // 2. Measure loading time
        final stopwatch = Stopwatch()..start();
        final entries = await storage.loadAssessmentEntries();
        stopwatch.stop();

        results[size] = stopwatch.elapsedMilliseconds;
        
        // Safety check to ensure data integrity during benchmark
        expect(entries.length, size, reason: 'Failed to load all generated entries for size $size');

        // Cleanup for the next iteration
        await storage.clearAllAssesmentEntries();
      }

      // Output results in a readable format
      print('\n--- LOADING PERFORMANCE RESULTS (SharedPreferences) ---');
      print('Entries | Time (ms) | Avg per Entry');
      print('----------------------------------------------------');
      results.forEach((size, time) {
        double avg = time / size;
        print('${size.toString().padRight(7)} | ${time.toString().padRight(9)}ms | ${avg.toStringAsFixed(3)}ms');
      });
      print('----------------------------------------------------\n');
      
      // Architectural Recommendation based on results
      if (results[1000]! > 100) {
        print('ADVICE: Loading 1000 entries takes > 100ms. Consider SQLite migration (#33) for Release 1.');
      } else {
        print('ADVICE: Performance is within acceptable limits for Release 1.');
      }
    });
  });
}

/// Helper to pump the storage with benchmark data.
/// Using 10 questions per entry as a realistic average.
Future<void> _generateMockData(LocalStorage storage, int count) async {
  for (int i = 0; i < count; i++) {
    final entry = AssessmentEntry(
      timestamp: DateTime.now().subtract(Duration(minutes: i * 30)),
      questionSet: "BenchmarkAuthor",
      values: List.generate(10, (index) => 0.5),
      questionNotes: List.generate(10, (index) => null),
    );
    await storage.saveAssessmentEntry(entry);
  }
}
