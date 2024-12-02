import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/string_res.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/controllers/user_Location_controller.dart';
import 'package:online/generated/assets.dart';
import 'package:online/modules/auth/login/login_camera.dart';
import 'package:online/utils/shap/shape_design.dart';
import 'package:online/utils/utils.dart';
import 'package:online/widgets/common/app_bar_widgets.dart';
import 'package:online/widgets/common/custom_widgets.dart';
import 'package:online/widgets/footer_widget.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class FaceAttendanceScreen extends StatefulWidget {
  const FaceAttendanceScreen({super.key});

  @override
  State<FaceAttendanceScreen> createState() => _FaceAttendanceScreenState();
}

class _FaceAttendanceScreenState extends State<FaceAttendanceScreen> {
  final UserLocationController profileController =
      Get.put(UserLocationController());
  TextEditingController employeeIdCtr = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xF5ECF4F5),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: Shape.scrollText(context),
                padding: const EdgeInsets.all(8.0),
                child: const TextScroll(
                  Strings.version,
                  style: kText15BaNaBoldBlackColorStyle,
                  velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                ),
              ),
              10.height,

              // Logo Section
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 44,
                child: Image(
                  image: AssetImage(Assets.imagesCglogo),
                  height: 64,
                  width: 64,
                ),
              ),
              5.height,
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: Shape.cCheckBox(context),
                child: const Column(
                  children: [
                    Text(
                      Strings.higherEducation,
                      style: kText15BaNaBoldBlackColorStyle,
                    ),
                    Text("Government Of Chhattisgarh",
                        style: kText15BaNaBoldBlackColorStyle),
                  ],
                ),
              ),

              10.height,
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
                          controller: employeeIdCtr,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                          readOnly:
                              profileController.incorrectAttempts.value >= 3,
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
                padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 4),
                decoration: Shape.scrollText(context),
                child: Row(
                  children: [
                    11.width,
                    // Obx(() {
                    //   bool isButtonDisabled = profileController.isLoading.value;
                    //
                    //   return isButtonDisabled
                    //       ? const Center(
                    //           child: CircularProgressIndicator(),
                    //         )
                    //       : Checkbox(
                    //           value: profileController.isChecked.value,
                    //           onChanged: (bool? newValue) async {
                    //             if (employeeIdCtr.text.isEmpty) {
                    //               showErrorDialog(
                    //                 context: context,
                    //                 subTitle: Strings.attendanceAlert,
                    //               );
                    //               return;
                    //             }
                    //             profileController.isChecked.value =
                    //                 newValue ?? false;
                    //
                    //             if (profileController.isChecked.value) {
                    //               if (profileController.isBlocked.value) {
                    //                 showErrorDialog(
                    //                   context: context,
                    //                   subTitle: "Please try after 10 seconds.",
                    //                   permanentlyDisableButton: true,
                    //                 );
                    //               } else {
                    //                 Utils.printLog("after 10 seconds");
                    //                 profileController.isLoading.value = true;
                    //
                    //                 await profileController
                    //                     .getCheckStatusLatLong(
                    //                         employeeIdCtr.text, context);
                    //                 profileController.isLoading.value = false;
                    //                 profileController.isChecked.value = false;
                    //                 if (profileController.employeeData.value !=
                    //                         null &&
                    //                     profileController
                    //                         .isLocationMatched.value) {
                    //                   showSuccessDialog(
                    //                     context: context,
                    //                     subTitle: Strings.dataSuccess,
                    //                     textHeading:
                    //                         "Location Matched. You can proceed.",
                    //                     navigateAfterDelay: true,
                    //                     onPressed: () {
                    //                       Navigator.push(
                    //                         context,
                    //                         MaterialPageRoute(
                    //                           builder: (context) =>
                    //                               LoginCameraTwo(
                    //                             attendanceId:
                    //                                 employeeIdCtr.text,
                    //                           ),
                    //                         ),
                    //                       );
                    //
                    //                       profileController.isChecked.value =
                    //                           false;
                    //                       profileController.isLoading.value =
                    //                           false;
                    //                     },
                    //                   );
                    //                 } else {
                    //                   profileController
                    //                       .handleIncorrectAttempt();
                    //                   showErrorDialog(
                    //                     context: context,
                    //                     subTitle:
                    //                         "Your Attendance ID was incorrect. Please try again.",
                    //                     onPressed: () {
                    //                       if (Navigator.canPop(context)) {
                    //                         Navigator.pop(context);
                    //                       }
                    //                       profileController.isChecked.value =
                    //                           false;
                    //                       profileController.isLoading.value =
                    //                           false;
                    //                     },
                    //                   );
                    //                 }
                    //               }
                    //             }
                    //           },
                    //         );
                    // }),
                    Obx(() {
                      bool isButtonDisabled = profileController.isLoading.value;

                      return isButtonDisabled
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Checkbox(
                              value: profileController.isChecked.value,
                              onChanged: (bool? newValue) async {
                                if (employeeIdCtr.text.isEmpty) {
                                  showErrorDialog(
                                    context: context,
                                    subTitle: Strings.attendanceAlert,
                                  );
                                  return;
                                }
                                profileController.isChecked.value =
                                    newValue ?? false;
                                var connectivityResult =
                                    await Connectivity().checkConnectivity();
                                if (connectivityResult ==
                                    ConnectivityResult.none) {
                                  showErrorDialog(
                                    context: context,
                                    subTitle:
                                        "No internet connection. Please check your internet connection.",
                                  );
                                  profileController.isChecked.value = false;
                                  return;
                                }
                                if (profileController.isChecked.value) {
                                  if (profileController.isBlocked.value) {
                                    showErrorDialog(
                                      context: context,
                                      subTitle: "Please try after 10 seconds.",
                                      permanentlyDisableButton: true,
                                    );
                                    profileController.isChecked.value = false;
                                  } else {
                                    Utils.printLog("after 10 seconds");
                                    profileController.isLoading.value = true;

                                    await profileController
                                        .getCheckStatusLatLong(
                                            employeeIdCtr.text, context);
                                    profileController.isLoading.value = false;
                                    profileController.isChecked.value = false;
                                    if (profileController.employeeData.value !=
                                        null) {
                                      if (profileController
                                                  .isLocationMatched.value ==
                                              true &&
                                          profileController
                                                  .employeeData.value !=
                                              null) {
                                        // Location is matched, show success dialog
                                        showSuccessDialog(
                                          context: context,
                                          subTitle: Strings.dataSuccess,
                                          textHeading:
                                              "Location Matched. You can proceed.",
                                          navigateAfterDelay: true,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginCameraTwo(
                                                  attendanceId:
                                                      employeeIdCtr.text,
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
                                        // Location is incorrect, show location error dialog
                                        showErrorDialog(
                                          context: context,
                                          subTitle:
                                              "Your location doesn't match. Please try again.",
                                          onPressed: () {
                                            if (Navigator.canPop(context)) {
                                              Navigator.pop(context);
                                            }
                                            profileController.isChecked.value =
                                                false;
                                            profileController.isLoading.value =
                                                false;
                                          },
                                        );
                                      }
                                    } else {
                                      profileController
                                          .handleIncorrectAttempt();
                                      showErrorDialog(
                                        context: context,
                                        subTitle:
                                            "Your Attendance ID was incorrect. Please try again.",
                                        onPressed: () {
                                          if (Navigator.canPop(context)) {
                                            Navigator.pop(context);
                                          }
                                          profileController.isChecked.value =
                                              false;
                                          profileController.isLoading.value =
                                              false;
                                        },
                                      );
                                    }
                                  }
                                }
                              },
                            );
                    }),
                    17.width,
                    const Expanded(
                      child: Text(
                        Strings.notAttendance,
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
                          employeeIdCtr.clear();
                        } else if (selectedValue == "Back") {
                          String currentText = employeeIdCtr.text;
                          if (currentText.isNotEmpty) {
                            employeeIdCtr.text = currentText.substring(
                                0, currentText.length - 1);
                          }
                        } else if (employeeIdCtr.text.length < 11) {
                          employeeIdCtr.text += selectedValue;
                        }
                        FocusScope.of(context).requestFocus(_focusNode);
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
      bottomSheet: FooterWidget(),
    );
  }
}
