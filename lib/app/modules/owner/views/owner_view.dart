import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/owner_controller.dart';

class OwnerView extends GetView<OwnerController> {
  const OwnerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OwnerView'),
        centerTitle: true,
      ),
      body: ListTile(
        onTap: () {},
        title: const Text('Tambah Barang'),
        trailing: const Icon(Icons.arrow_right),
      ),
    );
  }
}
