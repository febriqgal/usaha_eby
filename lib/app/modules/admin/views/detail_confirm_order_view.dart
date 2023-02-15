import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../product/controllers/product_controller.dart';
import '../controllers/admin_controller.dart';

class DetailConfirmOrderView extends GetView<AdminController> {
  const DetailConfirmOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(AdminController());
    CollectionReference order = FirebaseFirestore.instance.collection('order');
    return FutureBuilder(
        future: c.getDetailOrder(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data?.data() as Map<String?, dynamic>;

            return Scaffold(
                appBar: AppBar(
                  title: const Text('asdads'),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['harga'].toString(),
                      ),
                      const Text('BUKTI PEMBAYARAN'),
                      ElevatedButton(
                          onPressed: () async {
                            data['status'] != "Pembayaran diterima"
                                ? await order.doc(snapshot.data?.id).update({
                                    'status': 'Pembayaran diterima'
                                  }).then((value) {
                                    Get.back();
                                  }).catchError((error) =>
                                    print("Failed to update user: $error"))
                                : await order.doc(snapshot.data?.id).update({
                                    'status': 'Pesanan Terkirim'
                                  }).then((value) {
                                    Get.back();
                                  }).catchError((error) =>
                                    print("Failed to update user: $error"));
                          },
                          child: Text(data['status'] != "Pembayaran diterima"
                              ? 'Konfirmasi Pembayaran'
                              : "Kirim Produk"))
                    ],
                  ),
                ));
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
