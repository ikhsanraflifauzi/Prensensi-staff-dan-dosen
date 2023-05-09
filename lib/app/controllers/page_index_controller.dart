import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';
import 'package:geolocator/geolocator.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  void pagemove(int i) async {
    // pageIndex.value = i;
    switch (i) {
      case 1:
        print("this is for presensce");
        Map<String, dynamic> dataResponse = await determinePosition();
        try {
          if (!dataResponse["error"]) {
            Position position = dataResponse["Position"];
            print(" ${position.latitude},${position.longitude} ");
            Get.snackbar(
                icon: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Image.asset(
                    ' Assets/icon/location.png',
                    width: 36,
                    height: 38,
                  ),
                ),
                "${dataResponse['message']}",
                "${position.latitude},${position.longitude}",
                backgroundColor: Colors.white);
          } else {
            Get.snackbar(
                icon: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Image.asset(
                    'Assets/icon/Warning icon.png',
                    width: 36,
                    height: 38,
                  ),
                ),
                ' Terjadi kesalahan',
                dataResponse["message"],
                backgroundColor: Colors.white);
          }
        } catch (e) {}

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
}
