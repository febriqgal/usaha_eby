import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<DocumentSnapshot<Object?>> getHistory(String docID) async {
    DocumentReference docRef = firestore.collection("history").doc(docID);
    return await docRef.get();
  }

  Stream<QuerySnapshot> collectionStreamHistory = FirebaseFirestore.instance
      .collection("history")
      .orderBy('${FirebaseAuth.instance.currentUser?.uid}')
      .snapshots();
}
