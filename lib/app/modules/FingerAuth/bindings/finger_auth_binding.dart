import 'package:get/get.dart';

import '../../screenlock/controllers/screenlock_controller.dart';
import '../controllers/finger_auth_controller.dart';

class FingerAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FingerAuthController>(
      () => FingerAuthController(),
    );
    Get.lazyPut<ScreenlockController>(
      () => ScreenlockController(),
    );
  }
}
