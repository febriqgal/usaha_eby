import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> collectionStreamOrder = FirebaseFirestore.instance
      .collection("order")
      .orderBy('tanggal_beli', descending: true)
      .snapshots();
  Future<DocumentSnapshot<Object?>> getDetailOrder(String docID) async {
    DocumentReference docRef = firestore.collection("order").doc(docID);
    return await docRef.get();
  }
}
