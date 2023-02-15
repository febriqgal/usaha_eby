import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final c = Get.put(HistoryController());
    CollectionReference historyCollection =
        FirebaseFirestore.instance.collection('history');
    return StreamBuilder<QuerySnapshot?>(
        stream: c.collectionStreamHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final history = snapshot.data?.docs;
            return Scaffold(
                appBar: AppBar(
                  title: const Text('HistoryView'),
                  centerTitle: true,
                ),
                body: ListView.builder(
                  itemCount: history?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onLongPress: () {
                        AlertDialog alert = AlertDialog(
                          title: const Text("Pemberitahuan"),
                          content: const Text("Yakin untuk menghapus?"),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  historyCollection
                                      .doc(history?[index].id)
                                      .delete()
                                      .then((value) {})
                                      .catchError((e) {});
                                  Get.back();
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
                      title: Text(
                        '${(history?[index].data() as Map<String, dynamic>)['nama_produk']}',
                      ),
                      subtitle: Text(
                        '${(history?[index].data() as Map<String, dynamic>)['deskripsi_produk']}',
                      ),
                      trailing: Text(
                          '${(history?[index].data() as Map<String, dynamic>)['tanggal_beli']}'),
                    );
                  },
                ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
