import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class StatusView extends GetView<CartController> {
  const StatusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final c = Get.put(CartController());
    CollectionReference order = FirebaseFirestore.instance.collection('order');

    return FutureBuilder(
        future: c.getDetailOrder(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data?.data() as Map<String?, dynamic>;
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
                          }).catchError((error) =>
                              print("Failed to update user: $error"));
                          await order
                              .doc(snapshot.data?.id)
                              .delete()
                              .then((value) => null)
                              .catchError((error) =>
                                  print("Failed to update user: $error"));
                                  
                        },
                        child: Text('Pesanan diterima'))
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
