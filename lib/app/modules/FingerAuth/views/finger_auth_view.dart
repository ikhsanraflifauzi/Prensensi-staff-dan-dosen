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
              height: 100,
            ),
            IconButton(
                color: Colors.white,
                onPressed: () => controller.authenticated(),
                icon: Icon(
                  Icons.fingerprint,
                  size: 100,
                )),
          ],
        ));
  }
}
