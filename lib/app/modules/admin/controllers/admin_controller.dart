import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AdminController extends GetxController {
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

  File? imageeee;
  final storageRef = FirebaseStorage.instance.ref();
  final ImagePicker picker = ImagePicker();
  final user = FirebaseAuth.instance.currentUser;
  Stream<QuerySnapshot> collectionStreamOrder = FirebaseFirestore.instance
      .collection("order")
      .orderBy('tanggal_beli', descending: true)
      .snapshots();
  Future<DocumentSnapshot<Object?>> getDetailOrder(String docID) async {
    DocumentReference docRef = firestore.collection("order").doc(docID);
    return await docRef.get();
  }

  Future<void> pickfotoberita() async {
    final XFile? imageeee = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 500,
    );
    if (imageeee != null) {
      File file = File(imageeee.path);
      var adminView = this;
      adminView.imageeee = file;
      try {
        final mountainImagesRef =
            storageRef.child("Produk/${imageeee.path.split('/').last}");
        Get.defaultDialog(
          barrierDismissible: false,
          radius: 5,
          title: 'Pemberitahuan',
          middleText: 'Sedang mengupload...',
        );
        await mountainImagesRef.putFile(
          file,
        );

        Get.back();
        Get.defaultDialog(
          confirm: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.amber,
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          ),
          radius: 5,
          title: 'Berhasil',
          middleText: 'Yeayy! berhasil🔥',
        );
      } catch (e) {
        Get.defaultDialog(
            title: 'Pemberitahuan',
            middleText: 'Gagal mengupload, silahkan coba lagi!');
      }
    } else {
      Get.defaultDialog(
          radius: 5,
          title: 'Pemberitahuan',
          middleText: 'membatalkan mengupload');
    }
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
          "tanggal": DateFormat("EEEE, d MMMM yyyy", "id_ID")
              .add_Hm()
              .format(DateTime.now())
              .toString(),
          "terjual": 0,
          "status": 'Menunggu Konfirmas Pembayaran',
          "foto":
              'https://firebasestorage.googleapis.com/v0/b/usaha-eby.appspot.com/o/Produk%2F${imageeee?.path.split('/').last}?alt=media&token=9d3fcebf-b2b4-4970-af1d-952a299a4ba6',
          'fotoName': imageeee?.path.split('/').last,
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
