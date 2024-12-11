import 'package:flutter/material.dart';
import 'package:online/constants/colors_res.dart';

class Shape {
  static BoxDecoration chooseCheckBox(BuildContext context) {
    return BoxDecoration(
      color: const Color(0xFFE3C998),
      borderRadius: BorderRadius.circular(8),
    );
  }

  static BoxDecoration cCheckBox(BuildContext context) {
    return BoxDecoration(
      color: const Color(0xFFF8F1F1),
      borderRadius: BorderRadius.circular(8),
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

  static BoxDecoration cameraView(BuildContext context) {
    return BoxDecoration(
      color: const Color(0xff204867),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
        color: Colors.blueGrey,
        width: 1.0,
      ),
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
