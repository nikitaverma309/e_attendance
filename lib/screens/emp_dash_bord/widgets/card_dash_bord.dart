import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/colors_res.dart';

class DashBordCard extends StatelessWidget {
  final String title;
  final String image;
  final String numberTwo;

  final VoidCallback? onPressed;

  const DashBordCard({
    super.key,
    required this.title,
    required this.image,
    this.onPressed,
    required this.numberTwo,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 650),
      child: GestureDetector(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.09,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(196, 209, 218, 0.6313725490196078),
                      offset: Offset(3.0, 3.0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    12.height,
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: '\u2191',
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: '+$numberTwo',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                    5.height,
                    Expanded(
                      child: Text(
                        title,
                        style: boldTextStyle(size: 13, color: AppColors.black),
                        // style: kText1012BoldBlackColorStyle,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
