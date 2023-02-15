import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'payment.dart';
import '../controllers/cart_controller.dart';
import 'status_view.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final orderC = Get.put(CartController());
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
                        if ((order?[index].data()
                                as Map<String, dynamic>)['status'] ==
                            'Belum Bayar') {
                          Get.to(
                            () => const PaymentView(),
                            arguments: order?[index].id,
                          );
                        } else if ((order?[index].data()
                                as Map<String, dynamic>)['status'] ==
                            'Pesanan diterima') {
                          Get.snackbar(
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
                                child: Text(
                                    'Terima kasih sudah berbelanja ditempat kami')),
                            snackStyle: SnackStyle.GROUNDED,
                            backgroundColor: Colors.white,
                            barBlur: 0.5,
                          );
                        } else if ((order?[index].data()
                                as Map<String, dynamic>)['status'] ==
                            'Pembayaran diterima') {
                        } else if ((order?[index].data()
                                as Map<String, dynamic>)['status'] ==
                            'Menunggu Konfirmas Pembayaran') {
                          Get.snackbar(
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
                                child: Text(
                                    'Mohon tunggu... pembayaran akan segera dikonfirmasi!')),
                            snackStyle: SnackStyle.GROUNDED,
                            backgroundColor: Colors.white,
                            barBlur: 0.5,
                          );
                        } else {
                          Get.to(
                            () => const StatusView(),
                            arguments: order?[index].id,
                          );
                        }
                      },
                      child: Card(
                        child: ListTile(
                          leading: Image.asset(
                            '${(order?[index].data() as Map<String, dynamic>)['foto']}',
                          ),
                          title: Text(
                            '${(order?[index].data() as Map<String, dynamic>)['nama_produk']}',
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${(order?[index].data() as Map<String, dynamic>)['tanggal_beli']}',
                              ),
                              Container(
                                margin: const EdgeInsetsDirectional.only(
                                    top: 8, bottom: 8),
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 16, vertical: 4),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Text(
                                  '${(order?[index].data() as Map<String, dynamic>)['status']}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          trailing: Text(
                            'Rp ${(order?[index].data() as Map<String, dynamic>)['total']}',
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
