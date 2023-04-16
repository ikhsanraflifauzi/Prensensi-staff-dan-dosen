import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/modules/Login/Component/primaryTextField.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.darkClearBlue,
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Text(
              'Ganti password',
              style: TextStyle(
                  fontFamily: 'Lexend', fontSize: 20, color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            PrimaryTextfield(
              controller: controller.newPasswordController,
              hintText: 'password',
              obscureText: true,
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () {
                  controller.newPassword();
                },
                child: Text(
                  'Ganti',
                  style: TextStyle(
                      fontFamily: 'Lexend', fontSize: 20, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ))
          ],
        ));
  }
}
