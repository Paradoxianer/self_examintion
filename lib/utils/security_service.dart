import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:self_examination/utils/local_storage.dart';

class SecurityService {
  static final SecurityService _instance = SecurityService._internal();
  final LocalAuthentication _auth = LocalAuthentication();
  final LocalStorage _localStorage = LocalStorage();

  factory SecurityService() {
    return _instance;
  }

  SecurityService._internal();

  /// Checks if the device is capable of biometric authentication or has a PIN/Passcode set.
  Future<bool> canAuthenticate() async {
    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    return canAuthenticate;
  }

  /// Attempts to authenticate the user. 
  /// Returns [true] if successful, [false] otherwise.
  Future<bool> authenticate() async {
    // Check if security is even enabled in settings
    if (!_localStorage.getBool('isSecurityEnabled', defaultValue: false)) {
      return true;
    }

    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Bitte authentifiziere dich, um deine Daten zu schützen.',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false, // Allows PIN/Pattern fallback
        ),
      );
      return didAuthenticate;
    } on PlatformException catch (e) {
      print("SecurityService Error: $e");
      return false;
    }
  }

  /// Helper to check if security is active in settings
  bool isSecurityEnabled() {
    return _localStorage.getBool('isSecurityEnabled', defaultValue: false);
  }

  /// Enable or disable security
  Future<void> setSecurityEnabled(bool value) async {
    await _localStorage.setBool('isSecurityEnabled', value);
  }
}
