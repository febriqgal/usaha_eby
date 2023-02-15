import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';
import '../controllers/cart_controller.dart';

class PaymentView extends GetView<CartController> {
  const PaymentView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cont = Get.put(CartController());
    CollectionReference order = FirebaseFirestore.instance.collection('order');
    return FutureBuilder(
      future: cont.getDetailOrder(Get.arguments),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var data = snapshot.data?.data() as Map<String?, dynamic>;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Checkout'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadiusDirectional.circular(16)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Nama Produk:',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Varian:',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Harga:',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Jumlah Beli',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Ongkir',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Total',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(width: 32),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${data['nama_produk']}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                '${data['varian']}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                '${data['harga']}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                '${data['jumlah_beli']}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                '${data['ongkir']}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                '${data['total']}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Silahkan lakukan pembayaran ke rekening :'),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(width: 24, 'assets/bni.png'),
                          const Text(' BNI '),
                          const Text('719270381'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(width: 24, 'assets/bsi.png'),
                          const Text(' BSI '),
                          const Text('7220297785'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(width: 24, 'assets/dana.png'),
                          const Text(' DANA '),
                          const Text('081261488496'),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Total Pembayaran: '),
                          Text(
                            'Rp ${data['total'].toString()}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          cont.pickfotoberita(snapshot.data?.id);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 18,
                            left: 18,
                            right: 18,
                          ),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: kWhiteGreyColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Center(
                            child: Text(
                              'Pilih Gambar',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
