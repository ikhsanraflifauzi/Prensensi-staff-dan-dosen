import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/modules/Login/Component/primaryTextField.dart';

import '../controllers/izin_sakit_controller.dart';

class IzinSakitView extends GetView<IzinSakitController> {
  const IzinSakitView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ' Keterangan tidak hadir',
          style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: ColorConstants.darkClearBlue,
      ),
      backgroundColor: ColorConstants.whitegray,
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Keterangan ',
            style: TextStyle(
                fontFamily: 'Lexend',
                fontSize: 14,
                color: ColorConstants.darkClearBlue),
          ),
          GetBuilder<IzinSakitController>(
            builder: (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputDecorator(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      fillColor: const Color(0xffFFFBFE),
                      filled: true),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(24.0),
                    isDense: true,
                    hint: const Text('Pilihan Keterangan'),
                    value: controller.program,
                    isExpanded: true,
                    items: controller.items
                        .map((value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                    onChanged: (value) {
                      controller.setProgram(value);
                    },
                  )),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          Text(
            'Pilih Foto',
            style: TextStyle(
                fontFamily: 'Lexend',
                fontSize: 14,
                color: ColorConstants.darkClearBlue),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 300,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<IzinSakitController>(builder: (b) {
                  if (b.image != null) {
                    return Container(
                      width: 50,
                      height: 50,
                      color: Colors.white,
                      child: Image.file(
                        File(b.image!.path),
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                  return Center();
                }),
                IconButton(
                  onPressed: () {
                    controller.imagepic();
                  },
                  icon: Icon(
                    Icons.upload,
                    color: ColorConstants.darkClearBlue,
                  ),
                ),
              ],
            ),
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
                    await controller.uploadImage();
                  },
                  child: Text(
                    "Kirim",
                    style: TextStyle(fontFamily: 'Lexend', fontSize: 15),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
