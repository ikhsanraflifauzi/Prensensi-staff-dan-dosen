import 'package:get/get.dart';

import '../controllers/getPass_landing_controller.dart';

class GetPassLandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetPassLandingController>(
      () => GetPassLandingController(),
    );
  }
}
