// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

class GetPassLandingController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
        firestore.collection("Employee").doc(uid).collection("GetPass");

    try {
      statusGetPass = "kembali ke Kantor";
      await colGetPass.doc(docGetPass).update({
        "Tanggal": dateTime.toIso8601String(),
        "GetBack": {
          "Tanggal": dateTime.toIso8601String(),
          "Status": statusGetPass
        }
      });
      Get.offNamed(Routes.RIWAYAT_GET_PASS);
    } catch (e) {
      Get.defaultDialog(
          title: " Terjadi kesalahan",
          middleText: " aplikasi tidak dapat merespon ");
    }
  }
}
