import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RiwayatPresensiController extends GetxController {
  DateTime? start;
  DateTime end = DateTime.now();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getAllPresensi() async {
    String uid = auth.currentUser!.uid;

    if (start == null) {
      return await fireStore
          .collection('Employee')
          .doc(uid)
          .collection("presensi")
          .where("tanggal", isLessThan: end.toIso8601String())
          .orderBy("tanggal")
          .get();
    } else {
      return await fireStore
          .collection('Employee')
          .doc(uid)
          .collection("presensi")
          .where("tanggal", isGreaterThan: start!.toIso8601String())
          .where("tanggal", isLessThan: end.toIso8601String())
          .orderBy("tanggal")
          .get();
    }
  }

  void pickDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end = pickEnd;
    update();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.uid;
    yield* fireStore.collection('Employee').doc(uid).snapshots();
  }
}
