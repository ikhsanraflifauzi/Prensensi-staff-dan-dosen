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
            TextField(
              controller: controller.nipController,
              readOnly: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  fillColor: Colors.white),
            ),
            SizedBox(
              height: 12,
            ),
            PrimaryTextfield(
              controller: controller.nameController,
              labelText: 'Nama',
            ),
            SizedBox(
              height: 12,
            ),
            PrimaryTextfield(
              controller: controller.emailController,
              labelText: 'email',
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('image picker'),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.upload),
                  label: Text('Upload foto'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.lightClearBlue),
                )
              ],
            ),
          ],
        ));
  }
}
