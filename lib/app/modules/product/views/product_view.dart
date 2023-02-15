import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usaha_eby/app/modules/product/views/product_detail.dart';
import '../../../../theme.dart';
import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final c = Get.put(ProductController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.withOpacity(0),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('ProductView'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot?>(
          stream: c.collectionStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final product = snapshot.data?.docs;
              return GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: product?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: 300,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => const DetailPage(),
                        arguments: product?[index].id,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 20,
                            offset: const Offset(
                                0, 10), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            height: 180,
                            'assets/original.png',
                          ),
                          ListTile(
                            title: Text(
                              '${(product?[index].data() as Map<String, dynamic>)['nama_produk']}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Rp ${(product?[index].data() as Map<String, dynamic>)['harga']}',
                              style: greyTextStyle.copyWith(
                                fontWeight: semiBold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
