import 'package:get/get.dart';

import '../controllers/riwayat_get_pass_controller.dart';

class RiwayatGetPassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatGetPassController>(
      () => RiwayatGetPassController(),
    );
  }
}
