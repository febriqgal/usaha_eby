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
                        } else {
                          Get.to(
                            () => const StatusView(),
                            arguments: order?[index].id,
                          );
                        }
                      },
                      child: Card(
                        child: Row(
                          children: [
                            Image.asset(width: 100, 'assets/original.png'),
                            const SizedBox(
                              width: 18,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${(order?[index].data() as Map<String, dynamic>)['nama_produk']}',
                                ),
                                Text(
                                  '${(order?[index].data() as Map<String, dynamic>)['harga']}',
                                ),
                                Text(
                                  '${(order?[index].data() as Map<String, dynamic>)['status']}',
                                ),
                              ],
                            ),
                          ],
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
