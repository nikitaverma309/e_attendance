import 'package:flutter/material.dart';

import '../../constants/colors_res.dart';

class Shape {
  static BoxDecoration choosePdfWhite(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.white,
        width: 1.0,
      ),
      color: Colors.white,
    );
  }



  static BoxDecoration purpleContainerDecoration(BuildContext context) {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          offset: const Offset(-3.0, -3.0),
          blurRadius: 2.0,
        ),
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          offset: const Offset(3.0, 3.0),
          blurRadius: 2.0,
        ),
      ],
      color: const Color(0xFDE9E9F5),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  static Card getStyledCard(BuildContext context, List<Widget> children) {
    return Card(
      elevation: 0.0,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Colors.white,
          width: 1.0,
        ),
      ),
      color: Colors.white,
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: purpleContainerDecoration(context),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  static BoxDecoration singleDataDecoration(BuildContext context) {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: AppColors.athensGray.withOpacity(0.3),
          offset: const Offset(-2.0, -2.0),
          blurRadius: 2.0,
        ),
        BoxShadow(
          color: AppColors.athensGray.withOpacity(0.2),
          offset: const Offset(2.0, 2.0),
          blurRadius: 2.0,
        ),
      ],
      color: const Color(0xFD365E6C),
      border: Border.all(
        color: Colors.white,
        width: 1.0, // Set the border width here
      ),
      borderRadius: BorderRadius.circular(5.0),
    );
  }

  //error Container Red
  static BoxDecoration submitContainerRed(BuildContext context) {
    return BoxDecoration(
      color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2), // Shadow positioning
          ),
        ],
      border: Border.all(
        color: Colors.black,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(2.0),
    );
  }

  //error Container Red
  static BoxDecoration errorContainerRed(BuildContext context) {
    return BoxDecoration(
      color: AppColors.redShade4,
      border: Border.all(
        color: Colors.white,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(10.0),
    );
  }
}
