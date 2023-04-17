import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_employee_controller.dart';

class AddEmployeeView extends GetView<AddEmployeeController> {
  const AddEmployeeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddEmployeeView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.nipController,
            decoration: InputDecoration(
                labelText: 'NIP',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.nameController,
            decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.emailController,
            decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
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
                ElevatedButton(
                    onPressed: () async {
                      await controller.addEmploye();
                    },
                    child: Text(
                      "Masukkan user",
                      style: TextStyle(fontFamily: 'Lexend', fontSize: 20),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
