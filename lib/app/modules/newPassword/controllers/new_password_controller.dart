import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController newPasswordController = TextEditingController();

  void newPassword() async {
    try {
      String userEmail = auth.currentUser!.email!;
      if (newPasswordController.text.isNotEmpty) {
        auth.currentUser!.updatePassword(newPasswordController.text);
        await auth.signOut();
        Get.offAllNamed(Routes.LOGIN);
      }
    } on FirebaseException catch (e) {
      if (e.code == 'weak-passord') {
        Get.snackbar('Peringatan',
            'passwor terlalu lemah/penedek, masukkan minimal 6 karakter ');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.snackbar('Terjadi Kesalahan', 'password anda salah');
      }
    }
  }
}
