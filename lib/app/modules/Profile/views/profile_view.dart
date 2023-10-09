import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

import '../../../controllers/page_index_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = Get.find<PageIndexController>();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profil',
            style: TextStyle(fontFamily: 'Lexend'),
          ),
          centerTitle: true,
          backgroundColor: ColorConstants.lightClearBlue,
        ),
        backgroundColor: ColorConstants.lightClearBlue,
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snap.hasData) {
              Map<String, dynamic> user = snap.data!.data()!;
              return ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: SizedBox(
                          width: 165,
                          height: 165,
                          child: Image.network(
                            user["profile"] ??
                                "https://ui-avatars.com/api/?name= ${user['Name']}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${user['Name']}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  Text(
                    "${user['email']}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 12,
                        color: Colors.white),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.UPDATE_PROFILE, arguments: user);
                    },
                    leading: const Icon(Icons.person, color: Colors.white),
                    title: const Text('Update profile',
                        style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 12,
                            color: Colors.white)),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.PASSWORD_UPDATES);
                    },
                    leading: const Icon(Icons.key, color: Colors.white),
                    title: const Text('Ganti Password',
                        style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 12,
                            color: Colors.white)),
                  ),
                  ListTile(
                    onTap: () {
                      controller.logout();
                    },
                    leading: const Icon(Icons.logout, color: Colors.white),
                    title: const Text('Keluar',
                        style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 12,
                            color: Colors.white)),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Tidak dapat membuat user'),
              );
            }
          },
        ),
        bottomNavigationBar: ConvexAppBar(
            backgroundColor: ColorConstants.lightClearBlue,
            activeColor: Colors.white,
            height: 60,
            items: const [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.person, title: 'Profil'),
              TabItem(icon: Icons.sick, title: 'Absen')
            ],
            initialActiveIndex: pageController.pageIndex.value,
            onTap: (int i) => pageController.pagemove(i)));
  }
}
