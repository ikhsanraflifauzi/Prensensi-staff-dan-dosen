import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GetpassviewController extends GetxController {
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

    Future<void> getBackPass() async {
      String uid = auth.currentUser!.uid;
      String statusGetPass = "Di luar Kantor";

      DateTime dateTime = DateTime.now();
      String docGetPass =
          DateFormat.yMd().format(dateTime).replaceAll("/", "-");

      CollectionReference<Map<String, dynamic>> colGetPass =
          await firestore.collection("Employee").doc(uid).collection("GetPass");

      QuerySnapshot<Map<String, dynamic>> snapGetPass = await colGetPass.get();
      DocumentSnapshot<Map<String, dynamic>> todayGetPass =
          await colGetPass.doc(docGetPass).get();

      try {
        statusGetPass = "kembali ke Kantor";
        await colGetPass.doc(docGetPass).update({
          "Tanggal": dateTime.toIso8601String(),
          "GetBack": {
            "Tanggal": dateTime.toIso8601String(),
            "Status": statusGetPass
          }
        });
      } catch (e) {
        Get.defaultDialog(
            title: " Terjadi kesalahan",
            middleText: " aplikasi tidak dapat merespon ");
      }
    }
  }
}
