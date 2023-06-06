import 'package:get/get.dart';

import '../controllers/riwayat_izin_controller.dart';

class RiwayatIzinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatIzinController>(
      () => RiwayatIzinController(),
    );
  }
}
