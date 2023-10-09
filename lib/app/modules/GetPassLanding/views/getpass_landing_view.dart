import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';

import '../../../routes/app_pages.dart';
import '../controllers/getPass_landing_controller.dart';

class GetPassLandingView extends GetView<GetPassLandingController> {
  const GetPassLandingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Data GetPass'),
        centerTitle: true,
        backgroundColor: ColorConstants.darkClearBlue,
      ),
      backgroundColor: ColorConstants.whitegray,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
              stream: controller.streamInfoGetPass(),
              builder: (context, snapGetPass) {
                if (snapGetPass.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: ColorConstants.darkClearBlue,
                    ),
                  );
                }
                Map<String, dynamic>? dataGetPass = snapGetPass.data?.data();
                return Center(
                  child: Container(
                    width: 500,
                    height: 160,
                    decoration: BoxDecoration(
                        color: ColorConstants.lightClearBlue,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(color: Colors.grey, offset: Offset(5, 6))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Status Get Pass",
                          style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "jam keluar",
                              style: TextStyle(
                                  fontFamily: 'Lexend', color: Colors.white),
                            ),
                            Text(
                                dataGetPass?["GetPass"] == null
                                    ? "-"
                                    : DateFormat.Hms().format(DateTime.parse(
                                        dataGetPass!["GetPass"]!["Tanggal"])),
                                style: const TextStyle(
                                    fontFamily: 'Lexend', color: Colors.white))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Jam kembali",
                                style: TextStyle(
                                    fontFamily: 'Lexend', color: Colors.white)),
                            Text(
                                dataGetPass?["GetBack"] == null
                                    ? "-"
                                    : DateFormat.Hms().format(DateTime.parse(
                                        dataGetPass!["GetBack"]!["Tanggal"])),
                                style: const TextStyle(
                                    fontFamily: 'Lexend', color: Colors.white)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("perihal :",
                                style: TextStyle(
                                    fontFamily: 'Lexend', color: Colors.white)),
                            Text(
                                dataGetPass?['GetPass'] == null
                                    ? "-"
                                    : dataGetPass!['GetPass']['Alasan'],
                                style: const TextStyle(
                                    fontFamily: 'Lexend', color: Colors.white))
                          ],
                        ),
                      ]),
                    ),
                  ),
                );
              }),
          const SizedBox(
            height: 20,
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
                    "Kembali",
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
