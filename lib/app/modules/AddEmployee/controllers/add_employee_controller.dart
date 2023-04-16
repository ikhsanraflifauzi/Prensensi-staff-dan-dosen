import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddEmployeeController extends GetxController {
  TextEditingController nipController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordAdminController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> processAddEmploye() async {
    if (passwordAdminController.text.isNotEmpty) {
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

          fireStore
            ..collection('Employee').doc(uid).set({
              "NIP": nipController.text,
              "Name": nameController.text,
              "email": emailController.text,
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
          Get.snackbar('Behasil', 'Berhasil menambahkan user');
        }
        print(userCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar(
              "Terjadi kesalahan", "Password yang digunakan terlalu lemah");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar(
              "Terjadi kesalahan", "email yang anda gunakan telah terdaftar");
        }
      } catch (e) {
        Get.snackbar("Terjadi kesalahan", "tidak dapat menambahkan user");
      }
    } else {
      Get.snackbar(
          'Terjadi kesalahan', "masukkan password admin terlebih dahulu",
          backgroundColor: Colors.white);
    }
  }

  void addEmploye() async {
    if (nipController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
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
            ElevatedButton(
              onPressed: () async {
                await processAddEmploye();
              },
              child: Text(
                'Ok',
                style: TextStyle(
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            )
          ]);
      //
    } else {
      Get.snackbar(
          "Terjadi kesalahan", "NIP,nama, dan email tidak bolleh kosong");
    }
  }
}
