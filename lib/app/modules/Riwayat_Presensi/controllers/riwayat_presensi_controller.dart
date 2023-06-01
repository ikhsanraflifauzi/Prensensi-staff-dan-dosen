import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_navigation_menu/simple_navigation_menu.dart';

class RiwayatPresensiController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllPresensi() async* {
    String uid = auth.currentUser!.uid;
    yield* fireStore
        .collection('Employee')
        .doc(uid)
        .collection("presensi")
        .orderBy("tanggal")
        .snapshots();
  }
}
