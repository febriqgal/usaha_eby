// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usaha_eby/app/modules/home/controllers/home_controller.dart';
import 'package:usaha_eby/app/modules/login/views/login_view.dart';
import 'package:usaha_eby/app/modules/product/views/cheackout.dart';
import 'package:usaha_eby/app/modules/product/views/review_item.dart';
import 'package:usaha_eby/theme.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Color indicatorColor = const Color(0xff394A54);
  double indicatorMargin = 5;
  int currentIndex = 1;
  bool isExpand = false;
  bool isShowReview = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    var c = Get.put(HomeController());
    return FutureBuilder(
        future: c.getproduct(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data?.data() as Map<String?, dynamic>;

            return Scaffold(
                backgroundColor: kWhiteGreyColor,
                extendBody: true,
                body: Stack(
                  children: [
                    Image.asset(
                      'assets/image_background.png',
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 60),
                      child: Image.network(
                        '${data['foto']}',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 66,
                          left: 20,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kWhiteColor,
                          border: Border.all(
                            color: kLineDarkColor,
                          ),
                        ),
                        child: const Icon(
                          Icons.chevron_left,
                        ),
                      ),
                    ),
                    SizedBox.expand(
                      child: DraggableScrollableSheet(
                        initialChildSize: 0.4,
                        minChildSize: 0.4,
                        maxChildSize: 0.95,
                        builder: (BuildContext build,
                            ScrollController scrollController) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(40),
                              ),
                              color: kWhiteColor,
                            ),
                            child: NotificationListener(
                              onNotification: (Notification notif) {
                                if (notif is ScrollEndNotification) {
                                  if (notif.metrics.minScrollExtent == -1.0) {
                                  } else {}
                                }
                                return true;
                              },
                              child: SingleChildScrollView(
                                controller: scrollController,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Center(
                                        child: Container(
                                          width: 30,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: kLineDarkColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data['nama_produk'],
                                            style: blackTextStyle.copyWith(
                                              fontSize: 24,
                                              fontWeight: semiBold,
                                            ),
                                          ),
                                          Text(
                                            'Rp. ${data['harga'].toString()}',
                                            style: blackTextStyle.copyWith(
                                              fontSize: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        data['varian'],
                                        style: blackTextStyle.copyWith(
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        data['deskripsi_produk'],
                                        style: greyTextStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: semiBold,
                                          height: 1.8,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      isShowReview
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Review',
                                                  style:
                                                      blackTextStyle.copyWith(
                                                    fontSize: 24,
                                                    fontWeight: semiBold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const ReviewItem(
                                                  name: 'Lydia Clayton',
                                                  imageUrl:
                                                      'assets/image_reviewer1.png',
                                                  review:
                                                      'Open repair of infrarenal aortic aneurysm or dissection, plus of a repair of associated arterial...',
                                                  items: [
                                                    'assets/image_product_list1.png',
                                                    'assets/image_product_list2.png',
                                                    'assets/image_product_list3.png',
                                                  ],
                                                ),
                                                const ReviewItem(
                                                  name: 'Audra Still',
                                                  imageUrl:
                                                      'assets/image_reviewer2.png',
                                                  review:
                                                      'Open repair of infrarenal aortic aneurysm or dissection, plus of a repair of associated arterial...',
                                                  items: [
                                                    'assets/image_product_list3.png',
                                                    'assets/image_product_list4.png',
                                                  ],
                                                ),
                                                const ReviewItem(
                                                  name: 'Joan Gray',
                                                  imageUrl:
                                                      'assets/image_reviewer3.png',
                                                  review:
                                                      'Open repair of infrarenal aortic aneurysm or dissection, plus of a repair of associated arterial...',
                                                  items: [
                                                    'assets/image_product_list2.png',
                                                    'assets/image_product_list3.png',
                                                  ],
                                                ),
                                              ],
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: isShowReview
                    ? null
                    : isExpand
                        ? Container(
                            width: double.infinity,
                            height: 315,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  kWhiteColor.withOpacity(0.5),
                                  kWhiteColor,
                                ],
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isShowReview = true;
                                    });
                                  },
                                  child: Text(
                                    'See More',
                                    style: blueTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: kWhiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: kGreyColor,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 56,
                                    child: TextButton(
                                      onPressed: () {
                                        user != null
                                            ? Get.to(() => const CheckoutView(),
                                                arguments: snapshot.data?.id)
                                            : Get.to(const LoginView());
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: kBlackColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                      ),
                                      child: Text(
                                        'Beli',
                                        style: whiteTextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
