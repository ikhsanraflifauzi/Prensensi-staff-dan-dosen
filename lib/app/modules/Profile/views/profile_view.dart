import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:protoype_t_a/app/Utils/Colors.dart';
import 'package:protoype_t_a/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
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
            return Center(
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
                      child: Container(
                        width: 165,
                        height: 165,
                        child: Image.network(
                          user["profile"] != null
                              ? user["profile"]
                              : "https://ui-avatars.com/api/?name= ${user['Name']}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${user['Name']}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Lexend', fontSize: 20, color: Colors.white),
                ),
                Text(
                  "${user['email']}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Lexend', fontSize: 12, color: Colors.white),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.UPDATE_PROFILE, arguments: user);
                  },
                  leading: Icon(Icons.person, color: Colors.white),
                  title: Text('Update profile',
                      style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 12,
                          color: Colors.white)),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.PASSWORD_UPDATES);
                  },
                  leading: Icon(Icons.key, color: Colors.white),
                  title: Text('Ganti Password',
                      style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 12,
                          color: Colors.white)),
                ),
                ListTile(
                  onTap: () {
                    controller.logout();
                  },
                  leading: Icon(Icons.logout, color: Colors.white),
                  title: Text('Keluar',
                      style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 12,
                          color: Colors.white)),
                ),
              ],
            );
          } else {
            return Center(
              child: Text('Tidak dapat membuat user'),
            );
          }
        },
      ),
    );
  }
}
