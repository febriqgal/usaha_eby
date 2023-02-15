import 'package:flutter/material.dart';
import 'package:usaha_eby/theme.dart';

class TitleW extends StatelessWidget {
  const TitleW({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 40,
        left: 24,
        right: 24,
        bottom: 93,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Login to your\naccount',
              style: TextStyle(
                fontSize: 24,
                fontWeight: bold,
                color: kBlackAccentColor,
              )),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 4),
                width: 87,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: kBlackColor,
                ),
              ),
              Container(
                width: 8,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: kBlackColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
