import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usaha_eby/app/modules/login/views/login_view.dart';

class SignupController extends GetxController {
  TextEditingController emailDaftarC = TextEditingController();
  TextEditingController passDaftarC = TextEditingController();
  singup() async {
    if (emailDaftarC.text.isEmpty || passDaftarC.text.isEmpty) {
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
            const Center(child: Text('Email dan password tidak boleh kosong')),
        snackStyle: SnackStyle.GROUNDED,
        backgroundColor: Colors.white,
        barBlur: 0.5,
      );
    }
    try {
      // ignore: unused_local_variable
      UserCredential myuser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailDaftarC.text,
        password: passDaftarC.text,
      );
      Get.to(const LoginView());
      Get.snackbar(
        '-',
        '-',
        titleText: const Center(
          child: Text(
            'Berhasil',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        messageText: const Center(
            child: Text(
          'Akun berhasil dibuat, silahkan login.',
        )),
        snackStyle: SnackStyle.GROUNDED,
        backgroundColor: Colors.white,
        barBlur: 0.5,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
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
              child: Text('Kata sandi yang diberikan terlalu lemah.')),
          snackStyle: SnackStyle.GROUNDED,
          backgroundColor: Colors.white,
          barBlur: 0.5,
        );
      } else if (e.code == 'email-already-in-use') {
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
                  'Email sudah digunakan, silahkan daftar dengan email lain')),
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
                'Tidak bisa login, silahkan coba lagi atau hubungi admin')),
        snackStyle: SnackStyle.GROUNDED,
        backgroundColor: Colors.white,
        barBlur: 0.5,
      );
    }
  }
}
