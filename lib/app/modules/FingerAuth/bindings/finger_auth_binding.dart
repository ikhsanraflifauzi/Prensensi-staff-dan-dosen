import 'package:get/get.dart';

import '../controllers/finger_auth_controller.dart';

class FingerAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FingerAuthController>(
      () => FingerAuthController(),
    );
  }
}
