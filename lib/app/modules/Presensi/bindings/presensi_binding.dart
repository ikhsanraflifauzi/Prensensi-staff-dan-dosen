import 'package:get/get.dart';

import '../controllers/presensi_controller.dart';

class PresensiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PresensiController>(
      () => PresensiController(),
    );
  }
}
