import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<DocumentSnapshot<Object?>> getproduct(String docID) async {
    DocumentReference docRef = firestore.collection("product").doc(docID);
    return await docRef.get();
  }

  Stream<QuerySnapshot> collectionStream =
      FirebaseFirestore.instance.collection("product").snapshots();
}
