import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

class DaftarController extends GetxController {
  TextEditingController nipC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController jabatanC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool passwordIsHidden = true.obs;
  RxBool isLoading = false.obs;

  String? roleselectedprogram, roleprogram;
  String? prodiselectedprogram, prodiprogram;
  RxBool errorInputProgram = false.obs;

  var roleitems = ['Admin', 'Employee', 'Dosen'];
  void setProgram(String? value) {
    switch (value) {
      case 'Admin':
        roleselectedprogram = 'Admin';
        break;
      case 'Employee':
        roleselectedprogram = 'Employee';
        break;
      case 'Dosen':
        roleselectedprogram = 'Dosen';
        break;
      default:
        roleselectedprogram = '-';
    }
    roleprogram = value;
    errorInputProgram.value = false;
    update();
  }

  var prodiitems = [
    'Manufaktur',
    'Mekatronika',
    'Teknik Elektro',
    'Teknologi Rekayasa Perangkat Lunak'
  ];
  void setProdiProgram(String? value) {
    switch (value) {
      case 'Manufaktur':
        prodiselectedprogram = 'Manufaktur';
        break;
      case 'Mekatronika':
        prodiselectedprogram = 'Mekatronika';
        break;
      case 'Teknik Elektro':
        prodiselectedprogram = 'Teknik Elektro';
        break;
      case 'Teknologi Rekayasa Perangkat Lunak':
        prodiselectedprogram = 'Teknologi Rekayasa Perangkat Lunak';
        break;
      default:
        prodiselectedprogram = '-';
    }
    prodiprogram = value;
    errorInputProgram.value = false;
    update();
  }

  void daftar() async {
    if (nipC.text.isNotEmpty &&
        namaC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        jabatanC.text.isNotEmpty &&
        passC.text.isNotEmpty &&
        roleitems.isNotEmpty &&
        prodiitems.isNotEmpty) {
      try {
        UserCredential credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );
        if (credential.user != null) {
          String uid = credential.user!.uid;
          await firestore.collection('Employee').doc(uid).set({
            "NIP": nipC.text,
            "Name": namaC.text,
            'Uid': uid,
            "createdAt": DateTime.now().toIso8601String(),
            'email': emailC.text,
            "jabatan": jabatanC.text,
            "prodi": prodiselectedprogram,
            "role": roleselectedprogram
          });
          Get.defaultDialog(
              title: "Berhasil",
              content: Column(
                children: [
                  Image.asset('Assets/icon/check icon.png'),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Akun Anda telah terdaftar, silahkan melakukan Login",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.offNamed(Routes.LOGIN);
                    },
                    child: const Text('Ok'))
              ]);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
        } else if (e.code == 'email-already-in-use') {}
      } catch (e) {
        Get.snackbar('Terjadi kesalahan', 'error application');
      }
    } else {
      Get.snackbar(
          'Terjadi kesalahan', 'error saat akan melakukan pendaftaran');
    }
  }
}
