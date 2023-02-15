import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:usaha_eby/app/modules/admin/views/confirm_order_view.dart';

import '../controllers/admin_controller.dart';

class AdminView extends GetView<AdminController> {
  const AdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AdminView'),
          centerTitle: true,
        ),
        body: ListTile(
          onTap: () {
            Get.to(() => const ConfirmOrderView());
          },
          title: Text('Konfirmasi pesanan'),
        ));
  }
}
