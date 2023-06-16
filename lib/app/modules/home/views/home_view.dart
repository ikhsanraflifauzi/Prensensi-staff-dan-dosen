import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/modules/home/component/history.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

import '../../Riwayat_Presensi/Component/dataText.dart';
import '../controllers/home_controller.dart';
import '../../../controllers/page_index_controller.dart';
import 'package:geolocator/geolocator.dart';

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
          actions: [
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: controller.streamUser(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return SizedBox();
                  }
                  String role = snap.data!.data()!["role"];
                  if (role == "admin") {
                    return IconButton(
                        onPressed: () => Get.toNamed(Routes.ADD_EMPLOYEE),
                        icon: Icon(Icons.admin_panel_settings_outlined));
                  } else {
                    return SizedBox();
                  }
                }),
          ],
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
                var children2 = <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Container(
                            width: 70,
                            height: 70,
                            child: Image.network(
                              user["profile"] != null
                                  ? user["profile"]
                                  : "https://ui-avatars.com/api/?name= ${user['Name']}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user['Name']}',
                              style: TextStyle(
                                  fontFamily: 'Lexend',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: 200,
                              child: Text(
                                user["alamat"] != null
                                    ? "${user['alamat']}"
                                    : "posisi tidak terdeteksi",
                                style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w100),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
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
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 150,
                          decoration: BoxDecoration(
                              color: ColorConstants.lightClearBlue,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: ColorConstants.darkClearBlue,
                                    offset: Offset(5, 6),
                                    blurRadius: 5)
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                  child: Text(
                                'Presensi',
                                style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 14,
                                    color: Colors.white),
                              )),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: DataText(
                                    name: 'Hari/Tanggal',
                                    value:
                                        '${DateFormat.yMMMEd().format(DateTime.now())}'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
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
                                padding: EdgeInsets.symmetric(horizontal: 10),
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
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: DataText(
                                  name: 'Jam pulang',
                                  value: dataToday?["check out"] == null
                                      ? "-"
                                      : '${DateFormat.Hms().format(DateTime.parse(dataToday!["check out"]!["tanggal"]))}',
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  SizedBox(
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
                                      offset: Offset(5, 6),
                                      blurRadius: 5)
                                ]),
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.door_front_door,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  controller.onCheckIn();
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Check In')
                        ],
                      ),
                      SizedBox(
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
                                      offset: Offset(5, 6),
                                      blurRadius: 5)
                                ]),
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.door_front_door_outlined,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  controller.onCheckOut();
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Check out')
                        ],
                      ),
                      SizedBox(
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
                                      offset: Offset(5, 6),
                                      blurRadius: 5)
                                ]),
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.mail,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Get.toNamed(Routes.SURAT_KELUAR);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Get pass')
                        ],
                      ),
                      SizedBox(
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
                                      offset: Offset(5, 6),
                                      blurRadius: 5)
                                ]),
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.history,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Get.toNamed(Routes.RIWAYAT_PRESENSI);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Riwayat')
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                      ),
                      Text(
                        '5 hari terakhir',
                        style: TextStyle(fontFamily: 'Lexend', fontSize: 18),
                      ),
                    ],
                  ),
                  lastFiveDay(controller: controller),
                ];
                return ListView(children: children2);
              } else {
                return Center(
                  child: Text('tidak dapa memuat data'),
                );
              }
            }),
        bottomNavigationBar: ConvexAppBar(
            backgroundColor: ColorConstants.darkClearBlue,
            cornerRadius: 15,
            style: TabStyle.fixedCircle,
            activeColor: Colors.white,
            height: 60,
            items: [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.handshake, title: 'Presensi'),
              TabItem(icon: Icons.person, title: 'Profil'),
            ],
            initialActiveIndex: pageController.pageIndex.value,
            onTap: (int i) => pageController.pagemove(i)));
  }
}
