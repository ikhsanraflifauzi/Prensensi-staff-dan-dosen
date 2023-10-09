import 'package:flutter/material.dart';
import 'package:flutter_lock_screen/flutter_lock_screen.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

import '../controllers/screenlock_controller.dart';

class ScreenlockView extends GetView<ScreenlockController> {
  const ScreenlockView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LockScreen(
      title: "This is Screet",
      passLength: controller.myPass.length,
      bgImage: "Assets/image/lock.jpg",
      fingerPrintImage: Image.asset(
        "Assets/image/White_fingeprint.png",
        height: 40,
        width: 40,
      ),
      showFingerPass: false,
      // fingerFunction: controller.biometrics,
      numColor: ColorConstants.darkClearBlue,
      // fingerVerify: controller.isFingerprint.value,
      borderColor: Colors.white,
      showWrongPassDialog: true,
      wrongPassContent: "Wrong pass please try again.",
      wrongPassTitle: "Opps!",
      wrongPassCancelButtonText: "Cancel",
      passCodeVerify: (passcode) async {
        for (int i = 0; i < controller.myPass.length; i++) {
          if (passcode[i] != controller.myPass[i]) {
            return false;
          }
        }
        return true;
      },
      onSuccess: () {
        Get.offAllNamed(Routes.LOGIN);
      },
    ));
  }
}
