import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reguster_controller.dart';

class RegusterView extends GetView<RegusterController> {
  const RegusterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegusterView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RegusterView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
