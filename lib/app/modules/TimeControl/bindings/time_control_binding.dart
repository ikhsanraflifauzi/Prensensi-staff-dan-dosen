import 'package:get/get.dart';

import '../controllers/time_control_controller.dart';

class TimeControlBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimeControlController>(
      () => TimeControlController(),
    );
  }
}
