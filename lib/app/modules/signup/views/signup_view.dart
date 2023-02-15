import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Daftar',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 48,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: controller.namaC,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Nama',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 16,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: controller.emailDaftarC,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Email',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 16,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                  ),
                  child: TextField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: controller.passDaftarC,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Password',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 16,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: controller.noHpC,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'No. HP',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 500.0,
                  child: ElevatedButton(
                    child: const Text('Daftar'),
                    onPressed: () {
                      controller.singup();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
