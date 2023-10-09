import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

import '../../../Utils/Colors.dart';
import '../Component/list_riwayat_presensi.dart';
import '../controllers/riwayat_presensi_controller.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class RiwayatPresensiView extends GetView<RiwayatPresensiController> {
  const RiwayatPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Presensi',
          style: TextStyle(fontFamily: 'Lexend'),
        ),
        centerTitle: true,
        backgroundColor: ColorConstants.darkClearBlue,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.offAllNamed(Routes.HOME);
            }),
      ),
      backgroundColor: ColorConstants.whitegray,
      body: const ListRiwayat(),
      floatingActionButton: CircularMenu(
          alignment: Alignment.bottomRight,
          toggleButtonColor: ColorConstants.darkClearBlue,
          items: [
            CircularMenuItem(
              onTap: () {
                Get.toNamed(Routes.RIWAYAT_GET_PASS);
              },
              color: ColorConstants.lightClearBlue,
              icon: Icons.outbond,
            ),
            CircularMenuItem(
              onTap: () {
                Get.toNamed(Routes.RIWAYAT_IZIN);
              },
              color: ColorConstants.lightClearBlue,
              icon: Icons.sick,
            ),
            CircularMenuItem(
              onTap: () {
                Get.dialog(Dialog(
                  child: Container(
                      padding: const EdgeInsets.all(20),
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
              color: ColorConstants.lightClearBlue,
              icon: Icons.calendar_month,
            ),
          ]),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //
      //   },
      //   child: Icon(Icons.calendar_month_outlined),
      //   backgroundColor: ColorConstants.lightClearBlue,
      // ),
    );
  }
}
