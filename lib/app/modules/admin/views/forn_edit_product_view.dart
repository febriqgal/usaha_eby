import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usaha_eby/app/modules/admin/controllers/admin_controller.dart';

import '../../../../theme.dart';

class FormEditProductView extends GetView<AdminController> {
  const FormEditProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final adminC = Get.put(AdminController());

    return FutureBuilder(
        future: adminC.getproduct(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data?.data() as Map<String?, dynamic>;
            TextEditingController namaProdukC = TextEditingController(
              text: data['nama_produk'],
            );
            TextEditingController varianC = TextEditingController(
              text: data['varian'],
            );
            TextEditingController deskripsiProdukC = TextEditingController(
              text: data['deskripsi_produk'],
            );
            TextEditingController hargaC = TextEditingController(
              text: data['harga'].toString(),
            );
            TextEditingController stokC = TextEditingController(
              text: data['stok'].toString(),
            );
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  data['nama_produk'],
                ),
              ),
              body: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 24, top: 16),
                    child: Text('Nama Produk:'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 18,
                      left: 18,
                      right: 18,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: kWhiteGreyColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      maxLines: 1,
                      autocorrect: false,
                      controller: namaProdukC,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Nama Produk',
                        hintStyle: greyTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 24, top: 16),
                    child: Text('Varian:'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 18,
                      left: 18,
                      right: 18,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: kWhiteGreyColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      maxLines: 1,
                      autocorrect: false,
                      controller: varianC,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Varian',
                        hintStyle: greyTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 24, top: 16),
                    child: Text('Deskripsi Produk:'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 18,
                      left: 18,
                      right: 18,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: kWhiteGreyColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      maxLines: 3,
                      autocorrect: false,
                      controller: deskripsiProdukC,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Deskripsi Produk',
                        hintStyle: greyTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 24, top: 16),
                    child: Text('Harga:'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 18,
                      left: 18,
                      right: 18,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: kWhiteGreyColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      controller: hargaC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Harga',
                        hintStyle: greyTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 24, top: 16),
                    child: Text('Stok:'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 18,
                      left: 18,
                      right: 18,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: kWhiteGreyColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      controller: stokC,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Stok',
                        hintStyle: greyTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 18,
                        left: 18,
                        right: 18,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kWhiteGreyColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Text(
                          'Hapus',
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      adminC.product.doc(snapshot.data?.id).update(
                        {
                          "nama_produk": namaProdukC.text,
                          "varian": varianC.text,
                          "deskripsi_produk": deskripsiProdukC.text,
                          "harga": int.parse(hargaC.text),
                          "stok": int.parse(stokC.text),
                        },
                      ).then((value) {
                        Get.back();
                      }).catchError(
                          (error) => print("Failed to update user: $error"));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 18,
                        left: 18,
                        right: 18,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Text(
                          'Kirim',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
