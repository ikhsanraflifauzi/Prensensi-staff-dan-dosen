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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 134,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: SizedBox(
                width: 94,
                height: 96,
                child: Image.asset('Assets/image/peiPutih.png'),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: SizedBox(
                width: 300,
                child: Text(
                  'Selamat Datang di aplikasi Presensi Staff dan Dosen ',
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Lexend'),
                ),
              ),
            ),
            SizedBox(height: 12),
            Center(
                child: SizedBox(
              width: 302,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.white, width: 2.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: ColorConstants.lightClearBlue),
                  onPressed: () {
                    controller.forwardAction();
                  },
                  child: Text(
                    'Jelajahi',
                    style: TextStyle(fontFamily: 'Lexend'),
                  )),
            ))
          ],
        ));
  }
}
