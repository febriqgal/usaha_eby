import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usaha_eby/theme.dart';
import '../../product/controllers/product_controller.dart';
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['harga'].toString(),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await order.doc(snapshot.data?.id).update(
                            {'bukti': 'ini bukti'}).then((value) {
                          Get.back();
                        }).catchError(
                            (error) => print("Failed to update user: $error"));
                      },
                      child: Text('Kirim'))
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
