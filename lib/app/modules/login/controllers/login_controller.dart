import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailLoginC = TextEditingController();
  TextEditingController passLoginC = TextEditingController();
  TextEditingController emailResetC = TextEditingController();

  login() async {
    if (emailLoginC.text.isEmpty || passLoginC.text.isEmpty) {
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
        messageText:
            const Center(child: Text('Email atau password tidak boleh kosong')),
        snackStyle: SnackStyle.GROUNDED,
        backgroundColor: Colors.white,
        barBlur: 0.5,
      );
    } else {
      try {
        // ignore: unused_local_variable
        UserCredential myUser =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailLoginC.text,
          password: passLoginC.text,
        );

        Get.offAllNamed(Routes.HOME);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
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
            messageText: const Center(child: Text('Email tidak terdaftar')),
            snackStyle: SnackStyle.GROUNDED,
            backgroundColor: Colors.white,
            barBlur: 0.5,
          );
        } else if (e.code == 'wrong-password') {
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
            messageText:
                const Center(child: Text('Password yang dimasukan salah')),
            snackStyle: SnackStyle.GROUNDED,
            backgroundColor: Colors.white,
            barBlur: 0.5,
          );
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
                  'Terjadi Kesalahan, silahkan diulang lagi atau hubungi admin')),
          snackStyle: SnackStyle.GROUNDED,
          backgroundColor: Colors.white,
        );
      }
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
