import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme.dart';

class ChangeNameView extends StatelessWidget {
  const ChangeNameView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    TextEditingController changeNameC =
        TextEditingController(text: user?.displayName);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ganti Nama'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(
                14,
              ),
            ),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: changeNameC,
              decoration: const InputDecoration.collapsed(
                hintText: 'Ganti Nama',
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await user?.updateDisplayName(changeNameC.text);
              Get.back();
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
                  'Kirim',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
