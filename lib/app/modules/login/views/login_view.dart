import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:usaha_eby/app/modules/home/views/home_view.dart';
import 'package:usaha_eby/app/modules/login/views/title.dart';
import 'package:usaha_eby/app/modules/signup/views/signup_view.dart';
import 'package:usaha_eby/theme.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Column(
              children: [
                const TitleW(),
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
                          controller: controller.emailLoginC,
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Email',
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 32,
                        ),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(
                            14,
                          ),
                        ),
                        child: TextField(
                          controller: controller.passLoginC,
                          obscureText: true,
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Password',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 56,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 32),
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                            backgroundColor: kBlackColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text('Login'),
                          onPressed: () {
                            controller.login();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        'OR',
                        style: TextStyle(
                          color: kGreyColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await controller.signInWithGoogle();
                          Get.offAll(const HomeView());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: kBlackColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/google.png',
                                  width: 38,
                                  height: 38,
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                const Text(
                                  'Login With Google',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don’t have an account?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: kGreyColor,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(const SignupView());
                              },
                              child: const Text('SignUp')),
                        ],
                      ),
                    ],
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
