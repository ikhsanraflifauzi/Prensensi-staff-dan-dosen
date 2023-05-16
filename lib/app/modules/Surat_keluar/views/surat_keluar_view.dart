import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

import '../../../Utils/Colors.dart';
import '../../Login/Component/primaryTextField.dart';
import '../controllers/surat_keluar_controller.dart';
import '../../../controllers/page_index_controller.dart';

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
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.offAllNamed(Routes.HOME);
          },
        ),
      ),
      backgroundColor: ColorConstants.whitegray,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SizedBox(
            height: 20,
          ),
          PrimaryTextfield(
            // controller: controller.nipController,
            labelText: 'NIP',
          ),
          SizedBox(
            height: 20,
          ),
          PrimaryTextfield(
            // controller: controller.emailController,
            labelText: 'email',
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.pass,
            maxLines: 3,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fillColor: Colors.white),
          ),
          SizedBox(
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
                  child: Text(
                    "Tambahkan",
                    style: TextStyle(fontFamily: 'Lexend', fontSize: 15),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
