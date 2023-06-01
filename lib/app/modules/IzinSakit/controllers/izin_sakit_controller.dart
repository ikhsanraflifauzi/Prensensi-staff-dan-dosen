import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class IzinSakitController extends GetxController {
  TextEditingController nameController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  final FilePicker filePic = FilePicker.platform;
  XFile? filePicker;
  XFile? image;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  String? selectedprogram, program;
  RxBool errorInputProgram = false.obs;

  var items = ['Izin', 'Sakit'];
  void setProgram(String? value) {
    switch (value) {
      case 'Izin':
        selectedprogram = 'Izin';
        break;
      case 'Sakit':
        selectedprogram = 'Sakit';
        break;
      default:
        selectedprogram = '';
    }
    program = value;
    errorInputProgram.value = false;
    update();
  }

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

  Future<void> uploadImage() async {
    String uid = auth.currentUser!.uid;
    DateTime dateTime = DateTime.now();
    String docAbsen = DateFormat.yMd().format(dateTime).replaceAll("/", "-");
    CollectionReference<Map<String, dynamic>> colAbsen =
        await firestore.collection("Employee").doc(uid).collection("Absen");
    if (items.isNotEmpty) {
      try {
        Map<String, dynamic> data = {"Name": nameController.text};
        if (image != null) {
          String extenPic = image!.name.split(" . ").last;
          File file = File(image!.path);

          await storage.ref("$uid/fotoSurat.$extenPic").putFile(file);
          String urlImage =
              await storage.ref("$uid/fotoSurat.$extenPic").getDownloadURL();
          data.addAll({"fotoSurat": urlImage});
          await colAbsen.doc(docAbsen).set({
            "Tanggal": dateTime.toIso8601String(),
            "Absen": {
              "Tanggal": dateTime.toIso8601String(),
              "Keterangan": selectedprogram,
              "fotoSurat": urlImage
            }
          });
        }
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
            'foto berhasil di upload',
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
            ' foto  tidak terupload',
            backgroundColor: Colors.white);
      } finally {}
    }
  }
}
