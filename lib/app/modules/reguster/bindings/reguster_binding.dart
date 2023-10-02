import 'package:get/get.dart';

import '../controllers/reguster_controller.dart';

class RegusterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegusterController>(
      () => RegusterController(),
    );
  }
}
