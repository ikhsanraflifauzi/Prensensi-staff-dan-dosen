import 'package:get/get.dart';

import '../controllers/user_control_controller.dart';

class UserControlBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserControlController>(
      () => UserControlController(),
    );
  }
}
