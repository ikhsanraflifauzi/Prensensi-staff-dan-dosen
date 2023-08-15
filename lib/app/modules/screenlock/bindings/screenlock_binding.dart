import 'package:get/get.dart';

import '../controllers/screenlock_controller.dart';

class ScreenlockBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScreenlockController>(
      () => ScreenlockController(),
    );
  }
}
