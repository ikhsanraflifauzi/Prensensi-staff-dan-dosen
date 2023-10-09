import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();

  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> emailVerif() async {
    if (emailController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailController.text);
        Get.snackbar('berhasil', 'email untuk ganti password telah terkirim',
            backgroundColor: Colors.white);
      } on FirebaseException {
        Get.snackbar(
            ' Terjadi Kesalahan', 'email untuk ganti password tidak terkirim',
            backgroundColor: Colors.red.shade600);
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> resetPassword() async {}
}
