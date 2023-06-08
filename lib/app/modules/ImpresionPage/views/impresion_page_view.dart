import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';

import '../controllers/impresion_page_controller.dart';

class ImpresionPageView extends GetView<ImpresionPageController> {
  const ImpresionPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.lightClearBlue,
        body: Center(
          child: Text('ini implesion page'),
        ));
  }
}
