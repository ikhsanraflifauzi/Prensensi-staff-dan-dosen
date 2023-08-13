import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/modules/Login/Component/primaryTextField.dart';

import '../../../routes/app_pages.dart';
import '../controllers/add_employee_controller.dart';

class AddEmployeeView extends GetView<AddEmployeeController> {
  const AddEmployeeView({Key? key}) : super(key: key);
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
          SizedBox(
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
                        boxShadow: [
                          BoxShadow(color: Colors.grey, offset: Offset(5, 6))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Status Get Pass",
                          style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "jam keluar",
                              style: TextStyle(
                                  fontFamily: 'Lexend', color: Colors.white),
                            ),
                            Text(
                                dataGetPass?["GetPass"] == null
                                    ? "-"
                                    : '${DateFormat.Hms().format(DateTime.parse(dataGetPass!["GetPass"]!["Tanggal"]))}',
                                style: TextStyle(
                                    fontFamily: 'Lexend', color: Colors.white))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Jam kembali",
                                style: TextStyle(
                                    fontFamily: 'Lexend', color: Colors.white)),
                            Text(
                                dataGetPass?["GetBack"] == null
                                    ? "-"
                                    : '${DateFormat.Hms().format(DateTime.parse(dataGetPass!["GetBack"]!["Tanggal"]))}',
                                style: TextStyle(
                                    fontFamily: 'Lexend', color: Colors.white)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("perihal :",
                                style: TextStyle(
                                    fontFamily: 'Lexend', color: Colors.white)),
                            Text(
                                dataGetPass?['GetPass'] == null
                                    ? "-"
                                    : dataGetPass!['GetPass']['Alasan'],
                                style: TextStyle(
                                    fontFamily: 'Lexend', color: Colors.white))
                          ],
                        ),
                      ]),
                    ),
                  ),
                );
              }),
          SizedBox(
            height: 20,
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
                    "Kembali",
                    style: TextStyle(fontFamily: 'Lexend', fontSize: 15),
                  )),
            ),
          ),
          SizedBox(
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
