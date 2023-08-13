import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

import '../../../Utils/Colors.dart';

class SuratKeluarController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController pass = TextEditingController();

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamInfoGetPass() async* {
    String uid = auth.currentUser!.uid;
    String forGetPass =
        DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");
    yield* firestore
        .collection('Employee')
        .doc(uid)
        .collection("GetPass")
        .doc(forGetPass)
        .snapshots();
  }

  Future<void> getPass() async {
    String uid = auth.currentUser!.uid;
    String statusGetPass = "Di luar Kantor";

    DateTime dateTime = DateTime.now();
    String docGetPass = DateFormat.yMd().format(dateTime).replaceAll("/", "-");

    CollectionReference<Map<String, dynamic>> colGetPass =
        await firestore.collection("Employee").doc(uid).collection("GetPass");

    QuerySnapshot<Map<String, dynamic>> snapGetPass = await colGetPass.get();
    DocumentSnapshot<Map<String, dynamic>> todayGetPass =
        await colGetPass.doc(docGetPass).get();

    try {
      if (pass.text.isNotEmpty && snapGetPass.docs.length == 0) {
        statusGetPass;
        await colGetPass.doc(docGetPass).set({
          "Tanggal": dateTime.toIso8601String(),
          "GetPass": {
            "Tanggal": dateTime.toIso8601String(),
            "Alasan": pass.text,
            "Status": statusGetPass
          }
        });
      }
      if (pass.text.isEmpty) {
        Get.snackbar('Peringatan', 'text area harus di isi',
            backgroundColor: Colors.white);
      } else {
        DocumentSnapshot<Map<String, dynamic>> todayGetPass =
            await colGetPass.doc(docGetPass).get();
        if (todayGetPass.exists == true) {
          Map<String, dynamic>? dataTodayGetPass = todayGetPass.data();
          if (dataTodayGetPass?["GetBack"] != null) {
            Get.defaultDialog(
                title: 'Pemberitahuan',
                titleStyle: TextStyle(fontFamily: 'Lexend'),
                middleText: 'Anda sudah melakukan GetPass hari ini',
                middleTextStyle: TextStyle(
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
          } else {
            statusGetPass = "kembali ke Kantor";
            await colGetPass.doc(docGetPass).update({
              "Tanggal": dateTime.toIso8601String(),
              "GetBack": {
                "Tanggal": dateTime.toIso8601String(),
                "Status": statusGetPass
              }
            });
            Get.snackbar("Pemberitahuan",
                " Anda telah melakukan konfrmasi untuk kembali ke kantor",
                backgroundColor: Colors.white);
          }

          //
        } else {
          await colGetPass.doc(docGetPass).set({
            "Tanggal": dateTime.toIso8601String(),
            "GetPass": {
              "Tanggal": dateTime.toIso8601String(),
              "Alasan": pass.text,
              "Status": statusGetPass
            }
          });
          Get.defaultDialog(
              title: "Berhasil",
              content: Column(
                children: [
                  Image.asset('Assets/icon/check icon.png'),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "anda telah melakukan Get pass, anda dapat meninggalkan kantor untuk sementara",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.offNamed(Routes.ADD_EMPLOYEE);
                    },
                    child: Text('Ok'))
              ]);
        }
      }
    } catch (e) {
      Get.defaultDialog(
          title: " Terjadi kesalahan",
          middleText: " aplikasi tidak dapat merespon ");
    }
  }
}
