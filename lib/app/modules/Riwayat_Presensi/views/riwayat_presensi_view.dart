import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';
import 'package:simple_navigation_menu/simple_navigation_menu.dart';

import '../../../Utils/Colors.dart';
import '../../../controllers/page_index_controller.dart';
import '../Component/list_riwayat_presensi.dart';
import '../controllers/riwayat_presensi_controller.dart';

class RiwayatPresensiView extends GetView<RiwayatPresensiController> {
  const RiwayatPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageController = Get.find<PageIndexController>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Riwayat Presensi',
              style: TextStyle(fontFamily: 'Lexend'),
            ),
            centerTitle: true,
            backgroundColor: ColorConstants.darkClearBlue,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Get.offAllNamed(Routes.HOME);
                }),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Riwayat Presensi',
                ),
                Tab(
                  text: 'Get pass',
                )
              ],
              dividerColor: ColorConstants.whitegray,
              indicatorColor: Colors.white,
            ),
          ),
          backgroundColor: ColorConstants.whitegray,
          body: TabBarView(
            children: [
              Tab(child: ListRiwayat()),
              Tab(
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                ),
              ),
            ],
          )),
    );
  }
}
