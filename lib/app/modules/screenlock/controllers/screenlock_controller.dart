import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class ScreenlockController extends GetxController {
  bool isFingerprint = false;
  var myPass = [1, 2, 3, 4];
  bool verifyPassCode(List<int> enteredPassCode, List<int> myPass) {
    for (int i = 0; i < myPass.length; i++) {
      if (enteredPassCode[i] != myPass[i]) {
        return false;
      }
    }
    return true;
  }
}
