import 'package:flutter/material.dart';
import 'package:online/constants/colors_res.dart';

class Shape {
  static BoxDecoration chooseCheckBox(BuildContext context) {
    return   BoxDecoration(
    color: const Color(0xFFE3C998),
    borderRadius: BorderRadius.circular(8),
    );
  }
  static BoxDecoration cCheckBox(BuildContext context) {
    return   BoxDecoration(
      color: const Color(0xFFF8F1F1),
      borderRadius: BorderRadius.circular(8),
    );
  }
  static BoxDecoration cameraView(BuildContext context) {
    return   BoxDecoration(
      color: Color(0xff4787b4),
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Color(0xff246b9d),
          offset: Offset(4, 4),
          blurRadius: 8,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: Color(0xff176daa),
          offset: Offset(-4, -4),
          blurRadius: 8,
          spreadRadius: 1,
        ),
      ],
    );
  }
  static BoxDecoration scrollText(BuildContext context) {
    return BoxDecoration(
      color: Colors.cyan.shade50,
      borderRadius: BorderRadius.circular(8),
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
  static BoxDecoration boxContainer(BuildContext context) {
    return BoxDecoration(
      color: AppColors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 4,
          offset: const Offset(0, 2), // Shadow positioning
        ),
      ],
      border: Border.all(
        color: Colors.white,
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
