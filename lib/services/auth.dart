import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class AuthService {
  static Future<bool> authenticateUser() async {
    //initialize Local Authentication plugin.
    final LocalAuthentication _localAuthentication = LocalAuthentication();
    final List<BiometricType> biometricsTypes =
        await _localAuthentication.getAvailableBiometrics();
    print(biometricsTypes);
    //status of authentication.
    bool isAuthenticated = false;
    //check if device supports biometrics authentication.
    bool isBiometricSupported = await _localAuthentication.isDeviceSupported();

    //check if user has enabled biometrics.
    //check
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    //if device supports biometrics and user has enabled biometrics, then authenticate.
    if (biometricsTypes.contains(BiometricType.strong) &&
        isBiometricSupported &&
        canCheckBiometrics) {
      try {
        isAuthenticated = await _localAuthentication.authenticate(
          authMessages: const <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: 'Oops! Biometric authentication required!',
              cancelButton: 'No thanks',
              biometricSuccess: "Attendance Taken",
            ),
            IOSAuthMessages(
              cancelButton: 'No thanks',
            ),
          ],
          localizedReason: 'Scan your fingerprint to authenticate',
          options: const AuthenticationOptions(
            biometricOnly: true,
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
      } on PlatformException catch (e) {
        print(e);
      }
    }
    return isAuthenticated;
  }
}
