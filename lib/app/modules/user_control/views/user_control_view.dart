import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_control_controller.dart';

class UserControlView extends GetView<UserControlController> {
  const UserControlView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserControlView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UserControlView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
