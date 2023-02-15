import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usaha_eby/app/modules/cart/views/cart_view.dart';
import 'package:usaha_eby/theme.dart';
import '../controllers/product_controller.dart';

class CheckoutView extends GetView<ProductController> {
  const CheckoutView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    var cont = Get.put(ProductController());
    CollectionReference order = FirebaseFirestore.instance.collection('order');
    CollectionReference product =
        FirebaseFirestore.instance.collection('product');
    return FutureBuilder(
      future: cont.getproduct(Get.arguments),
      builder: (context, snapshot) {
        var data = snapshot.data!.data() as Map<String, dynamic>;
        print(snapshot.data?.id);
        TextEditingController namaProdukC =
            TextEditingController(text: data['nama_produk']);
        TextEditingController varianC =
            TextEditingController(text: data['varian']);
        TextEditingController deskripsiProdukC = TextEditingController(
          text: data['deskripsi_produk'],
        );
        TextEditingController hargaC = TextEditingController(
          text: 'Rp ${data['harga']}',
        );
        TextEditingController jumlahbeliC = TextEditingController();
        TextEditingController pesan = TextEditingController();
        TextEditingController alamatC = TextEditingController();
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Checkout'),
          ),
          body: ListView(
            children: [
              // nama produk
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
                  readOnly: true,
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
              //deskripsi
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
                  readOnly: true,
                  maxLines: 1,
                  autocorrect: false,
                  controller: deskripsiProdukC,
                  decoration: InputDecoration.collapsed(
                    hintText: 'deskripsi',
                    hintStyle: greyTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ),
              // varian
              Container(
                margin: const EdgeInsets.only(
                  top: 9,
                  left: 18,
                  right: 18,
                ),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kWhiteGreyColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  readOnly: true,
                  maxLines: 1,
                  autocorrect: false,
                  controller: varianC,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Nama Produk',
                    hintStyle: greyTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ),
              // harga
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
                  readOnly: true,
                  maxLines: 1,
                  autocorrect: false,
                  controller: hargaC,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Nama Produk',
                    hintStyle: greyTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ),
              //Alamat
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
                  controller: alamatC,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Alamat lengkap',
                    hintStyle: greyTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ),

              //Pesan
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
                  controller: pesan,
                  autocorrect: false,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Masukkan pesan',
                    hintStyle: greyTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ),
              //jumlah beli
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
                child: Column(
                  children: [
                    TextField(
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      controller: jumlahbeliC,
                      autocorrect: false,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Masukkan jumlah beli',
                        hintStyle: greyTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                    Text('Tersisa ${data['stok']}')
                  ],
                ),
              ),

              GestureDetector(
                onTap: () async {
                  try {
                    if (int.parse(jumlahbeliC.value.text) > data['stok']) {
                      Get.snackbar(
                        '-',
                        '-',
                        titleText: const Center(
                          child: Text(
                            'Terjadi Kesalahan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        messageText: Center(
                            child: Text('Stok tersisa hanya ${data['stok']}')),
                        snackStyle: SnackStyle.GROUNDED,
                        backgroundColor: Colors.white,
                      );
                    } else {
                      await order.add({
                        "nama_produk": data['nama_produk'],
                        "varian": data['varian'],
                        "deskripsi_produk": data['deskripsi_produk'],
                        "harga": data['harga'] * int.parse(jumlahbeliC.text),
                        "tanggal_beli": DateTime.now().toIso8601String(),
                        "uid": user?.uid,
                        'status': 'Belum Bayar',
                        'pesan': pesan.text,
                        'alamat': alamatC.text,
                      });
                      await product.doc('${snapshot.data?.id}').update(
                          {'stok': data['stok'] - int.parse(jumlahbeliC.text)});
                      Get.to(() => const CartView());
                    }
                  } catch (e) {
                    Get.snackbar(
                      '-',
                      '-',
                      titleText: const Center(
                        child: Text(
                          'Kesalahan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      messageText: const Center(
                          child: Text(
                              'Gagal menambahkan berita🥺, silahkan coba lagi!')),
                      snackStyle: SnackStyle.GROUNDED,
                      backgroundColor: Colors.white,
                    );
                  }
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
                      'Masukkan kerangjang',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
