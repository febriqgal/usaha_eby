import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CartController extends GetxController {
  CollectionReference order = FirebaseFirestore.instance.collection('order');

  File? imageeee;
  final storageRef = FirebaseStorage.instance.ref();
  final ImagePicker picker = ImagePicker();
  final user = FirebaseAuth.instance.currentUser;
  Stream<QuerySnapshot?> collectionStreamOrder = FirebaseFirestore.instance
      .collection("order")
      .orderBy('${FirebaseAuth.instance.currentUser?.uid}')
      .snapshots();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<DocumentSnapshot<Object?>> getDetailOrder(String docID) async {
    DocumentReference docRef = firestore.collection("order").doc(docID);
    return await docRef.get();
  }

  Future<void> pickfotoberita(params) async {
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
        final mountainImagesRef = storageRef
            .child("Bukti_Pembayaran/${imageeee.path.split('/').last}");
        Get.defaultDialog(
          barrierDismissible: false,
          radius: 5,
          title: 'Pemberitahuan',
          middleText: 'Sedang mengupload...',
        );
        await mountainImagesRef.putFile(
          file,
        );
        await order.doc(params).update({
          'bukti': 'ini bukti',
          "status": 'Menunggu Konfirmas Pembayaran',
          "foto":
              'https://firebasestorage.googleapis.com/v0/b/usaha-eby.appspot.com/o/Bukti_Pembayaran%2F${imageeee.path.split('/').last}?alt=media&token=ec35edf7-da87-48cd-8bfc-300bc50430e8',
          'fotoName': imageeee.path.split('/').last,
        }).then((value) {
          Get.back();
        }).catchError((error) {});
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
}
