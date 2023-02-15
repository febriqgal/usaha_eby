import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usaha_eby/app/modules/admin/views/admin_view.dart';
import 'package:usaha_eby/app/modules/home/views/home_view.dart';
import 'package:usaha_eby/app/modules/login/views/login_view.dart';
import 'package:usaha_eby/app/modules/profile/views/cs.dart';
import 'package:usaha_eby/app/modules/profile/views/editprofile_view.dart';
import 'package:usaha_eby/app/modules/profile/views/faq.dart';
import 'package:usaha_eby/app/modules/profile/views/myaddress_view.dart';
import 'package:usaha_eby/app/modules/profile/views/payment_view.dart';
import '../../../../theme.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isLightMode = true;
  double opacity = 1;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: opacity,
      child: Scaffold(
        backgroundColor: kWhiteGreyColor,
        body: Stack(
          children: [
            Image.asset(
              'assets/image_background.png',
              color: isLightMode ? null : const Color(0xffD8D8D8),
            ),
            ListView(
              children: [
                const SizedBox(
                  height: 130,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 24,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/icon_profile_default.png',
                            width: 120,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          user == null
                              ? Container()
                              : Text(
                                  user!.email.toString(),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 24,
                                    fontWeight: medium,
                                    color:
                                        isLightMode ? kBlackColor : kWhiteColor,
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  padding: const EdgeInsets.symmetric(
                    vertical: 32,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(36),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(36),
                          bottom: Radius.circular(36),
                        ),
                        color: kWhiteColor),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Get.to(const AdminView());
                          },
                          leading:
                              Image.asset(width: 24, 'assets/icon_profile.png'),
                          trailing: const Icon(Icons.chevron_right),
                          title: const Text('Dashboard Admin'),
                        ),
                        ListTile(
                          onTap: () {
                            Get.to(const EditProfileView());
                          },
                          leading:
                              Image.asset(width: 24, 'assets/icon_profile.png'),
                          trailing: const Icon(Icons.chevron_right),
                          title: const Text('Edit Profile'),
                        ),
                        ListTile(
                          onTap: () {
                            Get.to(const MyAddressView());
                          },
                          leading:
                              Image.asset(width: 24, 'assets/icon_address.png'),
                          trailing: const Icon(Icons.chevron_right),
                          title: const Text('Alamat saya'),
                        ),
                        ListTile(
                          onTap: () {
                            Get.to(const PaymentView());
                          },
                          leading:
                              Image.asset(width: 24, 'assets/icon_payment.png'),
                          trailing: const Icon(Icons.chevron_right),
                          title: const Text('Pembayaran'),
                        ),
                        ListTile(
                          onTap: () {
                            Get.to(const FaqView());
                          },
                          leading:
                              Image.asset(width: 24, 'assets/icon_faq.png'),
                          trailing: const Icon(Icons.chevron_right),
                          title: const Text('Faq'),
                        ),
                        ListTile(
                          onTap: () {
                            Get.to(const CsView());
                          },
                          leading: Image.asset(width: 24, 'assets/icon_cs.png'),
                          trailing: const Icon(Icons.chevron_right),
                          title: const Text('CS'),
                        ),
                        user == null
                            ? Center(
                                child: TextButton(
                                  onPressed: () async {
                                    Get.off(const LoginView());
                                  },
                                  child: const Text(
                                    'Login',
                                  ),
                                ),
                              )
                            : Center(
                                child: TextButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut();
                                    await GoogleSignIn().signOut();
                                    Get.off(const HomeView());
                                  },
                                  child: const Text(
                                    'Keluar',
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
