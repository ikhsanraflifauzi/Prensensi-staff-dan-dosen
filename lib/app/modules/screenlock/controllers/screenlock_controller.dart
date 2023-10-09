import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenlockController extends GetxController {
  bool isFingerprint = false;
  TextEditingController pass = TextEditingController();
  var myPass = [2, 5, 4, 4];
  bool verifyPassCode(List<int> enteredPassCode, List<int> myPass) {
    for (int i = 0; i < myPass.length; i++) {
      if (enteredPassCode[i] != myPass[i]) {
        return false;
      }
    }
    return true;
  }
}
