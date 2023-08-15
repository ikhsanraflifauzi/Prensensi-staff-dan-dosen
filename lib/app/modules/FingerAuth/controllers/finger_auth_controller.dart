import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';
import 'package:flutter_lock_screen/flutter_lock_screen.dart';

class FingerAuthController extends GetxController {
  final _localAuth = LocalAuthentication();
  var fingerPrint = false.obs;
  var faceAuth = false.obs;
  var userAuth = false.obs;

  void getBiometrics() async {
    bool hasLoacalAuth = await _localAuth.canCheckBiometrics;

    if (hasLoacalAuth) {
      List<BiometricType> availableBiometrics =
          await _localAuth.getAvailableBiometrics();
      faceAuth.value = availableBiometrics.contains(BiometricType.face);
      fingerPrint.value =
          availableBiometrics.contains(BiometricType.fingerprint);
    } else {
      Get.defaultDialog(
          title: 'Error',
          middleText: 'tidak dapat menggunakan fitur pada device');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getBiometrics();
  }

  void authenticated() async {
    try {
      userAuth.value = await _localAuth.authenticate(
          localizedReason: 'autentikasi diri',
          options:
              AuthenticationOptions(biometricOnly: true, stickyAuth: true));
      if (userAuth.value) {
        Get.offAllNamed(Routes.LOGIN);
      }
    } catch (e) {
      Get.defaultDialog(
          title: 'terjadi Kesalahan',
          middleText: 'device tidak mendukung untuk fingerprint auth');
    }
  }

  bool verifyPassCode(List<int> enteredPassCode, List<int> myPass) {
    for (int i = 0; i < myPass.length; i++) {
      if (enteredPassCode[i] != myPass[i]) {
        return false;
      }
    }
    return true;
  }
}
