import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/modules/screenlock/views/screenlock_view.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_lock_screen/flutter_lock_screen.dart';

import '../controllers/finger_auth_controller.dart';

class FingerAuthView extends GetView<FingerAuthController> {
  const FingerAuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var myPass = [1, 2, 3, 4];
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(
              height: 54,
            ),
            SizedBox(
                child: Image.asset(
              'Assets/image/pei 1.png',
              width: 300,
              height: 300,
            )),
            const Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 50),
                child: const Text(
                  'Aplikasi Presensi',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Lexend',
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorConstants.whitegray,
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.door_front_door,
                            color: ColorConstants.lightClearBlue,
                          ),
                          onPressed: () async {
                            //controller.onCheckIn(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Check In')
                  ],
                ),
                SizedBox(
                  width: 31,
                ),
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorConstants.whitegray,
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.door_front_door_outlined,
                            color: Colors.red.shade400,
                          ),
                          onPressed: () async {
                            //controller.onCheckOut();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Check out')
                  ],
                ),
                SizedBox(
                  width: 31,
                ),
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorConstants.whitegray,
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.mail,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            // Get.toNamed(Routes.SURAT_KELUAR);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Get pass')
                  ],
                ),
                SizedBox(
                  width: 31,
                ),
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorConstants.whitegray,
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.history,
                            color: Colors.greenAccent,
                          ),
                          onPressed: () {
                            // Get.toNamed(Routes.RIWAYAT_PRESENSI);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Riwayat')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorConstants.whitegray,
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.calendar_month,
                            color: Colors.orangeAccent,
                          ),
                          onPressed: () async {
                            //controller.onCheckIn(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Filter')
                  ],
                ),
                SizedBox(
                  width: 31,
                ),
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorConstants.whitegray,
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.person,
                            color: Colors.purple,
                          ),
                          onPressed: () async {
                            //controller.onCheckOut();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Profil')
                  ],
                ),
                SizedBox(
                  width: 31,
                ),
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorConstants.whitegray,
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.sick,
                            color: ColorConstants.mainColorYellow,
                          ),
                          onPressed: () {
                            // Get.toNamed(Routes.SURAT_KELUAR);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Absen')
                  ],
                ),
                SizedBox(
                  width: 31,
                ),
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorConstants.whitegray,
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            // Get.toNamed(Routes.RIWAYAT_PRESENSI);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Geolocation')
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 100, 0, 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.lightClearBlue),
                      onPressed: () async {
                        var enteredPassCode = await Get.to(
                          () => ScreenlockView(),
                        );
                        if (enteredPassCode != null) {
                          bool isPassCodeCorrect = controller.verifyPassCode(
                            enteredPassCode,
                            myPass,
                          );
                          if (isPassCodeCorrect) {
                            Get.offAllNamed(Routes.LOGIN);
                          } else {
                            Get.snackbar(
                              "Opps!",
                              "Wrong pass please try again.",
                              snackPosition: SnackPosition.BOTTOM,
                              duration: Duration(seconds: 3),
                            );
                          }
                        }
                      },
                      child: Text('PIN'),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 40,
                    width: 50,
                    color: ColorConstants.lightClearBlue,
                    child: IconButton(
                        color: Colors.white,
                        onPressed: () => controller.authenticated(),
                        icon: Icon(
                          Icons.fingerprint,
                          size: 25,
                        )),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

// class PassCodeInputScreen extends GetView<FingerAuthController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(() {
//         return LockScreen(
//           title: "This is Screet",
//           passLength: controller.myPass.length,
//           bgImage: "images/bg.jpg",
//           fingerPrintImage: Image.asset(
//             "images/fingerprint.png",
//             height: 40,
//             width: 40,
//           ),
//           showFingerPass: true,
//           // fingerFunction: controller.biometrics,
//           numColor: Colors.blue,
//           // fingerVerify: controller.isFingerprint.value,
//           borderColor: Colors.white,
//           showWrongPassDialog: true,
//           wrongPassContent: "Wrong pass please try again.",
//           wrongPassTitle: "Opps!",
//           wrongPassCancelButtonText: "Cancel",
//           passCodeVerify: (passcode) async {
//             for (int i = 0; i < controller.myPass.length; i++) {
//               if (passcode[i] != controller.myPass[i]) {
//                 return false;
//               }
//             }
//             return true;
//           },
//           onSuccess: () {
//             Get.offAllNamed(Routes.LOGIN);
//           },
//         );
//       }),
//     );
//   }
// }
