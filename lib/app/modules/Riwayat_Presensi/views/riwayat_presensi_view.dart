import 'package:circular_menu/circular_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

import '../../../Utils/Colors.dart';
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
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                    color: ColorConstants.darkClearBlue),
              );
            }
            if (snapshot.hasData) {
              Map<String, dynamic> user = snapshot.data!.data()!;

              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: SizedBox(
                            width: 70,
                            height: 70,
                            child: Image.network(
                              user["profile"] ??
                                  "https://ui-avatars.com/api/?name= ${user['Name']}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user['Name']}',
                              style: const TextStyle(
                                  fontFamily: 'Lexend',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 200,
                              child: Row(
                                children: [
                                  const Text(
                                    'Jabatan :',
                                    style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w100),
                                  ),
                                  Text(
                                    user["jabatan"] != null
                                        ? "${user['jabatan']}"
                                        : "-",
                                    style: const TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w100),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Row(
                                children: [
                                  const Text(
                                    'Prodi :',
                                    style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w100),
                                  ),
                                  Text(
                                    user["prodi"] != null
                                        ? "${user['prodi']}"
                                        : " - ",
                                    style: const TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w100),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Table(
                      border: TableBorder.all(
                        color: Colors.black,
                      ),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: const <int, TableColumnWidth>{
                        0: FixedColumnWidth(60),
                        1: FixedColumnWidth(60),
                        2: FixedColumnWidth(60),
                        3: FlexColumnWidth(40),
                        4: FlexColumnWidth(40),
                        5: FlexColumnWidth(30),
                      },
                      children: [
                        TableRow(children: [
                          for (var title in [
                            'Tgl',
                            'Kegiatan',
                            'Check in',
                            'Status',
                            'Check out',
                            'Jam kerja',
                          ])
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              color: ColorConstants.lightClearBlue,
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontFamily: 'lexend',
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                        ]),
                      ],
                    ),
                    Expanded(
                      child: GetBuilder<RiwayatPresensiController>(
                        builder: (c) {
                          return FutureBuilder<
                              QuerySnapshot<Map<String, dynamic>>>(
                            future: controller.getAllPresensi(),
                            builder: (context, snap) {
                              if (snap.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snap.data?.docs.length == 0 ||
                                  snap.data == null) {
                                return const SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Text(
                                      'belum ada data presensi',
                                      style: TextStyle(
                                          fontFamily: 'Lexend', fontSize: 14),
                                    ),
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                  itemCount: snap.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    if (snap.hasData) {
                                      Map<String, dynamic>? data = snap
                                          .data!.docs.reversed
                                          .toList()[index]
                                          .data();

                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 5),
                                        child: Table(
                                          border: TableBorder.all(
                                            color: Colors.black,
                                          ),
                                          defaultVerticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          columnWidths: const <int,
                                              TableColumnWidth>{
                                            0: FixedColumnWidth(60),
                                            1: FixedColumnWidth(60),
                                            2: FixedColumnWidth(60),
                                            3: FlexColumnWidth(40),
                                            4: FlexColumnWidth(40),
                                            5: FlexColumnWidth(30),
                                          },
                                          children: [
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  color: Colors.white,
                                                  child: Text(
                                                    DateFormat.yMMMEd().format(
                                                      DateTime.parse(
                                                          data["tanggal"]),
                                                    ),
                                                    style: const TextStyle(
                                                      fontFamily: 'lexend',
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  color: Colors.white,
                                                  child: Text(
                                                    data['check in']
                                                                ?['kegiatan'] ==
                                                            null
                                                        ? "-"
                                                        : data['check in']
                                                            ['kegiatan'],
                                                    style: const TextStyle(
                                                      fontFamily: 'lexend',
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  color: Colors.white,
                                                  child: Text(
                                                    data['check in']
                                                                ?['tanggal'] ==
                                                            null
                                                        ? "-"
                                                        : DateFormat.Hm()
                                                            .format(
                                                            DateTime.parse(data[
                                                                    "check in"]
                                                                ["tanggal"]),
                                                          ),
                                                    style: const TextStyle(
                                                      fontFamily: 'lexend',
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  color: Colors.white,
                                                  child: Text(
                                                    data['check in']
                                                                ?['status'] ==
                                                            null
                                                        ? "-"
                                                        : data['check in']
                                                            ['status'],
                                                    style: const TextStyle(
                                                      fontFamily: 'lexend',
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  color: Colors.white,
                                                  child: Text(
                                                    data['check out']
                                                                ?['tanggal'] ==
                                                            null
                                                        ? "-"
                                                        : DateFormat.Hm()
                                                            .format(
                                                            DateTime.parse(data[
                                                                    "check out"]
                                                                ["tanggal"]),
                                                          ),
                                                    style: const TextStyle(
                                                      fontFamily: 'lexend',
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    color: Colors.white,
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Get.defaultDialog(
                                                            title:
                                                                'Keterangan Izin',
                                                            content: Row(
                                                              children: [
                                                                const Text(
                                                                  ' Alasan :',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'lexend',
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  data['check out']
                                                                              ?[
                                                                              'izin'] ==
                                                                          null
                                                                      ? "tanpa keterangan"
                                                                      : data['check out']
                                                                          [
                                                                          'izin'],
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'lexend',
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
                                                            ));
                                                      },
                                                      child: Text(
                                                        data['check out']?[
                                                                    'Jamkerja'] ==
                                                                null
                                                            ? "-"
                                                            : data['check out']
                                                                    ['Jamkerja']
                                                                .toString(),
                                                        style: TextStyle(
                                                          fontFamily: 'Lexend',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: data['check out']
                                                                      ?[
                                                                      'Jamkerja'] ==
                                                                  null
                                                              ? Colors.black
                                                              : data['check out']
                                                                          [
                                                                          'Jamkerja'] <
                                                                      360
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .green,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }

                                    return const Center(
                                      child: SizedBox(),
                                    );
                                  },
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ]));
            }
            return Center();
          }),
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
    );
  }
}
