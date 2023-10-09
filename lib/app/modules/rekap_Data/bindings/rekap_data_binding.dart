import 'package:get/get.dart';

import '../controllers/rekap_data_controller.dart';

class RekapDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RekapDataController>(
      () => RekapDataController(),
    );
  }
}
