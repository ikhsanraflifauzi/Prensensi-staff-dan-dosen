import 'package:get/get.dart';

import '../controllers/getpassview_controller.dart';

class GetpassviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetpassviewController>(
      () => GetpassviewController(),
    );
  }
}
