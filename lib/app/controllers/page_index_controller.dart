import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';
import 'package:geolocator/geolocator.dart';

import '../Utils/Colors.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  void pagemove(int i) async {
    // pageIndex.value = i;
    switch (i) {
      case 1:
        pageIndex.value = i;
        Get.offAllNamed(Routes.PROFILE);
        break;
      case 2:
        pageIndex.value = i;
        Get.offAllNamed(Routes.IZIN_SAKIT);
        break;
      default:
        pageIndex.value = i;
        Get.offAllNamed(Routes.HOME);
    }
  }

  Future<void> updatePosition(Position position, String address) async {
    String uid = auth.currentUser!.uid;

    fireStore.collection("Employee").doc(uid).update({
      "Position": {
        "latitude": position.latitude,
        "longitude": position.longitude,
      },
      "alamat": address
    });
  }

  Future<void> onCheckout(
      Position position, String address, double jarak) async {
    String uid = auth.currentUser!.uid;
    DateTime dateTime = DateTime.now();
    String docPresensi = DateFormat.yMd().format(dateTime).replaceAll("/", "-");
    String jangkauan = "di luar area";
    String status = "Terlambat";
    TimeOfDay waktu = TimeOfDay(hour: 08, minute: 15);
    TimeOfDay waktu2 = TimeOfDay.now();
    TimeOfDay waktu3 = TimeOfDay(hour: 08, minute: 30);

    CollectionReference<Map<String, dynamic>> colPresensi =
        await fireStore.collection("Employee").doc(uid).collection("presensi");

    QuerySnapshot<Map<String, dynamic>> snapPresensi = await colPresensi.get();
    await colPresensi.doc(docPresensi).update({
      "check out": {
        "tanggal": dateTime.toIso8601String(),
        "alamat": address,
        "latitude": position.latitude,
        "longitude": position.longitude,
        "jangkauan": jangkauan
      }
    });
  }
}

Future<Map<String, dynamic>> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return {
        "message": "Izin aplikasi untuk menggunakan GPS di tolak",
        "error": true
      };
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return {
      "message":
          "Perangkat anda tidak mengizinkan menggunakan GPS, coba ubah di bagian Setting",
      "error": true
    };
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  Position position = await Geolocator.getCurrentPosition();
  return {
    "Position": position,
    "message": "Berhasil mendapatkan posisi device",
    "error": false
  };
}
