
import 'package:flutter/material.dart';
import 'package:online/constants/text_size_const.dart';


class TitleValueTextFormData extends StatelessWidget {
  final String title;
  final String subTitle;
  const TitleValueTextFormData(
      {super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: kTextBlue,
                ),
                const TextSpan(
                  text: "  ",
                ),
                const WidgetSpan(
                    child: SizedBox(width: 6,)
                ),
                TextSpan(
                  text:subTitle,
                  style: kText13BoldBlackColorStyle,
                ),
                const TextSpan(
                  text: '  *',
                  style: kText16BoldRed,
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
