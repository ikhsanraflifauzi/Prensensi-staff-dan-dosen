import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protoype_t_a/app/modules/Riwayat_Presensi/controllers/riwayat_presensi_controller.dart';

class ListRiwayat extends GetView<RiwayatPresensiController> {
  const ListRiwayat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiwayatPresensiController>(
      builder: (c) => FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: controller.getAllPresensi(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.data?.docs.length == 0 || snap.data == null) {
              return const SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    'belum ada data presensi',
                    style: TextStyle(fontFamily: 'Lexend', fontSize: 14),
                  ),
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: false,
              itemCount: snap.data!.docs.length,
              // physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (snap.hasData) {
                  Map<String, dynamic>? data =
                      snap.data!.docs.reversed.toList()[index].data();
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      width: 303,
                      height: 113,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 7),
                              blurRadius: 7,
                              color: Colors.grey),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Check in ',
                                style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(DateFormat.yMMMEd()
                                  .format(DateTime.parse(data["tanggal"]))),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data['check in']?['tanggal'] == null
                                    ? "-"
                                    : DateFormat.Hms().format(DateTime.parse(
                                        data["check in"]!["tanggal"])),
                                style: const TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Text('-'),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Check Out',
                                style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data['check out']?['tanggal'] == null
                                    ? "-"
                                    : DateFormat.Hms().format(DateTime.parse(
                                        data["check out"]!["tanggal"])),
                                style: const TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  );
                }
                return const Center(
                  child: SizedBox(),
                );
              },
            );
          }),
    );
  }
}
