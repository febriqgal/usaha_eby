import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usaha_eby/app/modules/cart/views/cart_view.dart';
import 'package:usaha_eby/app/modules/login/views/login_view.dart';
import 'package:usaha_eby/app/modules/product/views/product_detail.dart';
import 'package:usaha_eby/app/modules/product/views/product_view.dart';
import 'package:usaha_eby/app/modules/profile/views/profile_view.dart';
import 'package:usaha_eby/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../controllers/home_controller.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: kWhiteGreyColor,
      body: Stack(
        children: [
          Image.asset(
            'assets/image_background.png',
          ),
          ListView(
            children: [
              // NOTE: HEADER/TITLE
              Container(
                margin: const EdgeInsets.only(top: 24),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: GestureDetector(
                  onTap: () {
                    user == null
                        ? Get.to(() => const LoginView())
                        : Get.to(() => const ProfileView());
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icon_profile_default.png',
                        width: 53,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      user == null
                          ? Container()
                          : Text(
                              user.email.toString(),
                              style: blackTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: bold,
                              ),
                            ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(const CartView());
                        },
                        child: Image.asset(
                          'assets/icon_cart.png',
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // NOTE: SEARCH BAR
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                    left: 24,
                    right: 24,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: kWhiteColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Search Funiture',
                        style: greyTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                      Image.asset(
                        'assets/icon_search.png',
                        width: 24,
                        color: kGreyColor,
                      ),
                    ],
                  ),
                ),
              ),
              // NOTE: POPULAR TITLE
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  left: 24,
                  right: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular',
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
              ),

              // NOTE: POPULAR CAROUSEL
              StreamBuilder<QuerySnapshot?>(
                  stream: controller.collectionStreamPopular,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final product = snapshot.data?.docs;
                      return Container(
                        margin: const EdgeInsets.only(top: 0),
                        child: CarouselSlider.builder(
                          itemCount: product?.length,
                          itemBuilder: (context, index, realIndex) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => const DetailPage(),
                                  arguments: product?[index].id,
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          width: 120, 'assets/original.png'),
                                      const SizedBox(
                                        width: 18,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${(product?[index].data() as Map<String, dynamic>)['nama_produk']}',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '${(product?[index].data() as Map<String, dynamic>)['varian']}',
                                          ),
                                          const SizedBox(
                                            height: 14,
                                          ),
                                          Text(
                                            'Rp ${(product?[index].data() as Map<String, dynamic>)['harga']}',
                                          ),
                                          Text(
                                            'Terjual ${(product?[index].data() as Map<String, dynamic>)['terjual']}',
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                              height: 140,
                              enableInfiniteScroll: false,
                              viewportFraction: 1,
                              onPageChanged: (value, _) {}),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),

              // NOTE: POPULAR CAROUSEL INDICATOR
              Container(
                margin: const EdgeInsets.only(
                  top: 13,
                  left: 24,
                  right: 24,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kLineDarkColor,
                      ),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kLineDarkColor,
                      ),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kLineDarkColor,
                      ),
                    ),
                  ],
                ),
              ),

              // NOTE: POPULAR SECTION
              Container(
                margin: const EdgeInsets.only(top: 24),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                  color: kWhiteColor,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 24,
                        left: 24,
                        right: 24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Product',
                            style: blackTextStyle.copyWith(
                              fontSize: 24,
                              fontWeight: semiBold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(const ProductView());
                            },
                            child: const Text('Show All'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    StreamBuilder<QuerySnapshot?>(
                        stream: controller.collectionStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            final product = snapshot.data?.docs;
                            return GridView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: product?.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                mainAxisExtent: 300,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    (product?[index].data() as Map<String,
                                                dynamic>)['stok'] <=
                                            0
                                        ? Get.snackbar(
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
                                                child:
                                                    Text('Stok Sudah Habis')),
                                            snackStyle: SnackStyle.GROUNDED,
                                            backgroundColor: Colors.white,
                                            barBlur: 0.5,
                                          )
                                        : Get.to(
                                            () => const DetailPage(),
                                            arguments: product?[index].id,
                                          );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 20,
                                          offset: const Offset(0,
                                              10), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          height: 180,
                                          'assets/original.png',
                                        ),
                                        ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${(product?[index].data() as Map<String, dynamic>)['nama_produk']}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                '${(product?[index].data() as Map<String, dynamic>)['stok']}',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                          subtitle: Text(
                                            'Rp ${(product?[index].data() as Map<String, dynamic>)['harga']}',
                                            style: greyTextStyle.copyWith(
                                              fontWeight: semiBold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
