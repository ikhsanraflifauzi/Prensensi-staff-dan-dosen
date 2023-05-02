import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

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
          title: const Text('HomeView'),
          centerTitle: true,
          actions: [
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: controller.stremRole(),
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
        body: Center(
          child: Column(
            children: [Container()],
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
