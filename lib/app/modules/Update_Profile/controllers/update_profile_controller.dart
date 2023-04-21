import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as photoStorage;

class UpdateProfileController extends GetxController {
  TextEditingController nipController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool readOnly = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  photoStorage.FirebaseStorage storage = photoStorage.FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();
  XFile? image;

  void imagepic() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image!.name);
      print(image!.name.split(" . ").last);
      print(image!.path);
    } else {
      print(image);
    }
    update();
  }

  Future<void> updateProfile(String uid) async {
    if (nipController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {"Name": nameController.text};
        if (image != null) {
          String extenPic = image!.name.split(" . ").last;
          File file = File(image!.path);

          await storage.ref("$uid/profile.$extenPic").putFile(file);
          String urlImage =
              await storage.ref("$uid/profile.$extenPic").getDownloadURL();
          data.addAll({"profile": urlImage});
        }
        await firestore.collection('Employee').doc(uid).update(data);
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

  Future<void> deletepic(String uid) async {
    try {
      await firestore
          .collection("Employee")
          .doc(uid)
          .update({"profile": FieldValue.delete()});
      Get.back();
      Get.back();
    } catch (e) {
      Get.snackbar('Gagal', 'Foto tidak terhapus');
    }
  }

  // Future<void> clearStorge(String uid) async {
  //   try {
  //     String extenPic = image!.name.split(" . ").last;
  //     File file = File(image!.path);
  //     // final desertRef = storage.ref().child("$uid/profile.$extenPic");
  //     await storage.ref("$uid/proflie.$extenPic").delete();
  //     Get.snackbar(
  //         icon: Padding(
  //           padding: const EdgeInsets.only(left: 15),
  //           child: Image.asset(
  //             'Assets/icon/check icon.png',
  //             width: 36,
  //             height: 38,
  //           ),
  //         ),
  //         'Berhasil',
  //         ' penyimpanan berbhasil di bersihkan',
  //         backgroundColor: Colors.white);
  //   } catch (e) {
  //     Get.snackbar('Gagal', 'penyimpanan tidak terbersihkan');
  //   }
  // }
}
