import 'package:flutter/material.dart';

import '../../../../theme.dart';

class HomePopularItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const HomePopularItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/popular');
      },
      child: SizedBox(
        height: 123,
        width: MediaQuery.of(context).size.width - (2 * 24),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 108,
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 150,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          subtitle,
                          style: greyTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -40,
              child: Image.asset(
                imageUrl,
                height: 180,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
