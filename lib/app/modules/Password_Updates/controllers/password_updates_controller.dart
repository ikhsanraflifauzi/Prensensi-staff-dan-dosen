import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordUpdatesController extends GetxController {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmNewPassController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;
  RxBool passwordIsHidden = true.obs;
  Future<void> passwordUpdate() async {
    if (currentPasswordController.text.isNotEmpty &&
        newPassController.text.isNotEmpty &&
        confirmNewPassController.text.isNotEmpty) {
      isLoading.value = true;
      if (confirmNewPassController.text == newPassController.text) {
        try {
          String emailUser = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(
              email: emailUser, password: currentPasswordController.text);

          await auth.currentUser!.updatePassword(newPassController.text);

          Get.back();

          Get.snackbar(
              icon: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Image.asset(
                  'Assets/icon/check icon.png',
                  width: 36,
                  height: 38,
                ),
              ),
              'Berhasil',
              ' Kata sandi telah di ganti ',
              backgroundColor: Colors.white);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            Get.snackbar(
                icon: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Image.asset(
                    'Assets/icon/Failed Icon.png',
                    width: 36,
                    height: 38,
                  ),
                ),
                'Gagal',
                ' password lama yang anada masukkan salah',
                backgroundColor: Colors.white);
          } else {
            Get.snackbar(
                icon: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Image.asset(
                    'Assets/icon/Failed Icon.png',
                    width: 36,
                    height: 38,
                  ),
                ),
                'Gagal',
                e.code.toLowerCase(),
                backgroundColor: Colors.white);
          }
        }
      } else {}
    } else {}
  }
}
