import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';
import 'package:local_auth/local_auth.dart';

import '../controllers/finger_auth_controller.dart';

class FingerAuthView extends GetView<FingerAuthController> {
  const FingerAuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.darkClearBlue,
      body: Center(
          child: GestureDetector(
        onTap: () {
          Get.offAllNamed(Routes.HOME);
        },
        child: SizedBox(
            child: Image.asset(
          'Assets/image/White_fingeprint.png',
          width: 97,
          height: 97,
        )),
      )),
    );
  }
}
