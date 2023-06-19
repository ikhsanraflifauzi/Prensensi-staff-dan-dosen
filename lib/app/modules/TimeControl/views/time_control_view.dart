import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';

import '../controllers/time_control_controller.dart';

class TimeControlView extends GetView<TimeControlController> {
  const TimeControlView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Waktu masuk Kantor',
            style: TextStyle(fontFamily: 'Lexend'),
          ),
          centerTitle: true,
          backgroundColor: ColorConstants.darkClearBlue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.back(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 150,
                      height: 200,
                      decoration: BoxDecoration(
                          color: ColorConstants.lightClearBlue,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            DateFormat.Hm()
                                .format(controller.selectedTime.value),
                            style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 35,
                                color: Colors.white),
                          ),
                          IconButton(
                              onPressed: () {
                                controller.howTimePicker(context);
                              },
                              icon: Icon(
                                Icons.sunny,
                                size: 70,
                                color: Colors.yellow,
                              )),
                          SizedBox(
                            height: 35,
                          ),
                          Text(
                            "Masuk pagi",
                            style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorConstants.darkClearBlue),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            '00 : 00',
                            style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 35,
                                color: Colors.white),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.nights_stay_sharp,
                                size: 70,
                                color: Colors.white,
                              )),
                          SizedBox(
                            height: 35,
                          ),
                          Text(
                            'Masuk malam',
                            style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
