import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/password_updates_controller.dart';

class PasswordUpdatesView extends GetView<PasswordUpdatesController> {
  const PasswordUpdatesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PasswordUpdatesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PasswordUpdatesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
