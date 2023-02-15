import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usaha_eby/app/modules/admin/views/forn_edit_product_view.dart';
import '../controllers/admin_controller.dart';

class EditProductView extends GetView<AdminController> {
  const EditProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final adminC = Get.put(AdminController());
    return StreamBuilder<QuerySnapshot>(
        stream: adminC.collectionStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final product = snapshot.data?.docs;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Edit Produk'),
              ),
              body: ListView.builder(
                itemCount: product?.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      AlertDialog alert = AlertDialog(
                        title: const Text("Pemberitahuan"),
                        content: const Text("Yakin untuk menghapus?"),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                await adminC.product
                                    .doc(product?[index].id)
                                    .delete()
                                    .then((value) {
                                  Get.back();
                                  Get.back();
                                }).catchError((error) =>
                                        // ignore: invalid_return_type_for_catch_error
                                        print("Failed to delete user: $error"));
                              },
                              child: const Text('Hapus')),
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('Batal'),
                          ),
                        ],
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                    onTap: () {
                      Get.to(
                        () => const FormEditProductView(),
                        arguments: product?[index].id,
                      );
                    },
                    child: Card(
                      child: Container(
                        height: 100,
                        color: Colors.amber,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/original.png',
                            ),
                            Text(
                              '${(product?[index].data() as Map<String, dynamic>)['nama_produk']}',
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
