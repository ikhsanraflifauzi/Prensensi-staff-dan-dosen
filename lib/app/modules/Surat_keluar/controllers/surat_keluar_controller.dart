import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SuratKeluarController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController pass = TextEditingController();

  Future<void> getPass() async {
    String uid = auth.currentUser!.uid;
    DateTime dateTime = DateTime.now();
    String docGetPass = DateFormat.yMd().format(dateTime).replaceAll("/", "-");

    CollectionReference<Map<String, dynamic>> colGetPass =
        await firestore.collection("Employee").doc(uid).collection("GetPass");

    QuerySnapshot<Map<String, dynamic>> snapGetPass = await colGetPass.get();

    try {
      if (snapGetPass.docs.length == 0) {
        await colGetPass
            .doc(docGetPass)
            .set({"Tanggal": dateTime.toIso8601String(), "Alasan": pass.text});
        Get.snackbar(
            " berhasil", "anda dapat meninggalkan tempat kerja sementara",
            backgroundColor: Colors.white);
      } else {
        Get.snackbar("terjadi kesalahan", "tidak dapat melakukan get pass");
      }
    } catch (e) {}
  }
}
