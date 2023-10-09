import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/modules/Login/Component/primaryTextField.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.darkClearBlue,
        appBar: AppBar(
          title: const Text('Lupa Password',
              style:
                  TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w500)),
          centerTitle: true,
          backgroundColor: ColorConstants.darkClearBlue,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(
              height: 54,
            ),
            const Text(
              'email ',
              style: TextStyle(
                  fontFamily: 'Lexend', fontSize: 20, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            PrimaryTextfield(
              controller: controller.emailController,
              hintText: 'Masukkan email',
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.emailVerif();
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: ColorConstants.lightClearBlue),
                child: Text(
                  controller.isLoading.isFalse ? 'Verfikasi email' : 'Loding',
                  style: const TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
