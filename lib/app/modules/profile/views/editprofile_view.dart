// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usaha_eby/app/modules/profile/views/change_name_view.dart';
import 'package:usaha_eby/app/modules/profile/views/change_password_view.dart';
import 'package:usaha_eby/app/modules/profile/views/change_photo_view.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditProfileView'),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Get.to(() => const ChangeNameView());
            },
            leading: const Icon(Icons.person),
            title: const Text('Ganti Nama'),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () {
              Get.to(() => const ChangePasswordView());
            },
            leading: const Icon(Icons.person),
            title: const Text('Ganti Password'),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () {
              Get.to(() => const ChangePhotoView());
            },
            leading: const Icon(Icons.person),
            title: const Text('Foto Profile'),
            trailing: const Icon(Icons.chevron_right),
          )
        ],
      ),
    );
  }
}
