import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final getStorge = GetStorage();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  RxBool passwordHidden = true.obs;
  RxBool isLoading = false.obs;
  RxBool errorInputProgram = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  @override
  Future<void> login() async {
    if (emailController.text.isNotEmpty && passController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: emailController.text, password: passController.text);
        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            isLoading.value = false;
            if (passController.text == "Politeknik Enjinering Indorama") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            isLoading.value = true;
            Get.defaultDialog(
                title: 'Pemberitahuan',
                middleText: 'Email Anda belum di verifikasi',
                actions: [
                  OutlinedButton(
                      onPressed: () {
                        isLoading.value = false;
                        Get.back();
                      },
                      child: Text(
                        'batal',
                        style: TextStyle(
                            fontFamily: 'Lexend',
                            color: ColorConstants.darkClearBlue),
                      )),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await userCredential.user!.sendEmailVerification();
                        Get.back();
                        Get.snackbar(
                          'Berhasil',
                          ' verifikasi email telah terkirim',
                        );
                        isLoading.value = false;
                      } catch (e) {
                        isLoading.value = false;
                        Get.snackbar(
                            'Gagal', ' verifikasi email tidak terkirim');
                      }
                    },
                    child: Text(
                      'Kirim ulang',
                      style:
                          TextStyle(fontFamily: 'Lexend', color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.darkClearBlue),
                  )
                ]);
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.defaultDialog(
              title: 'Terjadi Kesalahan',
              titleStyle: TextStyle(fontFamily: 'Lexend'),
              middleText: 'email tidak valid',
              middleTextStyle:
                  TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w500),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Kembali',
                      style: TextStyle(
                          fontFamily: 'Lexend',
                          color: ColorConstants.darkClearBlue),
                    ))
              ]);
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          Get.defaultDialog(
              title: 'Terjadi Kesalahan',
              titleStyle: TextStyle(fontFamily: 'Lexend'),
              middleText: 'password anda salah',
              middleTextStyle:
                  TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w500),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Kembali',
                      style: TextStyle(
                          fontFamily: 'Lexend',
                          color: ColorConstants.darkClearBlue),
                    ))
              ]);
        }
      }
    } else {
      Get.defaultDialog(
          title: 'Terjadi Kesalahan',
          middleText: 'email dan password yang anda masukkan tidak valid',
          onCancel: () => Get.back(),
          backgroundColor: Colors.white);
    }
  }
}
