import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protoype_t_a/app/modules/home/component/isiText.dart';
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
                    height: 210,
                    decoration: BoxDecoration(
                        color: Colors.white,
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
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Status"),
                            Text(dataGetPass?['GetPass'] == null
                                ? "dI Kantor"
                                : dataGetPass!['GetPass']['Status'])
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("jam keluar"),
                            Text(dataGetPass?["GetPass"] == null
                                ? "-"
                                : '${DateFormat.Hms().format(DateTime.parse(dataGetPass!["GetPass"]!["Tanggal"]))}')
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Jam kembali"),
                            Text(dataGetPass?["GetBack"] == null
                                ? "-"
                                : '${DateFormat.Hms().format(DateTime.parse(dataGetPass!["GetBack"]!["Tanggal"]))}'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("perihal :"),
                            Text(dataGetPass?['GetPass'] == null
                                ? "-"
                                : dataGetPass!['GetPass']['Alasan'])
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
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
