import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/modules/Login/Component/primaryTextField.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
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
            const Text(
              'Login',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lexend',
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                  child: PrimaryTextfield(
                controller: controller.emailController,
                hintText: 'Masukkan email',
                keyboardType: TextInputType.emailAddress,
              )),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(12),
                child: PrimaryTextfield(
                  controller: controller.passController,
                  hintText: 'masukkan kata sandi',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'masukkan kata sandi anda';
                    }
                    return null;
                  },
                  obscureText: controller.passwordIsHidden.value,
                  suffixIcon: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        controller.passwordIsHidden.toggle();
                      },
                      icon: controller.passwordIsHidden.value == true
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              width: 100,
              height: 50,
              child: Obx(
                () => ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      await controller.login();
                    }
                  },
                  child: Text(
                    controller.isLoading.isFalse ? "Login" : "Loading",
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
