import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/modules/Login/Component/primaryTextField.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

import '../controllers/daftar_controller.dart';

class DaftarView extends GetView<DaftarController> {
  const DaftarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.darkClearBlue,
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(
              height: 75,
            ),
            const Text(
              'Daftar',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lexend',
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                  child: PrimaryTextfield(
                controller: controller.nipC,
                hintText: 'NIP',
                keyboardType: TextInputType.emailAddress,
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                  child: PrimaryTextfield(
                controller: controller.namaC,
                hintText: 'Nama',
                keyboardType: TextInputType.emailAddress,
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                  child: PrimaryTextfield(
                controller: controller.emailC,
                hintText: 'email',
                keyboardType: TextInputType.emailAddress,
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: GetBuilder<DaftarController>(
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
                        hint: const Text('Role'),
                        value: controller.roleprogram,
                        isExpanded: true,
                        items: controller.roleitems
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: GetBuilder<DaftarController>(
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
                        hint: const Text('Prodi'),
                        value: controller.prodiprogram,
                        isExpanded: true,
                        items: controller.prodiitems
                            .map((value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ))
                            .toList(),
                        onChanged: (value) {
                          controller.setProdiProgram(value);
                        },
                      )),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                  child: PrimaryTextfield(
                controller: controller.jabatanC,
                hintText: 'Jabatan',
                keyboardType: TextInputType.emailAddress,
              )),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(12),
                child: PrimaryTextfield(
                  controller: controller.passC,
                  hintText: 'masukkan kata sandi',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'masukkan kata sandi anda';
                    }
                    return null;
                  },
                  obscureText: controller.passwordIsHidden.value,
                  suffixIcon: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        controller.passwordIsHidden.toggle();
                      },
                      icon: controller.passwordIsHidden.value == true
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: 100,
              height: 50,
              child: Obx(
                () => ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      controller.daftar();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: ColorConstants.lightClearBlue),
                  child: Text(
                    controller.isLoading.isFalse ? "Daftar" : "Loading",
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Lexend',
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextButton(
                onPressed: () {
                  Get.offAllNamed(Routes.LOGIN);
                },
                child: const Text(
                  'Sudah Punya Akun?',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Lexend',
                      color: Colors.yellow,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ));
  }
}
