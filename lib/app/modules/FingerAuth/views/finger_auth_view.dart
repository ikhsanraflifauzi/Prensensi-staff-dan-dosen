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
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(
              height: 54,
            ),
            SizedBox(
                child: Image.asset(
              'Assets/image/peiPutih.png',
              width: 93,
              height: 96,
            )),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(19),
                child: const Text(
                  'Aplikasi Presensi',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Lexend',
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              width: 300,
              height: 60,
              child: Row(
                children: [
                  Obx(() => controller.fingerPrint.value
                      ? Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.cancel,
                          color: Colors.red,
                        )),
                  SizedBox(
                    width: 8,
                  ),
                  Text('FingerPrint auth'),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              width: 300,
              height: 60,
              child: Row(
                children: [
                  Obx(() => controller.faceAuth.value
                      ? Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.cancel,
                          color: Colors.red,
                        )),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Face auth'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 100,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  controller.authenticated();
                },
                child: Text(
                  'heeelo',
                  // controller.isLoading.isFalse ? "Login" : "Loading",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Lexend',
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: ColorConstants.lightClearBlue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextButton(
                onPressed: () {
                  Get.toNamed(Routes.FORGOT_PASSWORD);
                },
                child: const Text(
                  'Lupa password ?',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Lexend',
                      color: Colors.yellow,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ));
  }
}
