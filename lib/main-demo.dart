import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/screens/home_screen.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/utils/security_service.dart';
import 'package:self_examination/utils/demo_data_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Read the language from the environment (e.g., --dart-define=LANGUAGE=en)
  const String forcedLanguage = String.fromEnvironment('LANGUAGE');
  
  final localStorage = LocalStorage();
  await localStorage.initialize();
  await localStorage.loadCurrentAutor();
  
  // DEMO-DATEN GENERIERUNG:
  // Wir nutzen die englische Lokalisierung für die Demo-Daten Notizen
  final demoLocalization = lookupAppLocalizations(const Locale('en'));
  await DemoDataGenerator.generate(demoLocalization);
  
  runApp(MyApp(
    forcedLocale: forcedLanguage.isNotEmpty ? Locale(forcedLanguage) : null,
  ));
}

class MyApp extends StatelessWidget {
  final Locale? forcedLocale;

  const MyApp({super.key, this.forcedLocale});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: forcedLocale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
        ),
        home: const AuthWrapper());
  }
}

/// A wrapper widget that handles initial authentication before showing the home screen.
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final SecurityService _securityService = SecurityService();
  bool _isAuthenticated = false;
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    if (!_securityService.isSecurityEnabled()) {
      setState(() {
        _isAuthenticated = true;
        _isChecking = false;
      });
      return;
    }

    bool success = await _securityService.authenticate();
    setState(() {
      _isAuthenticated = success;
      _isChecking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_isAuthenticated) {
      return HomeScreen();
    }

    final localization = AppLocalizations.of(context);
    final String lockedText = localization?.appLocked ?? "App gesperrt";
    final String unlockText = localization?.unlock ?? "Entsperren";

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 24),
            Text(
              lockedText,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _checkAuth,
              icon: const Icon(Icons.fingerprint),
              label: Text(unlockText),
            ),
          ],
        ),
      ),
    );
  }
}
