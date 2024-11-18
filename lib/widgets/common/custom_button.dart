import 'package:flutter/material.dart';
import 'package:online/constants/colors_res.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 44,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: Colors.white,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(
                screenHeight * 0.02), // Updated to use MediaQuery
          ),
          child: Padding(
            padding:
                EdgeInsets.all(screenWidth * 0.03), // Updated to use MediaQuery
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.03), // Updated to use MediaQuery
                  child: Text(
                    text,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize:
                          screenHeight * 0.025, // Updated to use MediaQuery
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: screenHeight * 0.03, // Updated to use MediaQuery
                  backgroundColor: AppColors.black,
                  child: const Icon(
                    Icons.arrow_circle_right,
                    color: AppColors
                        .white, // Change this if you want a different icon color
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
