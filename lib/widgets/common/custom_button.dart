import 'package:flutter/material.dart';
import 'package:online/constants/colors_res.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Updated to use MediaQuery
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(screenHeight * 0.02), // Updated to use MediaQuery
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03), // Updated to use MediaQuery
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.03), // Updated to use MediaQuery
                child: Text(
                  text,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: screenHeight * 0.025, // Updated to use MediaQuery
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              CircleAvatar(
                radius: screenHeight * 0.03, // Updated to use MediaQuery
                backgroundColor: AppColors.black,
                child: const Icon(
                  Icons.arrow_circle_right,
                  color: AppColors.white, // Change this if you want a different icon color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}