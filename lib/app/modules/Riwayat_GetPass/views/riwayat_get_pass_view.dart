import 'package:circular_menu/circular_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../controllers/riwayat_get_pass_controller.dart';

class RiwayatGetPassView extends GetView<RiwayatGetPassController> {
  const RiwayatGetPassView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Get Pass',
          style: TextStyle(fontFamily: 'Lexend'),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.toNamed(Routes.HOME);
            }),
        centerTitle: true,
        backgroundColor: ColorConstants.darkClearBlue,
      ),
      body: Column(
        children: [
          Container(
            width: 360,
            height: 202,
            // color: ColorConstants.blue1,
            child: Image.asset('Assets/image/exp2.png', fit: BoxFit.cover),
          ),
          Expanded(
              child: GetBuilder<RiwayatGetPassController>(
            builder: (controller) => FutureBuilder<
                    QuerySnapshot<Map<String, dynamic>>>(
                future: controller.getAllGetPass(),
                builder: (context, snapGet) {
                  if (snapGet.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapGet.data?.docs.length == 0 || snapGet.data == null) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          'belum ada data GetPass',
                          style: TextStyle(fontFamily: 'Lexend', fontSize: 14),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: false,
                    itemCount: snapGet.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic>? data =
                          snapGet.data!.docs.reversed.toList()[index].data();
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 303,
                          height: 153,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstants.lightClearBlue),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 9, 15, 18),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tanggal :',
                                    style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    '${DateFormat.yMMMEd().format(DateTime.parse(data["Tanggal"]))}',
                                    style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ' Jam Keluar',
                                    style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    data['GetPass']['Tanggal'] == null
                                        ? '-'
                                        : '${DateFormat.Hms().format(DateTime.parse(data["GetPass"]!["Tanggal"]))}',
                                    style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Jam Kembali',
                                    style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    data["GetBack"] == null
                                        ? "-"
                                        : '${DateFormat.Hms().format(DateTime.parse(data["GetBack"]!["Tanggal"]))}',
                                    style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Perihal :',
                                    style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    data['GetPass']['Alasan'] == null
                                        ? '-'
                                        : data['GetPass']['Alasan'],
                                    style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      );
                    },
                  );
                }),
          )),
        ],
      ),
      floatingActionButton: CircularMenu(
          alignment: Alignment.bottomRight,
          toggleButtonColor: ColorConstants.darkClearBlue,
          items: [
            CircularMenuItem(
              onTap: () {
                Get.toNamed(Routes.RIWAYAT_PRESENSI);
              },
              color: ColorConstants.darkClearBlue,
              icon: Icons.history,
            ),
            CircularMenuItem(
              onTap: () {
                Get.toNamed(Routes.RIWAYAT_IZIN);
              },
              color: ColorConstants.darkClearBlue,
              icon: Icons.sick,
            ),
            CircularMenuItem(
              onTap: () {
                Get.dialog(Dialog(
                  child: Container(
                      padding: EdgeInsets.all(20),
                      height: 400,
                      child: SfDateRangePicker(
                        startRangeSelectionColor: ColorConstants.lightClearBlue,
                        endRangeSelectionColor: ColorConstants.darkClearBlue,
                        selectionMode: DateRangePickerSelectionMode.range,
                        showActionButtons: true,
                        onCancel: () => Get.back(),
                        onSubmit: (cal) {
                          if (cal != null) {
                            if ((cal as PickerDateRange).endDate != null) {
                              controller.pickDate(cal.startDate!, cal.endDate!);
                            }
                          }
                        },
                      )),
                ));
              },
              color: ColorConstants.darkClearBlue,
              icon: Icons.calendar_month,
            ),
          ]),
    );
  }
}
