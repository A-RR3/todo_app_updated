import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:training_task1/core/values/translations_keys.dart';
import 'package:training_task1/features/home/screens/home_screen.dart';

class LoginController extends GetxController {
  static final LocalAuthentication _auth = LocalAuthentication();
  var hasFingerPrintLock = false.obs;
  var isUserAuthenticated = false.obs;

  @override
  void onInit() {
    _getAvailabeBiometrics();
    super.onInit();
  }

  Future<bool> canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  void _getAvailabeBiometrics() async {
    bool hasLocalAuth = await canAuthenticate();
    if (hasLocalAuth) {
      List<BiometricType> availableBiometrics =
          await _auth.getAvailableBiometrics();
      hasFingerPrintLock.value =
          availableBiometrics.contains(BiometricType.strong);
    }
  }

  void authenticateUser() async {
    try {
      if (!await canAuthenticate()) return;

      isUserAuthenticated.value = await _auth.authenticate(
          localizedReason: TranslationKeys.localizedReason,
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
            useErrorDialogs: true,
          ));
      if (isUserAuthenticated.value) {
        Get.off(const MyHomePage());
      }
    } catch (e) {
      debugPrint('error $e');
    }
  }

}
