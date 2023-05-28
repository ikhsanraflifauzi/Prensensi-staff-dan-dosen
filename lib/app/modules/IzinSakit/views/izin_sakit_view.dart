import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/izin_sakit_controller.dart';

class IzinSakitView extends GetView<IzinSakitController> {
  const IzinSakitView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IzinSakitView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'IzinSakitView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
