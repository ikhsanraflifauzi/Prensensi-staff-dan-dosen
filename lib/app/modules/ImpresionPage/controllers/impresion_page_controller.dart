import 'package:get/get.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';
import 'package:local_auth/local_auth.dart';

class ImpresionPageController extends GetxController {
  var localAuth = LocalAuthentication();
  var isHasFingerPrint = false.obs;
}
