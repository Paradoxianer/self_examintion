import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:self_examination/main.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/localizations/app_localizations.dart';

void main() {
  setUp(() async {
    // Mocking MethodChannel for local_auth is necessary because SecurityService 
    // instantiates LocalAuthentication internally.
    const MethodChannel channel = MethodChannel('plugins.flutter.io/local_auth');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'authenticate') {
        return true; // Default to success
      }
      if (methodCall.method == 'isDeviceSupported' || methodCall.method == 'canCheckBiometrics') {
        return true;
      }
      if (methodCall.method == 'getAvailableBiometrics') {
        return <String>['fingerprint'];
      }
      return null;
    });

    SharedPreferences.setMockInitialValues({
      'isSecurityEnabled': true,
      'agreedToDSGVO': true,
      'onboardingCompleted': true,
    });
    
    final storage = LocalStorage();
    await storage.initialize();
  });

  Widget makeTestableWidget() {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('de'),
      home: AuthWrapper(),
    );
  }

  group('AuthFlow Integration Tests', () {
    testWidgets('Should show HomeScreen when authentication succeeds', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget());
      
      // Wait for AuthWrapper to initialize and call authenticate
      await tester.pumpAndSettle();

      // Since mock returns true, we should be on HomeScreen
      expect(find.text('Willkommen zum Selbstprüfungs-Tool'), findsOneWidget);
    });

    testWidgets('Should show lock screen when authentication fails', (WidgetTester tester) async {
      // Override mock for this specific test
      const MethodChannel channel = MethodChannel('plugins.flutter.io/local_auth');
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        if (methodCall.method == 'authenticate') {
          return false; // Simuliere Fehlgeschlagen
        }
        return true;
      });

      await tester.pumpWidget(makeTestableWidget());
      await tester.pumpAndSettle();

      // Wir sollten den Lock-Screen sehen
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
      expect(find.text('App gesperrt'), findsOneWidget);
    });
  });
}
