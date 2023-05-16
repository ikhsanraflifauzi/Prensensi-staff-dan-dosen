import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protoype_t_a/app/modules/Login/Component/primaryTextField.dart';
import 'package:protoype_t_a/app/modules/Riwayat_Presensi/controllers/riwayat_presensi_controller.dart';

class ListRiwayat extends GetView<RiwayatPresensiController> {
  const ListRiwayat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: PrimaryTextfield(
            hintText: 'Cari',
            suffixIcon: Icon(Icons.search),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: false,
            itemCount: 20,
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: 303,
                  height: 113,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 7),
                          blurRadius: 7,
                          color: Colors.grey),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Check in ',
                            style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Text('${DateFormat.yMMMEd().format(DateTime.now())}'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${DateFormat.Hms().format(DateTime.now())}",
                            style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Text('Status : masuk'),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Chek Out',
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
                            "${DateFormat.Hms().format(DateTime.now())}",
                            style: TextStyle(
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
            },
          ),
        ),
      ],
    );
  }
}