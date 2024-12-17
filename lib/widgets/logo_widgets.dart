import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/generated/assets.dart';

class CustomLogoWidget extends StatelessWidget {
  const CustomLogoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Adjust logo size based on screen dimensions
    final logoSize = screenWidth * 0.25; // 25% of screen width

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              color: const Color(0xffb8cbd8),
              elevation: 6,
              child: const Image(
                image: AssetImage(Assets.imagesCglogo),
                height: 88,
                width: 88,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        10.height,
        const Text("Higher Education Department",
            style: kText15whiteColorStyle),
        const Text("Government Of Chhattisgarh",
            style: kText15BaNaBoldWhiteColorStyle),
      ],
    );
  }
}
