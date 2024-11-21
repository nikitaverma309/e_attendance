import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/constants/string_res.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/controllers/login_controller.dart';
import 'package:online/widgets/common/custom_button.dart';
import 'package:online/widgets/footer_widget.dart';

import '../../../utils/utils.dart';

class LoginCameraViewTwo extends StatefulWidget {
  final String attendanceId;
  final File? imageFile;
  const LoginCameraViewTwo(
      {super.key, this.imageFile, required this.attendanceId});

  @override
  State<LoginCameraViewTwo> createState() => _LoginCameraViewTwoState();
}

class _LoginCameraViewTwoState extends State<LoginCameraViewTwo> {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff176daa),
      appBar: AppBar(
        title: const Text(Strings.login, style: kText19BoldBlackColorStyle),
        backgroundColor: const Color(0xff176daa),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
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
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Get.back(result: null);
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          50.height,
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                0.05 * screenWidth,
                0.025 * screenHeight,
                0.05 * screenWidth,
                0.04 * screenHeight,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF484646),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.03 * screenHeight),
                  topRight: Radius.circular(0.03 * screenHeight),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: AppColors.white,
                        size: screenHeight * 0.038,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.012),
                  Material(
                    elevation: 44,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff204867),
                        borderRadius: BorderRadius.circular(1),
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 6.0,
                        ),
                      ),
                      child: widget.imageFile != null
                          ? Image.file(
                              widget.imageFile!,
                              fit: BoxFit.contain,
                              height: screenHeight * 0.4,
                            )
                          : Icon(
                              Icons.camera_alt,
                              size: screenHeight * 0.09,
                              color: const Color(0xffa2cccc),
                            ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.045),
                  if (widget.imageFile != null)
                    Center(
                      child: CustomButton(
                        onTap: () async {
                          if (widget.imageFile != null) {
                            await loginController.uploadFileLogin(
                              context,
                              widget.imageFile!, // Pass the file
                              widget.attendanceId, // Pass the attendance ID
                            );
                          }
                        },
                        text: 'Authenticate',
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: FooterWidget(),
    );
  }
}
