import 'package:get/get.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  void pagemove(int i) async {
    // pageIndex.value = i;
    switch (i) {
      case 1:
        pageIndex.value = i;
        Get.offAllNamed(Routes.SURAT_KELUAR);

        break;
      case 2:
        print("this is for presensce");
        break;
      case 3:
        pageIndex.value = i;
        Get.offAllNamed(Routes.RIWAYAT_PRESENSI);
        break;
      case 4:
        pageIndex.value = i;
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        pageIndex.value = i;
        Get.offAllNamed(Routes.HOME);
    }
  }
}
