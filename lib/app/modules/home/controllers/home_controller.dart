import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:protoype_t_a/app/modules/home/component/isiText.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.uid;
    yield* fireStore.collection('Employee').doc(uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamLastPresensi() async* {
    String uid = auth.currentUser!.uid;
    yield* fireStore
        .collection('Employee')
        .doc(uid)
        .collection("presensi")
        .orderBy("tanggal")
        .limitToLast(5)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamInfoPresensi() async* {
    String uid = auth.currentUser!.uid;
    String todayPresensi =
        DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");
    yield* fireStore
        .collection('Employee')
        .doc(uid)
        .collection("presensi")
        .doc(todayPresensi)
        .snapshots();
  }

  Future<void> updatePosition(
    Position position,
    String address,
  ) async {
    String uid = auth.currentUser!.uid;

    fireStore.collection("Employee").doc(uid).update({
      "Position": {
        "latitude": position.latitude,
        "longitude": position.longitude,
      },
      "alamat": address,
    });
  }

  Future<void> detallPresensi() async {
    try {
      Get.defaultDialog(
          title: "Detail Presensi",
          content: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: streamInfoPresensi(),
              builder: (context, detailPresensi) {
                Map<String, dynamic>? dataDetail = detailPresensi.data!.data();
                return Container(
                  width: 500,
                  height: 250,
                  color: Colors.white,
                  child: Column(children: [
                    Text('${DateFormat.yMMMEd().format(DateTime.now())}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DataText(
                            name: "jam",
                            value: dataDetail?["Check in"] == null
                                ? "-"
                                : '${DateFormat.Hms().format(DateTime.parse(dataDetail!["check in"]!["tanggal"]))}')
                      ],
                    )
                  ]),
                );
              }));
    } catch (e) {}
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

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
