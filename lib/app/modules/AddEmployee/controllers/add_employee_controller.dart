import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class AddEmployeeController extends GetxController {
  TextEditingController nipController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordAdminController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;
  RxBool errorInputProgram = false.obs;

  String? selectedprogram, program;

  var items = ['admin', 'employee'];
  void setProgram(String? value) {
    switch (value) {
      case 'admin':
        selectedprogram = 'admin';
        break;
      case 'employee':
        selectedprogram = 'employee';
        break;
      default:
        selectedprogram = '';
    }
    program = value;
    errorInputProgram.value = false;
    update();
  }

  Future<void> processAddEmploye() async {
    if (passwordAdminController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        String emailAdmin = auth.currentUser!.email!;

        UserCredential adminCredential = await auth.signInWithEmailAndPassword(
          email: emailAdmin,
          password: passwordAdminController.text,
        );

        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: 'Politeknik Enjinering Indorama',
        );
        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;

          fireStore.collection('Employee').doc(uid).set({
            "NIP": nipController.text,
            "Name": nameController.text,
            "email": emailController.text,
            "role": selectedprogram,
            "createAT": DateTime.now().toIso8601String(),
            "Uid": uid,
          });
          await userCredential.user!.sendEmailVerification();

          await auth.signOut();

          UserCredential adminCredential =
              await auth.signInWithEmailAndPassword(
            email: emailAdmin,
            password: passwordAdminController.text,
          );
          Get.back();
          Get.back();
          isLoading.value = false;
          Get.snackbar(
              icon: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Image.asset(
                  'Assets/icon/check icon.png',
                  width: 36,
                  height: 38,
                ),
              ),
              'Behasil',
              ' Akun user telah di tambahkan',
              backgroundColor: Colors.white);
        }
        print(userCredential);
      } on FirebaseAuthException catch (e) {
        if (selectedprogram == null) {
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
              "Terjadi kesalahan",
              "Pilih role user terlebih dahulu",
              backgroundColor: Colors.white);
        } else if (e.code == 'email-already-in-use') {
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
              "Terjadi kesalahan",
              "email yang anda gunakan telah terdaftar",
              backgroundColor: Colors.white);
        }
      } catch (e) {
        Get.snackbar(
            icon: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Image.asset(
                'Assets/icon/Failed Icon.png',
                width: 36,
                height: 38,
              ),
            ),
            "Terjadi kesalahan",
            "tidak dapat menambahkan user");
      }
    } else {
      Get.snackbar(
          icon: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Image.asset(
              'Assets/icon/Warning icon.png',
              width: 36,
              height: 38,
            ),
          ),
          'Terjadi kesalahan',
          "masukkan password admin terlebih dahulu",
          backgroundColor: Colors.white);
    }
  }

  Future<void> addEmploye() async {
    if (nipController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        items.isNotEmpty) {
      Get.defaultDialog(
          title: "validasi admin",
          content: Column(
            children: [
              Text(
                'masukkan password untuk validasi admin',
                style: TextStyle(
                    fontFamily: 'Lexend', fontWeight: FontWeight.w500),
              ),
              TextField(
                controller: passwordAdminController,
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'batal',
                style: TextStyle(
                    fontFamily: 'Lexend', fontWeight: FontWeight.w500),
              ),
            ),
            Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (isLoading.isFalse) {
                    await processAddEmploye();
                  }
                  isLoading.value = false;
                },
                child: Text(
                  isLoading.isFalse ? 'Ok' : 'Loading',
                  style: TextStyle(
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            )
          ]);
      //
    } else {
      Get.snackbar(
          icon: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Image.asset(
              'Assets/icon/Warning icon.png',
              width: 36,
              height: 38,
            ),
          ),
          "Terjadi kesalahan",
          "NIP,nama, dan email tidak bolleh kosong",
          backgroundColor: Colors.white);
    }
  }
}
