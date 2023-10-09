import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rekap_data_controller.dart';

class RekapDataView extends GetView<RekapDataController> {
  const RekapDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RekapDataView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RekapDataView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
