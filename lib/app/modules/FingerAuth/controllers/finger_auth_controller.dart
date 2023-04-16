import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

class FingerAuthController extends GetxController {
  //TODO: Implement FingerAuthController

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LocalAuthentication _localAuth = LocalAuthentication();
}
