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
          Text('Nama'),
          PrimaryTextfield(),
          SizedBox(
            height: 10,
          ),
          Text('Keterangan '),
          PrimaryTextfield(),
          SizedBox(
            height: 20,
          ),
          Text('Pilih Foto'),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 300,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorConstants.darkClearBlue),
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
                    // controller.imagepic();
                  },
                  icon: Icon(
                    Icons.upload,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text('Pilih File'),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 300,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorConstants.lightClearBlue),
            child: Row(
              children: [
                GetBuilder<IzinSakitController>(builder: (c) {
                  if (c.filePic != null) {}
                  return Center();
                }),
                IconButton(
                  onPressed: () {
                    // controller.imagepic();
                  },
                  icon: Icon(
                    Icons.upload,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            // color: ColorConstants.darkClearBlue,
          ),
        ],
      ),
    );
  }
}
