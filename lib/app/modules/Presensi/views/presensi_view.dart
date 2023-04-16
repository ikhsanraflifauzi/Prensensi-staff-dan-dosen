import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/presensi_controller.dart';

class PresensiView extends GetView<PresensiController> {
  const PresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PresensiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PresensiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
