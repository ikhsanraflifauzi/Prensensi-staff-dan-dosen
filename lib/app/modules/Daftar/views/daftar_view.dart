import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/daftar_controller.dart';

class DaftarView extends GetView<DaftarController> {
  const DaftarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DaftarView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DaftarView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
