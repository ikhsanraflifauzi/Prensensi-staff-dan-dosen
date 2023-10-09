import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/modules/Login/Component/primaryTextField.dart';

import '../controllers/password_updates_controller.dart';

class PasswordUpdatesView extends GetView<PasswordUpdatesController> {
  const PasswordUpdatesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            ' Update Password ',
            style: TextStyle(fontFamily: 'Lexend'),
          ),
          centerTitle: true,
          backgroundColor: ColorConstants.darkClearBlue,
        ),
        backgroundColor: ColorConstants.whitegray,
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(
              height: 54,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: PrimaryTextfield(
                controller: controller.currentPasswordController,
                labelText: 'kata sandi saat ini',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(12),
                child: PrimaryTextfield(
                  controller: controller.newPassController,
                  hintText: 'masukkan kata sandi baru',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'masukkan kata sandi baru';
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
            const SizedBox(
              height: 12,
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(12),
                child: PrimaryTextfield(
                  controller: controller.confirmNewPassController,
                  hintText: 'Konfirmasi kata sandi',
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
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: 320,
                height: 47,
                child: Obx(
                  () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.lightClearBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          await controller.passwordUpdate();
                        }
                      },
                      child: Text(
                        controller.isLoading.isFalse
                            ? "Ganti Sandi"
                            : const CircularProgressIndicator().toString(),
                        style:
                            const TextStyle(fontFamily: 'Lexend', fontSize: 15),
                      )),
                ),
              ),
            ),
          ],
        ));
  }
}
