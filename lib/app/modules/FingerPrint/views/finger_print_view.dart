import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/finger_print_controller.dart';

class FingerPrintView extends GetView<FingerPrintController> {
  const FingerPrintView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FingerPrintView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FingerPrintView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
