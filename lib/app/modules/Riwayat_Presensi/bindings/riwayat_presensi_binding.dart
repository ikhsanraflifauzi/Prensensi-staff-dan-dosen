import 'package:get/get.dart';

import '../controllers/riwayat_presensi_controller.dart';

class RiwayatPresensiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatPresensiController>(
      () => RiwayatPresensiController(),
    );
  }
}
