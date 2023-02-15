import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> collectionStream =
      FirebaseFirestore.instance.collection("product").snapshots();
  Stream<QuerySnapshot> collectionStreamPopular = FirebaseFirestore.instance
      .collection("product")
      .orderBy("terjual", descending: true)
      .limit(3)
      .snapshots();
  Future<DocumentSnapshot<Object?>> getproduct(String docID) async {
    DocumentReference docRef = firestore.collection("product").doc(docID);
    return await docRef.get();
  }
}
