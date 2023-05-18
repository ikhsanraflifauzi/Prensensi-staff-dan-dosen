import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../Utils/Colors.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  void pagemove(int i) async {
    // pageIndex.value = i;
    switch (i) {
      case 1:
        print("this is for presensce");
        Map<String, dynamic> dataResponse = await determinePosition();
        try {
          if (!dataResponse["error"]) {
            Position position = dataResponse["Position"];

            List<Placemark> placemarks = await placemarkFromCoordinates(
                position.latitude, position.longitude);
            String address =
                "${placemarks[0].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}";
            await updatePosition(position, address);
            // print(placemarks[0].street);
            double jarak = Geolocator.distanceBetween(
                -6.5540221, 107.4155447, position.latitude, position.longitude);

            await presensi(position, address, jarak);

            // Get.snackbar(
            //     icon: Padding(
            //       padding: const EdgeInsets.only(left: 15),
            //       child: Image.asset(
            //         'Assets/icon/location.png',
            //         width: 25,
            //         height: 25,
            //       ),
            //     ),
            //     "${dataResponse['message']}",
            //     address,
            //     backgroundColor: Colors.white);
          } else {
            Get.snackbar(
                icon: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Image.asset(
                    'Assets/icon/Warning icon.png',
                    width: 36,
                    height: 36,
                  ),
                ),
                ' Terjadi kesalahan',
                dataResponse["message"],
                backgroundColor: Colors.white);
          }
        } catch (e) {
          Get.snackbar(
              icon: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Image.asset(
                  'Assets/icon/Warning icon.png',
                  width: 36,
                  height: 36,
                ),
              ),
              ' Terjadi kesalahan',
              dataResponse["message"],
              backgroundColor: Colors.white);
        }

        break;

      case 2:
        pageIndex.value = i;
        Get.offAllNamed(Routes.PROFILE);
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

  Future<void> presensi(Position position, String address, double jarak) async {
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

    if (jarak <= 500) {
      print(jarak);
      jangkauan = "di dalam area";
      if (snapPresensi.docs.length == 0 && waktu == waktu2) {
        status = "Masuk";
        await colPresensi.doc(docPresensi).set({
          "tanggal": dateTime.toIso8601String(),
          "check in": {
            "tanggal": dateTime.toIso8601String(),
            "alamat": address,
            "latitude": position.latitude,
            "longitude": position.longitude,
            "status": status,
            "jangkauan": jangkauan
          }
        });
      } else if (snapPresensi.docs.length == 0 && waktu3 == waktu2) {
        status = "Terlambat";
        await colPresensi.doc(docPresensi).set({
          "tanggal": dateTime.toIso8601String(),
          "check in": {
            "tanggal": dateTime.toIso8601String(),
            "alamat": address,
            "latitude": position.latitude,
            "longitude": position.longitude,
            "status": status,
            "jangkauan": jangkauan
          }
        });
      } else {
        DocumentSnapshot<Map<String, dynamic>> todayPresensi =
            await colPresensi.doc(docPresensi).get();

        if (todayPresensi.exists == true) {
          Map<String, dynamic>? dataTodayPresensi = todayPresensi.data();
          if (dataTodayPresensi?["check out"] != null) {
            Get.defaultDialog(
                title: 'Pemberitahuan',
                titleStyle: TextStyle(fontFamily: 'Lexend'),
                middleText:
                    'Anda sudah melakukan presensi hari ini, silakhan lakukan lakukan presensi besok ',
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
        } else {
          await colPresensi.doc(docPresensi).set({
            "tanggal": dateTime.toIso8601String(),
            "check in": {
              "tanggal": dateTime.toIso8601String(),
              "alamat": address,
              "latitude": position.latitude,
              "longitude": position.longitude,
              "status": status,
              "jangkauan": jangkauan
            }
          });
        }
      }
    } else {
      print(jarak);
      jangkauan = "di luar area";
      Get.defaultDialog(
          content: Column(
            children: [
              Image.asset('Assets/icon/Warning icon.png'),
              Text(
                'anda berada di luar jangkauan area presnsi',
                textAlign: TextAlign.center,
              )
            ],
          ),
          title: 'Terjadi Kesalahan',
          backgroundColor: Colors.white,
          actions: [
            TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'kembali',
                  style: TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 18,
                      color: ColorConstants.darkClearBlue),
                ))
          ]);
    }
    ;
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
