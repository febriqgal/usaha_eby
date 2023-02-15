import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/cart_controller.dart';

class StatusView extends GetView<CartController> {
  const StatusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final c = Get.put(CartController());
    CollectionReference order = FirebaseFirestore.instance.collection('order');
    CollectionReference history =
        FirebaseFirestore.instance.collection('history');
    return FutureBuilder(
        future: c.getDetailOrder(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // ignore: unused_local_variable
            final data = snapshot.data?.data() as Map<String?, dynamic>;
            return Scaffold(
              appBar: AppBar(
                title: const Text('StatusView'),
                centerTitle: true,
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await order.doc(snapshot.data?.id).update(
                              {'status': 'Pesanan diterima'}).then((value) {
                            Get.back();
                          }).catchError((error) {});
                          await order
                              .doc(snapshot.data?.id)
                              .delete()
                              .then((value) => null)
                              .catchError((error) {});
                          await history.add({
                            '${user?.uid}': '${user?.uid}',
                            "nama_produk": data['nama_produk'],
                            "varian": data['varian'],
                            "deskripsi_produk": data['deskripsi_produk'],
                            "harga": data['harga'],
                            "total": data['total'],
                            "tanggal_beli": data['tanggal_beli'],
                            "uid": user?.uid,
                            'status': 'Belum Bayar',
                            "jumlah_beli": data['jumlah_beli'],
                            'pesan': data['pesan'],
                            'alamat': data['alamat'],
                            'ongkir': data['ongkir'],
                          });
                        },
                        child: const Text('Pesanan diterima'))
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
