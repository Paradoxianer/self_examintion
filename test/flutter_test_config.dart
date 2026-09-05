import 'dart:async';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Wraps every test file: registers the FFI SQLite factory so
/// SqliteAssessmentRepository (#33) works under `flutter test`, which has
/// no real platform channel for the native sqflite plugin.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  sqfliteFfiInit();
  // The no-isolate variant avoids cross-isolate timing issues inside
  // testWidgets' fake-async pump loop (tester.pumpAndSettle() not seeing a
  // background isolate's work complete).
  databaseFactory = databaseFactoryFfiNoIsolate;
  await testMain();
}
