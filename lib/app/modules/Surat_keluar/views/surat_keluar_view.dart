import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

import '../../../Utils/Colors.dart';
import '../controllers/surat_keluar_controller.dart';

class SuratKeluarView extends GetView<SuratKeluarController> {
  const SuratKeluarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Get pass'),
        centerTitle: true,
        backgroundColor: ColorConstants.darkClearBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.offAllNamed(Routes.HOME);
          },
        ),
      ),
      backgroundColor: ColorConstants.whitegray,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(children: const [
              Text(
                ' Tuliskan perihal anda untuk keluar kantor sementara ',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 15,
                ),
              ),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: TextField(
              controller: controller.pass,
              maxLines: 3,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  fillColor: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
              width: 350,
              height: 47,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.lightClearBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () async {
                    await controller.getPass();
                  },
                  child: const Text(
                    "Kirim",
                    style: TextStyle(fontFamily: 'Lexend', fontSize: 15),
                  )),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Center(
              child: TextButton(
                  onPressed: () => Get.toNamed(Routes.IZIN_SAKIT),
                  child: Text(
                    'Anda tidak dapat hadir?',
                    style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 14,
                        color: ColorConstants.darkClearBlue),
                  ))),
        ],
      ),
    );
  }
}
