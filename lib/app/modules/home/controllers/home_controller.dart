import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

import '../../../Utils/Colors.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  TextEditingController kegC = TextEditingController();
  TextEditingController izinC = TextEditingController();

  void onCheckIn(context) async {
    try {
      Map<String, dynamic> dataResponse = await determinePosition();

      try {
        if (!dataResponse["error"]) {
          Position position = dataResponse["Position"];

          List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);
          String address =
              "${placemarks[0].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}";
          await updatePosition(position, address);

          double jarak = Geolocator.distanceBetween(
              -6.5540221, 107.4155447, position.latitude, position.longitude);

          await checkIn(position, address, jarak);
          isLoading.isFalse;
        } else {
          // Hide loading indicator
          isLoading.isFalse;

          // Dismiss the loading dialog

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
              'hanya mendapatkan lokasi',
              backgroundColor: Colors.white);
        }
      } catch (e) {
        // Hide loading indicator
        isLoading.isFalse;

        // Dismiss the loading dialog

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
            'device hanya mendeteksi lokasi',
            backgroundColor: Colors.white);
      }
    } catch (e) {
      // Hide loading indicator
      isLoading.isFalse;

      // Dismiss the loading dialog

      Get.snackbar("terjadi kesalahan", "tidak dapat check in");
    }
  }

  void onCheckOut() async {
    try {
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

          await checkOut(position, address, jarak);
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
            'Hanya mendapatkan lokasi , tidak bisa check in',
            backgroundColor: Colors.white);
      }
    } catch (e) {
      Get.snackbar(
          'terjadi kesalahan', 'error plikasi tidak dapat memuat perintah',
          backgroundColor: Colors.white);
    }
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

  Future<void> checkIn(Position position, String address, double jarak) async {
    String uid = auth.currentUser!.uid;
    TimeOfDay timeOfDay = TimeOfDay.now();
    DateTime now = DateTime.now();

    String jangkauan = "di luar area";
    String status = "Terlambat";
    DocumentReference<Map<String, dynamic>> timeref =
        fireStore.collection('TimePic').doc('waktu_masuk');
    DocumentSnapshot getmasuk = await timeref.get();
    String waktuString = getmasuk.get('masuk');
    List<String> waktuParts = waktuString.split(':');
    int jam = int.parse(waktuParts[0]);
    int menit = int.parse(waktuParts[1]);

    TimeOfDay waktuMasuk = TimeOfDay(hour: jam, minute: menit);
    DateTime waktuBefore = DateTime(
        now.year, now.month, now.day, waktuMasuk.hour, waktuMasuk.minute);

    CollectionReference<Map<String, dynamic>> colPresensi =
        fireStore.collection("Employee").doc(uid).collection("presensi");
    QuerySnapshot<Map<String, dynamic>> snapPresensi = await colPresensi.get();
    DateTime dateTime = DateTime.now();

    String docPresensi = DateFormat.yMd().format(dateTime).replaceAll("/", "-");
    // if (jarak <= 500) {
    jangkauan = "di dalam area";
    if (snapPresensi.docs.isEmpty) {
      Get.defaultDialog(
          title: "Kegiatan",
          content: Column(
            children: [
              TextField(
                controller: kegC,
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  status = "Masuk";
                  await colPresensi.doc(docPresensi).set({
                    "tanggal": dateTime.toIso8601String(),
                    "check in": {
                      "tanggal": dateTime.toIso8601String(),
                      "alamat": address,
                      "latitude": position.latitude,
                      "longitude": position.longitude,
                      "kegiatan": kegC.text,
                      "status": status,
                      "jangkauan": jangkauan
                    }
                  });
                  Get.back();
                  Get.snackbar(
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Image.asset(
                          'Assets/icon/check icon.png',
                          width: 36,
                          height: 38,
                        ),
                      ),
                      'Berhasil',
                      'Anda telah melakukan presensi',
                      backgroundColor: Colors.white);
                },
                child: const Text('Ok')),
          ]);
    } else {
      DocumentSnapshot<Map<String, dynamic>> todayPresensi =
          await colPresensi.doc(docPresensi).get();

      if (todayPresensi.exists == true) {
        Map<String, dynamic>? dataTodayPresensi = todayPresensi.data();

        if (dataTodayPresensi?["check out"] != null) {
          Get.defaultDialog(
              title: 'Pemberitahuan',
              titleStyle: const TextStyle(fontFamily: 'Lexend'),
              middleText:
                  'Anda sudah melakukan presensi hari ini, silakhan lakukan lakukan presensi besok ',
              middleTextStyle: const TextStyle(
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
        }
      } else {
        if (timeOfDay == waktuMasuk || dateTime.isBefore(waktuBefore)) {
          Get.defaultDialog(
              title: "Kegiatan",
              content: Column(
                children: [
                  TextField(
                    controller: kegC,
                  )
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      status = "Masuk";
                      await colPresensi.doc(docPresensi).set({
                        "tanggal": dateTime.toIso8601String(),
                        "check in": {
                          "tanggal": dateTime.toIso8601String(),
                          "alamat": address,
                          "latitude": position.latitude,
                          "longitude": position.longitude,
                          "kegiatan": kegC.text,
                          "status": status,
                          "jangkauan": jangkauan
                        }
                      });
                      Get.back();
                      Get.snackbar(
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Image.asset(
                              'Assets/icon/check icon.png',
                              width: 36,
                              height: 38,
                            ),
                          ),
                          'Berhasil',
                          'Anda telah melakukan presensi',
                          backgroundColor: Colors.white);
                    },
                    child: const Text('Ok'))
              ]);
        } else {
          Get.defaultDialog(
              title: "Kegiatan",
              content: Column(
                children: [
                  TextField(
                    controller: kegC,
                  )
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      status = "Masuk";
                      await colPresensi.doc(docPresensi).set({
                        "tanggal": dateTime.toIso8601String(),
                        "check in": {
                          "tanggal": dateTime.toIso8601String(),
                          "alamat": address,
                          "latitude": position.latitude,
                          "longitude": position.longitude,
                          "kegiatan": kegC.text,
                          "status": status,
                          "jangkauan": jangkauan
                        }
                      });
                      Get.back();
                      Get.snackbar(
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Image.asset(
                              'Assets/icon/check icon.png',
                              width: 36,
                              height: 38,
                            ),
                          ),
                          'Berhasil',
                          'Anda telah melakukan presensi',
                          backgroundColor: Colors.white);
                    },
                    child: const Text('Ok'))
              ]);
        }
      }
    }
    // } else {
    //   print(jarak);
    //   jangkauan = "di luar area";
    //   Get.defaultDialog(
    //       content: Column(
    //         children: [
    //           Image.asset('Assets/icon/Warning icon.png'),
    //           Text(
    //             'anda berada di luar jangkauan area presnsi',
    //             textAlign: TextAlign.center,
    //           )
    //         ],
    //       ),
    //       title: 'Terjadi Kesalahan',
    //       backgroundColor: Colors.white,
    //       actions: [
    //         TextButton(
    //             onPressed: () => Get.back(),
    //             child: Text(
    //               'kembali',
    //               style: TextStyle(
    //                   fontFamily: 'Lexend',
    //                   fontSize: 18,
    //                   color: ColorConstants.darkClearBlue),
    //             ))
    //       ]);
    // }
  }

  Future<void> checkOut(Position position, String address, double jarak) async {
    String uid = auth.currentUser!.uid;
    DateTime dateTime = DateTime.now();
    DateTime now = DateTime.now();
    TimeOfDay timeOfDay = TimeOfDay.now();
    String docPresensi = DateFormat.yMd().format(dateTime).replaceAll("/", "-");
    String jangkauan = "di luar area";
    String status = "Terlalu cepat";
    DocumentReference<Map<String, dynamic>> timeref =
        fireStore.collection('TimePic').doc('waktu_masuk');
    DocumentSnapshot getpulang = await timeref.get();
    String waktuStringPulang = getpulang.get('pulang');
    List<String> waktuPartsPulang = waktuStringPulang.split(':');
    int jam = int.parse(waktuPartsPulang[0]);
    int menit = int.parse(waktuPartsPulang[1]);
    TimeOfDay waktuPulang = TimeOfDay(hour: jam, minute: menit);

    int convertToInt(TimeOfDay time) {
      return time.hour * 60 + time.minute;
    }

    int pulangAsInt = convertToInt(timeOfDay);

    DateTime waktuBefore = DateTime(
        now.year, now.month, now.day, waktuPulang.hour, waktuPulang.minute);

    CollectionReference<Map<String, dynamic>> colPresensi =
        fireStore.collection("Employee").doc(uid).collection("presensi");

    DocumentSnapshot<Map<String, dynamic>> todayPresensi =
        await colPresensi.doc(docPresensi).get();

    if (todayPresensi.exists == true) {
      CollectionReference<Map<String, dynamic>> colectPresensi =
          FirebaseFirestore.instance
              .collection("Employee")
              .doc(uid)
              .collection("presensi");
      DocumentSnapshot<Map<String, dynamic>> refPresensi =
          await colectPresensi.doc(docPresensi).get();
      Map<String, dynamic>? datawaktu = refPresensi.data();

      Map<String, dynamic>? dataTodayPresensi = todayPresensi.data();
      if (dataTodayPresensi?["check out"] != null) {
        Get.defaultDialog(
            title: 'Pemberitahuan',
            titleStyle: const TextStyle(fontFamily: 'Lexend'),
            middleText:
                'Anda sudah melakukan presensi hari ini, silakhan lakukan lakukan presensi besok ',
            middleTextStyle: const TextStyle(
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
        Get.defaultDialog(
            content: Column(
              children: [
                Image.asset('Assets/icon/Warning icon.png'),
                const Text(
                  'anda akan melakukan check out, sekarang ?',
                  textAlign: TextAlign.center,
                )
              ],
            ),
            title: 'Perhatian',
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
                  )),
              TextButton(
                  onPressed: () {
                    Get.defaultDialog(
                        title: "izin pulang",
                        content: Column(
                          children: [
                            TextField(
                              controller: izinC,
                            )
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                status = 'Terlalu cepat';
                                if (datawaktu != null &&
                                    datawaktu['check in'] != null &&
                                    datawaktu['check in']['tanggal'] != null) {
                                  String tanggalString =
                                      datawaktu['check in']['tanggal'];
                                  DateTime checkTime =
                                      DateTime.parse(tanggalString);
                                  int jam = checkTime.hour;
                                  int menit = checkTime.minute;
                                  TimeOfDay waktuMasuk =
                                      TimeOfDay(hour: jam, minute: menit);

                                  int convertToInt(TimeOfDay time) {
                                    return time.hour * 60 + time.minute;
                                  }

                                  int masukAsInt = convertToInt(waktuMasuk);
                                  await colPresensi.doc(docPresensi).update({
                                    "check out": {
                                      "tanggal": dateTime.toIso8601String(),
                                      "alamat": address,
                                      "latitude": position.latitude,
                                      "longitude": position.longitude,
                                      "jangkauan": jangkauan,
                                      "status": status,
                                      'Jamkerja': pulangAsInt - masukAsInt,
                                      "izin": izinC.text
                                    }
                                  });
                                }
                                Get.back();
                                Get.snackbar(
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Image.asset(
                                        'Assets/icon/check icon.png',
                                        width: 36,
                                        height: 38,
                                      ),
                                    ),
                                    'Pemberitahuan',
                                    'Anda telah melakukan izin pulang lebih cepat',
                                    backgroundColor: Colors.white);
                              },
                              child: const Text('ok'))
                        ]);
                  },
                  child: Text(
                    'izin',
                    style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 18,
                        color: ColorConstants.darkClearBlue),
                  )),
              TextButton(
                  onPressed: () async {
                    if (timeOfDay == waktuPulang) {
                      status = 'pulang Tepat waktu';
                      if (datawaktu != null &&
                          datawaktu['check in'] != null &&
                          datawaktu['check in']['tanggal'] != null) {
                        String tanggalString = datawaktu['check in']['tanggal'];
                        DateTime checkTime = DateTime.parse(tanggalString);
                        int jam = checkTime.hour;
                        int menit = checkTime.minute;
                        TimeOfDay waktuMasuk =
                            TimeOfDay(hour: jam, minute: menit);

                        int convertToInt(TimeOfDay time) {
                          return time.hour * 60 + time.minute;
                        }

                        int masukAsInt = convertToInt(waktuMasuk);
                        await colPresensi.doc(docPresensi).update({
                          "check out": {
                            "tanggal": dateTime.toIso8601String(),
                            "alamat": address,
                            "latitude": position.latitude,
                            "longitude": position.longitude,
                            "jangkauan": jangkauan,
                            "status": status,
                            'Jamkerja': pulangAsInt - masukAsInt
                          }
                        });
                      } else {}
                    } else if (dateTime.isBefore(waktuBefore)) {
                      status = 'Terlalu cepat';
                      if (datawaktu != null &&
                          datawaktu['check in'] != null &&
                          datawaktu['check in']['tanggal'] != null) {
                        String tanggalString = datawaktu['check in']['tanggal'];
                        DateTime checkTime = DateTime.parse(tanggalString);
                        int jam = checkTime.hour;
                        int menit = checkTime.minute;
                        TimeOfDay waktuMasuk =
                            TimeOfDay(hour: jam, minute: menit);

                        int convertToInt(TimeOfDay time) {
                          return time.hour * 60 + time.minute;
                        }

                        int masukAsInt = convertToInt(waktuMasuk);
                        await colPresensi.doc(docPresensi).update({
                          "check out": {
                            "tanggal": dateTime.toIso8601String(),
                            "alamat": address,
                            "latitude": position.latitude,
                            "longitude": position.longitude,
                            "jangkauan": jangkauan,
                            "status": status,
                            'Jamkerja': pulangAsInt - masukAsInt
                          }
                        });
                      } else {}

                      Get.back();
                      Get.snackbar(
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Image.asset(
                              'Assets/icon/Warning icon.png',
                              width: 36,
                              height: 36,
                            ),
                          ),
                          ' Peringatan !',
                          'Anda Check out $status',
                          backgroundColor: Colors.white);
                    }
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 18,
                        color: ColorConstants.darkClearBlue),
                  )),
            ]);
      }
    }
  }

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

//
//
