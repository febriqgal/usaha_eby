import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  Stream<QuerySnapshot?> collectionStreamOrder = FirebaseFirestore.instance
      .collection("order")
      .orderBy('tanggal_beli', descending: true)
      .snapshots();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<DocumentSnapshot<Object?>> getDetailOrder(String docID) async {
    DocumentReference docRef = firestore.collection("order").doc(docID);
    return await docRef.get();
  }
}
