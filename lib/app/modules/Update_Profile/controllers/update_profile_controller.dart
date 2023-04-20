import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  TextEditingController nipController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  RxBool isLoading = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateProfile(String uid) async {
    isLoading.value = true;
    if (nipController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      try {
        await firestore
            .collection('Employee')
            .doc(uid)
            .update({"Name": nameController.text});
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
            'ata diri kamu telah terupdate',
            backgroundColor: Colors.white);
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
            'Gagal',
            ' Data diri kamu tidak terudapte',
            backgroundColor: Colors.white);
      } finally {
        isLoading.value = true;
      }
    }
  }
}
