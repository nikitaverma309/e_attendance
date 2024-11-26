import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/string_res.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/controllers/profile_ctr/profile_controller.dart';
import 'package:online/generated/assets.dart';
import 'package:online/utils/shap/shape_design.dart';
import 'package:online/widgets/common/app_bar_widgets.dart';
import 'package:online/widgets/common/custom_widgets.dart';
import 'package:online/widgets/footer_widget.dart';
import 'package:text_scroll/text_scroll.dart';

import '../auth/registration/registration_camera.dart';

class RegisterFaceAttendanceScreen extends StatefulWidget {
  const RegisterFaceAttendanceScreen({super.key});

  @override
  State<RegisterFaceAttendanceScreen> createState() =>
      _RegisterFaceAttendanceScreenState();
}

class _RegisterFaceAttendanceScreenState
    extends State<RegisterFaceAttendanceScreen> {
  final CheckStatusController profileController =
      Get.put(CheckStatusController());
  TextEditingController emailCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const CustomAppBar(
        title: Strings.attendance,
        showBackButton: true,
        actionWidget: Icon(
          Icons.more_vert,
          color: Color(0xff176daa),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Scrolling Text
              Container(
                decoration: Shape.scrollText(context),
                padding: const EdgeInsets.all(8.0),
                child: const TextScroll(
                  Strings.version,
                  style: kText15BaNaBoldBlackColorStyle,
                  velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                ),
              ),
              20.height,

              // Logo Section
              const CircleAvatar(
                backgroundColor: Color(0xffb8cbd8),
                radius: 44,
                child: Image(
                  image: AssetImage(Assets.imagesCglogo),
                  height: 64,
                  width: 64,
                ),
              ),
              16.height,
              const Text(
                Strings.higherEducation,
                style: kText15BaNaBoldBlackColorStyle,
                textAlign: TextAlign.center,
              ),
              20.height,

              // Attendance ID Section
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: Shape.chooseCheckBox(context),
                child: Row(
                  children: [
                    const Flexible(
                      child: Text(
                        Strings.attendanceId,
                        style: k13BoldBlackColorStyle,
                      ),
                    ),
                    10.width,
                    Expanded(
                      child: Container(
                        decoration: Shape.submitContainerRed(context),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          controller: emailCtr,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              20.height,

              Container(
                padding: const EdgeInsets.all(12),
                decoration: Shape.chooseCheckBox(context),
                child: Row(
                  children: [
                    Obx(() {
                      bool isButtonDisabled = profileController.isLoading.value;

                      return isButtonDisabled
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : Checkbox(
                        value: profileController.isChecked.value,
                        onChanged: (bool? newValue) async {
                          if (emailCtr.text.isEmpty) {
                            showErrorDialog(
                              context: context,
                              subTitle:
                              Strings.attendanceAlert,
                              textHeading: "Error",
                              onPressed: () {
                                Get.back();
                              },
                            );

                            return;
                          }

                          profileController.isChecked.value =
                              newValue ?? false;

                          if (profileController.isChecked.value) {
                            profileController.isLoading.value = true;
                            await profileController
                                .getCheckStatusLatLong(emailCtr.text);
                            profileController.isLoading.value = false;
                            profileController.isChecked.value = false;
                            if (profileController.employeeData.value !=
                                null) {
                              showSuccessDialog(
                                context: context,
                                subTitle:Strings.dataSuccess,
                                textHeading: "Employee Code registered",
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrationScreen(
                                            attendanceId: emailCtr.text,
                                          ),
                                    ),
                                  );
                                  profileController.isChecked.value =
                                  false;
                                  profileController.isLoading.value =
                                  false;
                                },
                              );
                            } else {
                              showErrorDialog(
                                context: context,
                                subTitle:
                                "Your Attendance ID was incorrect. Please try again.",
                                textHeading: "Error",
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      const RegisterFaceAttendanceScreen(),
                                    ),
                                  );
                                  profileController.isChecked.value =
                                  false;
                                  profileController.isLoading.value =
                                  false;
                                },
                              );
                            }
                          }
                        },
                      );
                    }),

                    10.width,
                    const Expanded(
                      child: Text(
                        Strings.notRegistration,
                        style: k13BoldBlackColorStyle,
                      ),
                    ),
                  ],
                ),
              ),
              20.height,

              Obx(() {
                return GridView.builder(
                  itemCount: profileController.attendanceIds.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.5,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        String selectedValue =
                            profileController.attendanceIds[index];
                        if (selectedValue == "Reset") {
                          emailCtr.clear();
                        } else if (selectedValue == "Back") {
                          String currentText = emailCtr.text;
                          if (currentText.isNotEmpty) {
                            emailCtr.text = currentText.substring(
                                0, currentText.length - 1);
                          }
                        } else if (emailCtr.text.length < 11) {
                          emailCtr.text += selectedValue;
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3C998),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          profileController.attendanceIds[index],
                          style: k13BoldBlackColorStyle,
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FooterWidget(),
    );
  }
}
