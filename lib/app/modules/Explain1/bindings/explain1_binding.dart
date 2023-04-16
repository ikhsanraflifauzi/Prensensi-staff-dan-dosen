import 'package:get/get.dart';

import '../controllers/explain1_controller.dart';

class Explain1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Explain1Controller>(
      () => Explain1Controller(),
    );
  }
}
