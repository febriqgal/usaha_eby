import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usaha_eby/app/modules/admin/views/confirm_order_view.dart';
import 'package:usaha_eby/app/modules/admin/views/edit_product.dart';
import '../controllers/admin_controller.dart';
import 'add_product.dart';

class AdminView extends GetView<AdminController> {
  const AdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard Admin'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            ListTile(
              onTap: () {
                Get.to(() => const ProductAddView());
              },
              title: const Text('Tambah Produk'),
            ),
            ListTile(
              onTap: () {
                Get.to(() => const EditProductView());
              },
              title: const Text('Edit Produk'),
            ),
            ListTile(
              onTap: () {
                Get.to(() => const ConfirmOrderView());
              },
              title: const Text('Konfirmasi pesanan'),
            ),
          ],
        ));
  }
}
