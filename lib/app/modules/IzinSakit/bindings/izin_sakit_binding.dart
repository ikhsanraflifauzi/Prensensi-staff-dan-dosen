import 'package:get/get.dart';

import '../controllers/izin_sakit_controller.dart';

class IzinSakitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IzinSakitController>(
      () => IzinSakitController(),
    );
  }
}
