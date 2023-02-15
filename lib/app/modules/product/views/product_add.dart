import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usaha_eby/theme.dart';
import '../controllers/product_controller.dart';

class ProductAdd extends GetView<ProductController> {
  const ProductAdd({super.key});

  @override
  Widget build(BuildContext context) {
    var cont = Get.put(ProductController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tambah Product'),
      ),
      body: ListView(children: [
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
            controller: cont.namaProdukC,
            decoration: InputDecoration.collapsed(
              hintText: 'Nama Produk',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ),
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
            controller: cont.varianC,
            decoration: InputDecoration.collapsed(
              hintText: 'Varian',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ),
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
            controller: cont.deskripsiProdukC,
            decoration: InputDecoration.collapsed(
              hintText: 'Deskripsi Produk',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ),
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
            controller: cont.hargaC,
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
            controller: cont.stokC,
            decoration: InputDecoration.collapsed(
              hintText: 'Stok',
              hintStyle: greyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ),
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
          child: const Center(
            child: Text(
              'Pilih Gambar',
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            cont.tambahProduct();
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
      ]),
    );
  }
}
