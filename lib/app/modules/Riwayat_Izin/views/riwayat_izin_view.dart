import 'package:circular_menu/circular_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../controllers/riwayat_izin_controller.dart';

class RiwayatIzinView extends GetView<RiwayatIzinController> {
  const RiwayatIzinView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Absen',
          style: TextStyle(fontFamily: 'Lexend'),
        ),
        centerTitle: true,
        backgroundColor: ColorConstants.darkClearBlue,
        leading: IconButton(
            onPressed: () {
              Get.offAllNamed(Routes.HOME);
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: GetBuilder<RiwayatIzinController>(
        builder: (controller) =>
            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                builder: (context, snapIz) {
          if (snapIz.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapIz.data?.docs.length == 0 || snapIz.data == null) {
            return SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  'belum ada data Absen',
                  style: TextStyle(fontFamily: 'Lexend', fontSize: 14),
                ),
              ),
            );
          }
          return ListView.builder(
              shrinkWrap: false,
              itemCount: 10,
              itemBuilder: (context, index) {
                Map<String, dynamic>? data =
                    snapIz.data!.docs.reversed.toList()[index].data();
                return Padding(
                  padding: const EdgeInsets.all(25),
                  child: Container(
                    width: 303,
                    height: 220,
                    decoration: BoxDecoration(
                        color: ColorConstants.lightClearBlue,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child: Container(
                              width: 278,
                              height: 112,
                              color: Colors.white,
                              child: Image.network(
                                data['fotoSurat'] != null
                                    ? data['fotoSurat']
                                    : "tidak ada surat",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tanggal',
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
                                      color: Colors.white))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Keterangan',
                                style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                              Text(
                                  data['Absen']['Keterangan'] == null
                                      ? '-'
                                      : data['Absen']['Keterangan'],
                                  style: TextStyle(
                                      fontFamily: 'Lexend',
                                      fontSize: 14,
                                      color: Colors.white))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }),
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
                Get.toNamed(Routes.RIWAYAT_GET_PASS);
              },
              color: ColorConstants.darkClearBlue,
              icon: Icons.outbond,
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
                              // controller.pickDate(cal.startDate!, cal.endDate!);
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

 





// 