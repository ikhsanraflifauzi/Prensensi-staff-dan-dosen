import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:circular_menu/circular_menu.dart';

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
          .where("Tanggal", isGreaterThan: start!.toIso8601String())
          .where("Tanggal", isLessThan: end.toIso8601String())
          .orderBy("tanggal")
          .get();
    }
  }

  void pickDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end = pickEnd;
    update();
  }
}
