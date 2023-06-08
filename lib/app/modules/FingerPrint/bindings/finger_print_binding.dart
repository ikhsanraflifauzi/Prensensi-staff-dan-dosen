import 'package:get/get.dart';

import '../controllers/finger_print_controller.dart';

class FingerPrintBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FingerPrintController>(
      () => FingerPrintController(),
    );
  }
}
