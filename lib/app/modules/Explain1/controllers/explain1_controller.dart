import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protoype_t_a/app/modules/Explain1/Component/ExplainInfo.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import '../../../routes/app_pages.dart';

class Explain1Controller extends GetxController {
  var selectedPagesindex = 0.obs;
  bool get isLastPage => selectedPagesindex.value == explain1View.length - 1;
  var pageController = PageController();
  forwardAction() {
    if (isLastPage) {
      Get.toNamed(Routes.LOGIN);
    } else {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }

  List<ExplainInfo> explain1View = [
    ExplainInfo('Assets/image/Exp1.png', 'Aplikasi Presensi',
        'Aplikasi Presensi merupakan aplikasi untuk mendata kehadiran staff dan dosen di Politeknik Enjinering Indorama.'),
    ExplainInfo('Assets/image/exp2.png', 'Riwayat Presensi',
        'Riwayat Presensi merupakan fitur untuk melihat riwayat presensi staff dan dosen'),
  ];
}
