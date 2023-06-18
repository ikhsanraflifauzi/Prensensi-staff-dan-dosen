import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/time_control_controller.dart';

class TimeControlView extends GetView<TimeControlController> {
  const TimeControlView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TimeControlView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TimeControlView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
