// ignore: file_names
// ignore_for_file: file_names

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
