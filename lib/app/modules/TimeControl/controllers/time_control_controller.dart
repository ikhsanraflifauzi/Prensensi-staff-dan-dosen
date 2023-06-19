import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeControlController extends GetxController {
  //TODO: Implement TimeControlController
  Rx<DateTime> selectedTime = Rx<DateTime>(DateTime.now());

  void updateTime(DateTime newTime) {
    selectedTime.value = newTime;
  }

  void howTimePicker(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final DateTime now = DateTime.now();
      final DateTime selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      updateTime(selectedDateTime);
    }
  }
}
