import 'package:get/get.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

class ImpresionPageController extends GetxController {
  //TODO: Implement ImpresionPageController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  forwardAction() {
    Get.toNamed(Routes.EXPLAIN1);
  }

  void increment() => count.value++;
}
