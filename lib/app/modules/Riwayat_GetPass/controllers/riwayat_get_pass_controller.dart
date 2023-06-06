import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RiwayatGetPassController extends GetxController {
  DateTime? start;
  DateTime end = DateTime.now();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Future<QuerySnapshot<Map<String, dynamic>>> getAllGetPass() async {
    String uid = auth.currentUser!.uid;

    if (start == null) {
      return await fireStore
          .collection('Employee')
          .doc(uid)
          .collection("GetPass")
          .where("Tanggal", isLessThan: end.toIso8601String())
          .orderBy("Tanggal")
          .get();
    } else {
      return await fireStore
          .collection('Employee')
          .doc(uid)
          .collection("GetPass")
          .where("Tanggal", isGreaterThan: start!.toIso8601String())
          .where("Tanggal", isLessThan: end.toIso8601String())
          .orderBy("Tanggal")
          .get();
    }
  }

  void pickDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end = pickEnd;
    update();
  }
}
