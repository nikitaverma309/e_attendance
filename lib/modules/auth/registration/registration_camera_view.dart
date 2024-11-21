import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/constants/string_res.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/controllers/login_controller.dart';
import 'package:online/widgets/common/custom_button.dart';
import 'package:online/widgets/footer_widget.dart';

class ConfirmRegisterationScreen extends StatefulWidget {
  final File? imageFile;
  final String attendanceId;// यह फ़ाइल जो कैमरा से ली गई इमेज है
  const ConfirmRegisterationScreen({super.key, this.imageFile, required this.attendanceId});

  @override
  State<ConfirmRegisterationScreen> createState() =>
      _ConfirmRegisterationScreenState();
}

class _ConfirmRegisterationScreenState extends State<ConfirmRegisterationScreen> {
  final LoginController loginController = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print("view page ${widget.attendanceId}");
    return Scaffold(
      backgroundColor: const Color(0xff176daa),
      appBar: AppBar(
        title: const Text(Strings.attendance, style: kText19BoldBlackColorStyle),
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
                0.012 * screenHeight,
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
                  SizedBox(height: screenHeight * 0.025),

                  SizedBox(height: screenHeight * 0.025),
                  if (widget.imageFile != null)
                    Obx(() {
                      return loginController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              onTap: () async {
                                if (!loginController.isLoading.value) {
                                  loginController.isLoading.value = true;

                                  if (widget.imageFile != null ||
                                      widget.attendanceId != null) {
                                    int? employeeCode =
                                        int.tryParse( widget.attendanceId);
                                    await loginController.uploadFileSignUp(
                                        employeeCode!, widget.imageFile!,);

                                    loginController.isLoading.value = false;
                                  } else {
                                    loginController.isLoading.value = false;
                                  }
                                }
                              },
                              text: 'Registration now',
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
