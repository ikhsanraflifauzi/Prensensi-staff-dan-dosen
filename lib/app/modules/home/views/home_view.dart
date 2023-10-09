// ignore_for_file: unnecessary_string_interpolations, prefer_is_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';
import '../../Riwayat_Presensi/Component/dataText.dart';
import '../controllers/home_controller.dart';
import '../../../controllers/page_index_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageController = Get.find<PageIndexController>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.darkClearBlue,
          title: const Text(
            'Dashboard',
            style: TextStyle(fontFamily: 'Lexend'),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                      color: ColorConstants.darkClearBlue),
                );
              }
              if (snapshot.hasData) {
                Map<String, dynamic> user = snapshot.data!.data()!;

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipOval(
                            child: SizedBox(
                              width: 70,
                              height: 70,
                              child: Image.network(
                                user["profile"] ??
                                    "https://ui-avatars.com/api/?name= ${user['Name']}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user['Name']}',
                                style: const TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  user["alamat"] != null
                                      ? "${user['alamat']}"
                                      : "posisi tidak terdeteksi",
                                  style: const TextStyle(
                                      fontFamily: 'Lexend',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w100),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          stream: controller.streamInfoPresensi(),
                          builder: (
                            context,
                            snapDataPresensi,
                          ) {
                            Map<String, dynamic>? dataToday =
                                snapDataPresensi.data?.data();
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              height: 211,
                              decoration: BoxDecoration(
                                  color: ColorConstants.lightClearBlue,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: ColorConstants.darkClearBlue,
                                        offset: const Offset(5, 6),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Center(
                                      child: Text(
                                    'Presensi',
                                    style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 14,
                                        color: Colors.white),
                                  )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: DataText(
                                        name: 'Hari/Tanggal',
                                        value:
                                            '${DateFormat.yMMMEd().format(DateTime.now())}'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: DataText(
                                        name: 'Status',
                                        value: dataToday?['check in'] == null
                                            ? "-"
                                            : dataToday!['check in']['status']),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: DataText(
                                        name: 'Kegiatan',
                                        value: dataToday?['check in'] == null
                                            ? "-"
                                            : dataToday!['check in']
                                                ['kegiatan']),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: DataText(
                                      name: 'Jam Masuk',
                                      value: dataToday?["check in"] == null
                                          ? "-"
                                          : '${DateFormat.Hms().format(DateTime.parse(dataToday!["check in"]!["tanggal"]))}',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: DataText(
                                      name: 'Jam pulang',
                                      value: dataToday?["check out"] == null
                                          ? "-"
                                          : '${DateFormat.Hms().format(DateTime.parse(dataToday!["check out"]!["tanggal"]))}',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: DataText(
                                      name: 'Jam kerja (menit)',
                                      value: dataToday?['check out'] == null
                                          ? "-"
                                          : dataToday!['check out']['Jamkerja']
                                              .toString(),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: ColorConstants.lightClearBlue,
                                    boxShadow: [
                                      BoxShadow(
                                          color: ColorConstants.darkClearBlue,
                                          offset: const Offset(5, 6),
                                          blurRadius: 5)
                                    ]),
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.door_front_door,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      controller.onCheckIn(context);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Check In')
                            ],
                          ),
                          const SizedBox(
                            width: 31,
                          ),
                          Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: ColorConstants.lightClearBlue,
                                    boxShadow: [
                                      BoxShadow(
                                          color: ColorConstants.darkClearBlue,
                                          offset: const Offset(5, 6),
                                          blurRadius: 5)
                                    ]),
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.door_front_door_outlined,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      controller.onCheckOut();
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Check out')
                            ],
                          ),
                          const SizedBox(
                            width: 31,
                          ),
                          Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: ColorConstants.lightClearBlue,
                                    boxShadow: [
                                      BoxShadow(
                                          color: ColorConstants.darkClearBlue,
                                          offset: const Offset(5, 6),
                                          blurRadius: 5)
                                    ]),
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.mail,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Get.toNamed(Routes.SURAT_KELUAR);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Get pass')
                            ],
                          ),
                          const SizedBox(
                            width: 31,
                          ),
                          Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: ColorConstants.lightClearBlue,
                                    boxShadow: [
                                      BoxShadow(
                                          color: ColorConstants.darkClearBlue,
                                          offset: const Offset(5, 6),
                                          blurRadius: 5)
                                    ]),
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.history,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Get.toNamed(Routes.RIWAYAT_PRESENSI);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Riwayat')
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          SizedBox(
                            width: 24,
                          ),
                          Text(
                            '5 hari terakhir',
                            style:
                                TextStyle(fontFamily: 'Lexend', fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                          child: StreamBuilder<
                              QuerySnapshot<Map<String, dynamic>>>(
                        stream: controller.streamLastPresensi(),
                        builder: (context, snapPresnsi) {
                          if (snapPresnsi.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapPresnsi.data?.docs.length == 0 ||
                              snapPresnsi.data == null) {
                            return const SizedBox(
                              height: 200,
                              child: Center(
                                child: Text(
                                  'belum ada data presensi',
                                  style: TextStyle(
                                      fontFamily: 'Lexend', fontSize: 14),
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: snapPresnsi.data!.docs.length,
                            itemBuilder: (context, index) {
                              if (snapPresnsi.hasData) {
                                Map<String, dynamic>? data = snapPresnsi
                                    .data!.docs.reversed
                                    .toList()[index]
                                    .data();
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    width: 303,
                                    height: 113,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                            offset: Offset(0, 7),
                                            blurRadius: 7,
                                            color: Colors.grey),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Check in ',
                                              style: TextStyle(
                                                  fontFamily: 'Lexend',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                                '${DateFormat.yMMMEd().format(DateTime.parse(data["tanggal"]))}'),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data['check in']?['tanggal'] ==
                                                      null
                                                  ? "-"
                                                  : '${DateFormat.Hms().format(DateTime.parse(data["check in"]!["tanggal"]))}',
                                              style: const TextStyle(
                                                  fontFamily: 'Lexend',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const Text('-'),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              'Check Out',
                                              style: TextStyle(
                                                  fontFamily: 'Lexend',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data['check out']?['tanggal'] ==
                                                      null
                                                  ? "-"
                                                  : '${DateFormat.Hms().format(DateTime.parse(data["check out"]!["tanggal"]))}',
                                              style: const TextStyle(
                                                  fontFamily: 'Lexend',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ),
                                  ),
                                );
                              }
                              return const Center(child: Text('--------'));
                            },
                          );
                        },
                      ))
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text('tidak dapa memuat data'),
                );
              }
            }),
        bottomNavigationBar: ConvexAppBar(
            backgroundColor: ColorConstants.darkClearBlue,
            activeColor: Colors.white,
            height: 60,
            items: const [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.person, title: 'Profil'),
              TabItem(icon: Icons.sick, title: 'Absen')
            ],
            initialActiveIndex: pageController.pageIndex.value,
            onTap: (int i) => pageController.pagemove(i)));
  }
}
