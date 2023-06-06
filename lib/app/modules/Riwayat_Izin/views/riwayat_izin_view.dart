import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/riwayat_izin_controller.dart';

class RiwayatIzinView extends GetView<RiwayatIzinController> {
  const RiwayatIzinView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RiwayatIzinView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RiwayatIzinView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
