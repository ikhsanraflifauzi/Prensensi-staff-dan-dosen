import 'package:get/get.dart';
import 'package:protoype_t_a/app/controllers/page_index_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut(() => PageIndexController());
  }
}
