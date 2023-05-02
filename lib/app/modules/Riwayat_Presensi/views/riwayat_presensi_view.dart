import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../Utils/Colors.dart';
import '../../../controllers/page_index_controller.dart';
import '../controllers/riwayat_presensi_controller.dart';

class RiwayatPresensiView extends GetView<RiwayatPresensiController> {
  const RiwayatPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageController = Get.find<PageIndexController>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('RiwayatPresensiView'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'RiwayatPresensiView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
        bottomNavigationBar: ConvexAppBar(
            backgroundColor: ColorConstants.darkClearBlue,
            // cornerRadius: 30,
            style: TabStyle.flip,
            items: [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.mail, title: 'Surat keluar'),
              TabItem(icon: Icons.add, title: 'Presensi'),
              TabItem(icon: Icons.history, title: 'Riwayat presensi'),
              TabItem(icon: Icons.person, title: 'Profil'),
            ],
            initialActiveIndex: pageController.pageIndex.value,
            onTap: (int i) => pageController.pagemove(i)));
  }
}
