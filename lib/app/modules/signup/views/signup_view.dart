import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
                TextField(
                    controller: controller.emailDaftarC,
                    decoration: const InputDecoration(hintText: 'Email')),
                TextField(
                    controller: controller.passDaftarC,
                    obscureText: true,
                    decoration: const InputDecoration(hintText: 'Password')),
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
