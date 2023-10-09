import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';
import 'package:local_auth/local_auth.dart';

class LoginController extends GetxController {
  final getStorge = GetStorage();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  RxBool passwordIsHidden = true.obs;
  RxBool isLoading = false.obs;
  RxBool errorInputProgram = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  final _localAuth = LocalAuthentication();
  var fingerPrint = false.obs;
  var faceAuth = false.obs;
  var userAuth = false.obs;

  void getBiometrics() async {
    bool hasLoacalAuth = await _localAuth.canCheckBiometrics;

    if (hasLoacalAuth) {
      List<BiometricType> availableBiometrics =
          await _localAuth.getAvailableBiometrics();
      faceAuth.value = availableBiometrics.contains(BiometricType.face);
      fingerPrint.value =
          availableBiometrics.contains(BiometricType.fingerprint);
    } else {
      Get.defaultDialog(
          title: 'Error',
          middleText: 'tidak dapat menggunakan fitur pada device');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getBiometrics();
  }

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
              Get.offAllNamed(Routes.FORGOT_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            isLoading.value = true;
            Get.defaultDialog(
                content: Column(
                  children: [
                    Image.asset(
                      'Assets/image/emailverif.jpg',
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Email Anda belum di verifikasi',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                title: 'Pemberitahuan',
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
                            icon: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Image.asset(
                                'Assets/icon/check icon.png',
                                width: 36,
                                height: 38,
                              ),
                            ),
                            'Berhasil',
                            ' verifikasi email telah terkirim',
                            backgroundColor: Colors.white);
                        isLoading.value = false;
                      } catch (e) {
                        isLoading.value = false;
                        Get.snackbar(
                            icon: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Image.asset(
                                'Assets/icon/Warning icon.png',
                                width: 36,
                                height: 38,
                              ),
                            ),
                            'Gagal',
                            ' verifikasi email tidak terkirim',
                            backgroundColor: Colors.white);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.darkClearBlue),
                    child: const Text(
                      'Kirim ulang',
                      style:
                          TextStyle(fontFamily: 'Lexend', color: Colors.white),
                    ),
                  )
                ]);
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          isLoading.value = false;
          Get.defaultDialog(
              title: 'Terjadi Kesalahan',
              titleStyle: const TextStyle(fontFamily: 'Lexend'),
              middleText: 'email tidak valid',
              middleTextStyle: const TextStyle(
                  fontFamily: 'Lexend', fontWeight: FontWeight.w500),
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
        } else if (e.code == 'wrong-password') {
          Get.defaultDialog(
              content: Column(
                children: [
                  Image.asset('Assets/icon/Failed Icon.png'),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'password anda salah',
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              title: 'Terjadi Kesalahan',
              titleStyle: const TextStyle(fontFamily: 'Lexend'),
              middleText: 'password anda salah',
              middleTextStyle: const TextStyle(
                  fontFamily: 'Lexend', fontWeight: FontWeight.w500),
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
          isLoading.value = false;
        }
      }
    } else {
      Get.defaultDialog(
          content: Column(
            children: [
              Image.asset('Assets/icon/Warning icon.png'),
              const Text(
                'email dan password yang anda masukkan tidak valid',
                textAlign: TextAlign.center,
              )
            ],
          ),
          title: 'Terjadi Kesalahan',
          backgroundColor: Colors.white,
          actions: [
            TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'kembali',
                  style: TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 18,
                      color: ColorConstants.darkClearBlue),
                ))
          ]);
    }
  }
}
