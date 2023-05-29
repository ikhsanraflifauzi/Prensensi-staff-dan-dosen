import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class IzinSakitController extends GetxController {
 TextEditingController nameController = TextEditingController();


  final ImagePicker picker = ImagePicker();
  final FilePicker filePic = FilePicker.platform;
  XFile? filePicker;
  XFile? image;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

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

  Future<void> uploadImage(String uid) async {
    if () {
      
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
        
      }
    }
  }
}
