import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/text_size_const.dart';

class ResultOutPutCard extends StatelessWidget {
  final String title;
  final String subTitle;
  const ResultOutPutCard(
      {super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: kText10BlueBlackColorStyle,
            ),
            5.width,
            Expanded(
              child: Text(
                subTitle,
                style: kText16BoldBlackColorStyle,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
