import 'package:get/get.dart';

import '../controllers/surat_keluar_controller.dart';

class GetPassViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuratKeluarController>(
      () => SuratKeluarController(),
    );
  }
}
