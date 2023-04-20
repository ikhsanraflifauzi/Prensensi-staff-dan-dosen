import 'package:get/get.dart';

import '../controllers/password_updates_controller.dart';

class PasswordUpdatesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasswordUpdatesController>(
      () => PasswordUpdatesController(),
    );
  }
}
