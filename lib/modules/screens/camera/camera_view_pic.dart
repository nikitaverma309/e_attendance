import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/constants/string_res.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/modules/auth/controllers/face_recog_controller.dart';
import 'package:online/enum/enum_screen.dart';
import 'package:online/utils/shap/shape_design.dart';
import 'package:online/widgets/app_button.dart';
import 'package:online/widgets/footer_widget.dart';

class LoginCameraViewTwo extends StatefulWidget {
  final CameraAction action;
  final String? attendanceId;
  final File? imageFile;

  const LoginCameraViewTwo({
    super.key,
    this.imageFile,
    required this.action,
    required this.attendanceId,
  });

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
        title: Text(
          widget.action == CameraAction.login ? Strings.login : Strings.signUp,
          style: kText19BoldBlackColorStyle.copyWith(
            fontSize: screenWidth * 0.05, // Dynamically scale font size
          ),
        ),
        backgroundColor: const Color(0xff176daa),
        leading: Padding(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Container(
            decoration: Shape.cameraView(context),
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
          SizedBox(height: screenHeight * 0.05),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                screenWidth * 0.05,
                screenHeight * 0.025,
                screenWidth * 0.05,
                screenHeight * 0.04,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF484646),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenHeight * 0.03),
                  topRight: Radius.circular(screenHeight * 0.03),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  Card(
                    elevation: 44,
                    child: Container(
                      decoration: Shape.cameraView(context),
                      child: widget.imageFile != null
                          ? Image.file(
                              widget.imageFile!,
                              fit: BoxFit.cover,
                              height: screenHeight * 0.4,
                              width: screenWidth * 0.6,
                            )
                          : Icon(
                              Icons.camera_alt,
                              size: screenHeight * 0.09,
                              color: const Color(0xffa2cccc),
                            ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.11),
                  if (widget.imageFile != null)
                    Obx(() {
                      return loginController.isLoading.value
                          ? const CircularProgressIndicator()
                          : CommonButton(
                              onPressed: () async {
                                loginController.isLoading.value = true;

                                // Check file and action
                                if (widget.imageFile != null) {
                                  if (widget.action == CameraAction.login) {
                                    // API call for attendance
                                    await loginController.uploadLogin(
                                      context,
                                      widget.imageFile!,
                                      widget.attendanceId!,
                                    );
                                  } else if (widget.action ==
                                      CameraAction.registration) {
                                    // API call for registration
                                    int? employeeCode =
                                        int.tryParse(widget.attendanceId!);
                                    await loginController.signUp(
                                      employeeCode!,
                                      widget.imageFile!,
                                    );
                                  }
                                }

                                loginController.isLoading.value = false;
                              },
                              text: widget.action == CameraAction.login
                                  ? 'Mark Attendance'
                                  : 'Registration Now',
                            );
                    }),
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
