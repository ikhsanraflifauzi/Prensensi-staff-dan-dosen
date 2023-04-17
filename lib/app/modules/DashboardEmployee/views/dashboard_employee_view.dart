import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_employee_controller.dart';

class DashboardEmployeeView extends GetView<DashboardEmployeeController> {
  const DashboardEmployeeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardEmployeeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DashboardEmployeeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
