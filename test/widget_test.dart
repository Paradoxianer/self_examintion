import 'package:flutter_test/flutter_test.dart';
import 'package:self_examination/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:self_examination/utils/local_storage.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Initialize mock storage with security disabled
    SharedPreferences.setMockInitialValues({'isSecurityEnabled': false});
    final storage = LocalStorage();
    await storage.initialize();

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Use pumpAndSettle to wait for all animations and async timers (like Auth check)
    await tester.pumpAndSettle();

    // Basic check if app starts
    expect(find.byType(MyApp), findsOneWidget);
  });
}
