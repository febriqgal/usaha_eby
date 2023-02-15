import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference product =
      FirebaseFirestore.instance.collection('product');
  Stream<QuerySnapshot> collectionStream =
      FirebaseFirestore.instance.collection("product").snapshots();
  TextEditingController namaProdukC = TextEditingController();
  TextEditingController varianC = TextEditingController();
  TextEditingController deskripsiProdukC = TextEditingController();
  TextEditingController hargaC = TextEditingController();
  TextEditingController stokC = TextEditingController();
  Future<DocumentSnapshot<Object?>> getproduct(String docID) async {
    DocumentReference docRef = firestore.collection("product").doc(docID);
    return await docRef.get();
  }

  Future<void> tambahProduct() async {
    try {
      await product.add(
        {
          "nama_produk": namaProdukC.text,
          "varian": varianC.text,
          "deskripsi_produk": deskripsiProdukC.text,
          "harga": int.parse(hargaC.text),
          "stok": int.parse(stokC.text),
          "tanggal": DateTime.now().toIso8601String(),
          "terjual": 0,
        },
      );
      Get.back();
      Get.snackbar(
        '-',
        '-',
        titleText: const Center(
          child: Text(
            'Berhasil',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        messageText:
            const Center(child: Text('Yeayy! Berhasil menambahkan berita🎉')),
        snackStyle: SnackStyle.GROUNDED,
        backgroundColor: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        '-',
        '-',
        titleText: const Center(
          child: Text(
            'Kesalahan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        messageText: const Center(
            child: Text('Gagal menambahkan berita🥺, silahkan coba lagi!')),
        snackStyle: SnackStyle.GROUNDED,
        backgroundColor: Colors.white,
      );
    }
  }
}
