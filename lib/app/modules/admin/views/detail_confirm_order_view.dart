import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                      const Text(
                        'BUKTI PEMBAYARAN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Image.network(data['foto']),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            data['status'] != "Pembayaran diterima"
                                ? await order.doc(snapshot.data?.id).update({
                                    'status': 'Pembayaran diterima'
                                  }).then((value) {
                                    Get.back();
                                  }).catchError((error) {})
                                : await order.doc(snapshot.data?.id).update({
                                    'status': 'Pesanan Terkirim'
                                  }).then((value) {
                                    Get.back();
                                  }).catchError((error) {});
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
