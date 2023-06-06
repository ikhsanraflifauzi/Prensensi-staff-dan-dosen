import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/riwayat_get_pass_controller.dart';

class RiwayatGetPassView extends GetView<RiwayatGetPassController> {
  const RiwayatGetPassView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RiwayatGetPassView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RiwayatGetPassView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
