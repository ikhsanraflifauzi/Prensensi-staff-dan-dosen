import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/modules/Login/Component/primaryTextField.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  const UpdateProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> user = Get.arguments;

    controller.nipController.text = user["NIP"];
    controller.nameController.text = user["Name"];
    controller.emailController.text = user["email"];
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Ubah Profile',
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            backgroundColor: ColorConstants.darkClearBlue,
            actions: [
              IconButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      controller.updateProfile(user["Uid"]);
                    }
                  },
                  icon: const Icon(Icons.check))
            ]),
        backgroundColor: ColorConstants.darkClearBlue,
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(
              height: 54,
            ),
            Text(
              'NIP',
              style: TextStyle(
                  fontFamily: 'Lexend', color: Colors.white, fontSize: 15),
            ),
            SizedBox(
              height: 5,
            ),
            PrimaryTextfield(
              controller: controller.nipController,
              labelText: 'NIP',
              readOnly: true,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Nama',
              style: TextStyle(
                  fontFamily: 'Lexend', color: Colors.white, fontSize: 15),
            ),
            SizedBox(
              height: 5,
            ),
            PrimaryTextfield(
              controller: controller.nameController,
              labelText: 'Nama',
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'email',
              style: TextStyle(
                  fontFamily: 'Lexend', color: Colors.white, fontSize: 15),
            ),
            SizedBox(
              height: 5,
            ),
            PrimaryTextfield(
              controller: controller.emailController,
              labelText: 'email',
              readOnly: true,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Pilih Foto',
              style: TextStyle(
                  fontFamily: 'Lexend', color: Colors.white, fontSize: 15),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<UpdateProfileController>(builder: (b) {
                  if (b.image != null) {
                    return ClipOval(
                        child: Container(
                      width: 100,
                      height: 100,
                      child: Image.file(
                        File(b.image!.path),
                        fit: BoxFit.cover,
                      ),
                    ));
                  } else {
                    if (user["profile"] != null) {
                      return ClipOval(
                          child: InkWell(
                        onTap: () {
                          Get.defaultDialog(
                              content: Column(
                                children: [
                                  Image.asset('Assets/icon/Warning icon.png'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Anda akan menghapus foto profil',
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                              title: 'Peringatan !',
                              titleStyle: TextStyle(fontFamily: 'Lexend'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      controller.deletepic(
                                        user["Uid"],
                                      );
                                    },
                                    child: Text(
                                      'Hapus',
                                      style: TextStyle(
                                          fontFamily: 'Lexend',
                                          color: ColorConstants.darkClearBlue),
                                    )),
                              ]);
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            user["profile"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ));
                    }
                    return Text(
                      'tidak ada foto',
                      style: TextStyle(
                          fontFamily: 'Lexend',
                          color: Colors.white,
                          fontSize: 12),
                    );
                  }
                }),
                IconButton(
                  onPressed: () {
                    controller.imagepic();
                  },
                  icon: Icon(
                    Icons.upload,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
