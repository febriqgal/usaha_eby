import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:usaha_eby/theme.dart';
import '../controllers/product_controller.dart';
import 'package:intl/intl.dart';

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

        TextEditingController jumlahbeliC = TextEditingController();
        TextEditingController pesan = TextEditingController();
        TextEditingController alamatC = TextEditingController();
        TextEditingController ongkirC = TextEditingController();
        TextEditingController namaC =
            TextEditingController(text: user?.displayName);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Checkout'),
          ),
          body: ListView(
            children: [
              //nama
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
                  controller: namaC,
                  maxLines: 1,
                  autocorrect: false,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Masukkan Nama Penerima',
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
              // ongkir
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: MultiSelectDropDown(
                  hint: 'Pilih Ekspedisi',
                  backgroundColor: kWhiteGreyColor,
                  onOptionSelected: (List<ValueItem> selectedOptions) {
                    if (selectedOptions[0].value == '1') {
                      ongkirC.text = '30000';
                    } else {
                      ongkirC.text = '20000';
                    }
                  },
                  options: const <ValueItem>[
                    ValueItem(
                        label: 'Rp 30K - Regular (1-3 Hari) ', value: '1'),
                    ValueItem(
                        label: 'Rp 20K -Non Regular (2-4 Hari)', value: '2'),
                  ],
                  selectionType: SelectionType.single,
                  chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                  dropdownHeight: 300,
                  optionTextStyle: const TextStyle(fontSize: 16),
                  selectedOptionIcon: const Icon(Icons.check_circle),
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
                        '${user?.uid}': '${user?.uid}',
                        'email': '${user?.email}',
                        'nama': '${user?.displayName}',
                        'foto': data['foto'],
                        "nama_produk": data['nama_produk'],
                        "varian": data['varian'],
                        "deskripsi_produk": data['deskripsi_produk'],
                        "harga": data['harga'],
                        "total": data['harga'] * int.parse(jumlahbeliC.text) +
                            int.parse(ongkirC.text),
                        "tanggal_beli": DateFormat("EEEE, d MMMM yyyy", "id_ID")
                            .add_Hm()
                            .format(DateTime.now())
                            .toString(),
                        "uid": user?.uid,
                        'status': 'Belum Bayar',
                        "jumlah_beli": int.parse(jumlahbeliC.text),
                        'pesan': pesan.text,
                        'alamat': alamatC.text,
                        'ongkir': int.parse(ongkirC.text),
                      });
                      await user?.updateDisplayName(namaC.text);
                      await product.doc('${snapshot.data?.id}').update({
                        'stok': data['stok'] - int.parse(jumlahbeliC.text),
                        'terjual': data['terjual'] + int.parse(jumlahbeliC.text)
                      });
                      Get.back();
                      Get.back();
                    }
                  } catch (e) {
                    print(e);
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
