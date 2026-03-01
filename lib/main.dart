import 'package:flutter/material.dart';
import 'package:self_examination/localizations/app_localizations.dart';
import 'package:self_examination/screens/home_screen.dart';
import 'package:self_examination/utils/local_storage.dart';
import 'package:self_examination/utils/security_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localStorage = LocalStorage();
  await localStorage.initialize();
  await localStorage.loadCurrentAutor();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

/// A wrapper widget that handles initial authentication and app lifecycle
/// to secure the app when it enters the background.
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> with WidgetsBindingObserver {
  final SecurityService _securityService = SecurityService();
  bool _isAuthenticated = false;
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkAuth();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Re-authenticate when the app comes to the foreground
    if (state == AppLifecycleState.resumed) {
      _checkAuth();
    } else if (state == AppLifecycleState.paused) {
      // Lock the app when it goes to the background
      setState(() {
        _isAuthenticated = false;
      });
    }
  }

  Future<void> _checkAuth() async {
    // If security is disabled, we are "authenticated" by default
    if (!_securityService.isSecurityEnabled()) {
      setState(() {
        _isAuthenticated = true;
        _isChecking = false;
      });
      return;
    }

    setState(() {
      _isChecking = true;
    });

    // We need a context to get the localization
    // Since initState doesn't have a context, we might need a small delay or
    // handle it in the build method. But for better UX, we use a default or
    // wait for the first frame.
    
    // In AuthWrapper, we can use a generic reason if localization is not yet ready,
    // but better to wait for the frame.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      
      final localization = AppLocalizations.of(context);
      final String reason = localization?.unlock ?? 'Please authenticate to access your data';
      
      bool success = await _securityService.authenticate(localizedReason: reason);
      
      if (mounted) {
        setState(() {
          _isAuthenticated = success;
          _isChecking = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final localization = AppLocalizations.of(context)!;

    if (_isAuthenticated) {
      return HomeScreen();
    }

    // Lock screen if authentication failed
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 24),
            Text(
              localization.appLocked,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _checkAuth,
              icon: const Icon(Icons.fingerprint),
              label: Text(localization.unlock),
            ),
          ],
        ),
      ),
    );
  }
}
