import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/modules/Login/Component/primaryTextField.dart';

import '../controllers/add_employee_controller.dart';

class AddEmployeeView extends GetView<AddEmployeeController> {
  const AddEmployeeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Tambah user'),
        centerTitle: true,
        backgroundColor: ColorConstants.darkClearBlue,
      ),
      backgroundColor: ColorConstants.whitegray,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SizedBox(
            height: 20,
          ),
          PrimaryTextfield(
            controller: controller.nipController,
            labelText: 'NIP',
          ),
          SizedBox(
            height: 20,
          ),
          PrimaryTextfield(
            controller: controller.nameController,
            labelText: 'Nams',
          ),
          SizedBox(
            height: 20,
          ),
          PrimaryTextfield(
            controller: controller.emailController,
            labelText: 'email',
          ),
          SizedBox(
            height: 20,
          ),
          GetBuilder<AddEmployeeController>(
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
                    hint: const Text('Pilihan Role'),
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
                          await controller.addEmploye();
                        },
                        child: Text(
                          "Tambahkan",
                          style: TextStyle(fontFamily: 'Lexend', fontSize: 15),
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
