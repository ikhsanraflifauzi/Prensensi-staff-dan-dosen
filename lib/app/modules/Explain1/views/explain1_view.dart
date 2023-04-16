import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';

import '../controllers/explain1_controller.dart';

class Explain1View extends GetView<Explain1Controller> {
  const Explain1View({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Explain1Controller();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.selectedPagesindex,
              itemCount: controller.explain1View.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Column(
                    children: [
                      Container(
                        width: 500,
                        height: 360,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          color: Colors.white,
                        ),
                        child: Image.asset(
                            controller.explain1View[index].imageAssets),
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 120),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(controller.explain1View[index].title,
                              style: TextStyle(
                                  fontFamily: 'Lexend',
                                  fontSize: 18,
                                  color: Colors.black)),
                        ),
                      ),
                      SizedBox(
                        height: 31,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                              controller.explain1View[index].description,
                              style: TextStyle(
                                  fontFamily: 'Lexend',
                                  fontSize: 20,
                                  color: Colors.black)),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Row(
                children: List.generate(
                  controller.explain1View.length,
                  (index) => Obx(
                    () {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        width: 12,
                        height: 13,
                        decoration: BoxDecoration(
                            color: controller.selectedPagesindex.value == index
                                ? ColorConstants.hightOrange
                                : Colors.black,
                            shape: BoxShape.circle),
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: ElevatedButton(
                onPressed: controller.forwardAction,
                child: Obx(
                  () {
                    return Text(controller.isLastPage ? 'Mulai' : 'Lanjut');
                  },
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.lightClearBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            GestureDetector()
          ],
        ),
      ),
    );
  }
}
