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
  final ProfileController profileController = Get.put(ProfileController());
  TextEditingController emailCtr = TextEditingController();
  List<String> attendanceIds = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "Reset",
    "0",
    "Back"
  ];

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
                decoration: BoxDecoration(
                  color: Colors.cyan.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8.0),
                child: const TextScroll(
                  'App Version: Ap@36451 Organization: National Information Center (NIC) Chhattisgarh, Building: Mantralaya Naya Raipur',
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
                "Higher Education Department's",
                style: kText15BaNaBoldBlackColorStyle,
                textAlign: TextAlign.center,
              ),
              20.height,

              // Attendance ID Section
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3C998),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Flexible(
                      child: Text(
                        "उपस्थिति आईडी\nAttendance ID",
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

              // Instruction Section
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1EBD2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Obx(() {
                      bool isButtonDisabled = profileController.isLoading.value;

                      return isButtonDisabled
                          ? const Center(
                              child:
                                  CircularProgressIndicator(), // Show loading spinner
                            )
                          : Checkbox(
                              value: profileController.isChecked.value,
                              onChanged: (bool? newValue) async {
                                if (emailCtr.text.isEmpty) {
                                  // Show an error if Attendance ID is not entered
                                  Get.defaultDialog(
                                    title: "Error",
                                    middleText:
                                        "Please enter your Attendance ID before proceeding.",
                                    textConfirm: "OK",
                                    onConfirm: () => Get.back(),
                                  );
                                  return;
                                }

                                profileController.isChecked.value =
                                    newValue ?? false;

                                if (profileController.isChecked.value) {
                                  // Show loading state
                                  profileController.isLoading.value = true;

                                  // Call the API to fetch profile data
                                  await profileController
                                      .getApiProfile(emailCtr.text);

                                  // Hide loading state (already handled inside getApiProfile)
                                  profileController.isLoading.value = false;
                                  profileController.isChecked.value = false;

                                  // Handle API response
                                  if (profileController.employeeData.value !=
                                      null) {
                                    // Show success dialog if data is fetched successfully
                                    Get.defaultDialog(
                                      title: "Success",
                                      middleText:
                                          "Employee data fetched successfully.",
                                      textConfirm: "OK",
                                      onConfirm: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationScreen(
                                                  attendanceId: emailCtr.text),
                                        ),
                                      ),
                                    );
                                  } else {
                                    // Show error dialog if data is null
                                    Get.defaultDialog(
                                      title: "Error",
                                      middleText:
                                          "Your Attendance ID was incorrect. Please try again.",
                                      textConfirm: "OK",
                                      onConfirm: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterFaceAttendanceScreen(
                                                 ),
                                        ),
                                      ),
                                    );
                                    profileController.isChecked.value = false;
                                    profileController.isLoading.value = false;
                                  }
                                }
                              },
                            );
                    }),
                    // Checkbox(
                    //   value: true,
                    //   onChanged: (bool? newValue) {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) =>
                    //             RegistrationScreen(attendanceId: emailCtr.text),
                    //       ),
                    //     );
                    //   },
                    // ),
                    10.width,
                    const Expanded(
                      child: Text(
                        "जिन उपयोगकर्ताओं का कर्मचारी कोड मौजूद है, कृपया अपनी उपस्थिति दर्ज करने के लिए अपना चेहरा पंजीकृत करें।",
                        style: k13BoldBlackColorStyle,
                      ),
                    ),
                  ],
                ),
              ),
              20.height,

              // Attendance ID Grid
              GridView.builder(
                itemCount: attendanceIds.length,
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
                      if (attendanceIds[index] == "Reset") {
                        emailCtr.clear();
                      } else if (attendanceIds[index] == "Back") {
                        String currentText = emailCtr.text;
                        if (currentText.isNotEmpty) {
                          emailCtr.text =
                              currentText.substring(0, currentText.length - 1);
                        }
                      } else if (emailCtr.text.length < 11) {
                        emailCtr.text += attendanceIds[index];
                      }
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3C998),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        attendanceIds[index],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FooterWidget(),
    );
  }
}
