import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:self_examination/utils/local_storage.dart';

/// Service to handle biometric and PIN-based authentication.
///
/// This service provides an abstraction layer over the `local_auth` package
/// to secure the application and sensitive user data.
class SecurityService {
  static final SecurityService _instance = SecurityService._internal();
  final LocalAuthentication _auth = LocalAuthentication();
  final LocalStorage _localStorage = LocalStorage();

  factory SecurityService() {
    return _instance;
  }

  SecurityService._internal();

  /// Checks if the device is capable of biometric authentication
  /// (Fingerprint, FaceID) or has a system-level PIN/Passcode set.
  Future<bool> canAuthenticate() async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
      return canAuthenticate;
    } catch (e) {
      return false;
    }
  }

  /// Attempts to authenticate the user using the system dialog.
  ///
  /// [localizedReason] is shown to the user in the system dialog.
  /// If security is disabled in the app settings, it returns [true] immediately.
  /// Returns [true] if authentication was successful, [false] otherwise.
  Future<bool> authenticate({required String localizedReason}) async {
    if (!_localStorage.getBool('isSecurityEnabled', defaultValue: false)) {
      return true;
    }

    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: localizedReason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false, // Allows PIN/Pattern fallback
          useErrorDialogs: true, // Shows system dialogs for errors
        ),
      );
      return didAuthenticate;
    } on PlatformException catch (e) {
      print("SecurityService Error: $e");
      // Handle specific errors like NotEnrolled if needed
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Returns [true] if the app lock is currently enabled in the settings.
  bool isSecurityEnabled() {
    return _localStorage.getBool('isSecurityEnabled', defaultValue: false);
  }

  /// Persistently enables or disables the app lock.
  Future<void> setSecurityEnabled(bool value) async {
    await _localStorage.setBool('isSecurityEnabled', value);
  }
}
