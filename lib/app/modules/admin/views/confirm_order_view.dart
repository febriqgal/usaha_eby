import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:usaha_eby/app/modules/admin/controllers/admin_controller.dart';
import 'package:usaha_eby/app/modules/admin/views/detail_confirm_order_view.dart';

class ConfirmOrderView extends GetView<AdminController> {
  const ConfirmOrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final orderC = Get.put(AdminController());
    return StreamBuilder<QuerySnapshot?>(
        stream: orderC.collectionStreamOrder,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final order = snapshot.data?.docs;
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Pesanan'),
                  centerTitle: true,
                ),
                body: ListView.builder(
                  itemCount: order?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        (order?[index].data()
                                    as Map<String, dynamic>)['status'] !=
                                "Pesanan Terkirim"
                            ? Get.to(
                                const DetailConfirmOrderView(),
                                arguments: order?[index].id,
                              )
                            : Get.snackbar(
                                '-',
                                '-',
                                titleText: const Center(
                                  child: Text(
                                    'Pemberitahuan',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                messageText: const Center(
                                    child: Text('Pesanan sudah terkirim')),
                                snackStyle: SnackStyle.GROUNDED,
                                backgroundColor: Colors.white,
                                barBlur: 0.5,
                              );
                      },
                      child: Card(
                        child: ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${(order?[index].data() as Map<String, dynamic>)['nama_produk']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Total: ${(order?[index].data() as Map<String, dynamic>)['harga']}',
                              ),
                              Text(
                                'Jumlah Beli: ${(order?[index].data() as Map<String, dynamic>)['jumlah_beli']}',
                              ),
                              Text(
                                'Ongkir: ${(order?[index].data() as Map<String, dynamic>)['ongkir']}',
                              ),
                              Text(
                                'Total: ${(order?[index].data() as Map<String, dynamic>)['total']}',
                              ),
                              Container(
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color: (order?[index].data() as Map<String,
                                              dynamic>)['status'] ==
                                          'Pembayaran diterima'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                child: Text(
                                  'Status: ${(order?[index].data() as Map<String, dynamic>)['status']}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
