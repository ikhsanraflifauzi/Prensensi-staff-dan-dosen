import 'package:get/get.dart';

import '../controllers/impresion_page_controller.dart';

class ImpresionPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImpresionPageController>(
      () => ImpresionPageController(),
    );
  }
}
