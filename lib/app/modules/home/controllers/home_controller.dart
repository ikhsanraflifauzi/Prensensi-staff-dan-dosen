import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
