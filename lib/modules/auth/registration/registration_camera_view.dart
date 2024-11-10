import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/controllers/login_controller.dart';
import 'package:online/widgets/app_text_field.dart';
import 'package:online/widgets/common/custom_button.dart';
import 'package:online/widgets/footer_widget.dart';

class ConfirmRegisterationScreen extends StatefulWidget {
  final File? imageFile; // यह फ़ाइल जो कैमरा से ली गई इमेज है
  const ConfirmRegisterationScreen({super.key, this.imageFile});

  @override
  State<ConfirmRegisterationScreen> createState() =>
      _ConfirmRegisterationScreenState();
}

class _ConfirmRegisterationScreenState extends State<ConfirmRegisterationScreen> {
  final LoginController loginController = Get.put(LoginController());
  TextEditingController empCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Camera"),
        backgroundColor: AppColors.scaffoldTopGradientClr,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(result: null);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.scaffoldTopGradientClr,
              AppColors.scaffoldBottomGradientClr,
            ],
          ),
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            0.05 * screenWidth,
            0.012 * screenHeight,
            0.05 * screenWidth,
            0.04 * screenHeight,
          ),
          decoration: BoxDecoration(
            color: AppColors.bbFacebook,
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
                    color: AppColors.bbAccentColor,
                    size: screenHeight * 0.038,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.025),
              Container(
                width: screenHeight * 0.30,
                height: screenHeight * 0.30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xfff1e9e9),
                ),
                child: widget.imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: Image.file(
                          widget.imageFile!,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Icon(
                        Icons.camera_alt,
                        size: screenHeight * 0.09,
                        color: const Color(0xffa2cccc),
                      ),
              ),
              SizedBox(height: screenHeight * 0.025),
              AppTextField(
                labelText: 'User Employee code',
                controller: empCode,
                keyboardType: TextInputType.number,
              ),
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
                                  empCode != null) {
                                int? employeeCode =
                                    int.tryParse(empCode.text.trim());
                                await loginController.uploadFileSignUp(
                                    employeeCode!, widget.imageFile!);

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
      bottomSheet: FooterWidget(),
    );
  }
}
