import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
          actions: [
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: controller.stremRole(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return SizedBox();
                  }
                  String role = snap.data!.data()!["role"];
                  if (role == "admin") {
                    return IconButton(
                        onPressed: () => Get.toNamed(Routes.ADD_EMPLOYEE),
                        icon: Icon(Icons.admin_panel_settings_outlined));
                  } else {
                    return SizedBox();
                  }
                }),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.logout();
                },
                child: Text("Logout"),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.PROFILE);
                },
                child: Text("Profil"),
              ),
            ],
          ),
        ),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: ColorConstants.darkClearBlue,
          cornerRadius: 30,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.map, title: 'Discovery'),
            TabItem(icon: Icons.add, title: 'Add'),
            TabItem(icon: Icons.message, title: 'Message'),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          onTap: (int i) => print('click index=$i'),
        ));
  }
}
