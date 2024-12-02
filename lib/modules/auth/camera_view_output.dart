import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/constants/string_res.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/controllers/login_controller.dart';
import 'package:online/enum/enum_screen.dart';
import 'package:online/utils/shap/shape_design.dart';
import 'package:online/widgets/app_button.dart';
import 'package:online/widgets/footer_widget.dart';

class LoginCameraViewTwo extends StatefulWidget {
  final CameraAction action;
  final String? attendanceId;
  final File? imageFile;
  const LoginCameraViewTwo(
      {super.key,
      this.imageFile,
      required this.action,
      required this.attendanceId});

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
                    Obx(() {
                      return loginController.isLoading.value
                          ? const CircularProgressIndicator()
                          : CommonButton(
                              onPressed: () async {
                                loginController.isLoading.value = true;

                                // फ़ाइल और एक्शन चेक करें
                                if (widget.imageFile != null) {
                                  if (widget.action ==
                                      CameraAction.attendance) {
                                    // अटेंडेंस के लिए API कॉल
                                    await loginController.uploadLogin(
                                      context,
                                      widget.imageFile!,
                                      widget.attendanceId!,
                                    );
                                  } else if (widget.action ==
                                      CameraAction.registration) {
                                    // लॉगिन के लिए API कॉल
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
                              text: widget.action == CameraAction.attendance
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
