import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/riwayat_presensi_controller.dart';

class RiwayatPresensiView extends GetView<RiwayatPresensiController> {
  const RiwayatPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RiwayatPresensiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RiwayatPresensiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
