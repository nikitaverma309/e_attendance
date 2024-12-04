import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/string_res.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/controllers/user_Location_controller.dart';
import 'package:online/enum/enum_screen.dart';
import 'package:online/enum/location_status.dart';
import 'package:online/generated/assets.dart';
import 'package:online/modules/auth/camera_pic.dart';
import 'package:online/utils/shap/shape_design.dart';
import 'package:online/widgets/common/app_bar_widgets.dart';
import 'package:online/widgets/common/custom_widgets.dart';
import 'package:online/widgets/footer_widget.dart';
import 'package:text_scroll/text_scroll.dart';

class FaceAttendanceScreen extends StatefulWidget {
  final CameraAction action;
  const FaceAttendanceScreen({super.key, required this.action});

  @override
  State<FaceAttendanceScreen> createState() => _FaceAttendanceScreenState();
}

class _FaceAttendanceScreenState extends State<FaceAttendanceScreen> {
  final UserLocationController profileController =
      Get.put(UserLocationController());
  TextEditingController employeeIdCtr = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // MediaQuery for responsive height and width
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xF5ECF4F5),
      appBar: CustomAppBar(
        title: widget.action == CameraAction.login
            ? Strings.attendance
            : Strings.signUp,
        actionWidget: const Icon(
          Icons.more_vert,
          color: Color(0xff176daa),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: Shape.scrollText(context),
                padding: const EdgeInsets.all(4.0),
                child: const TextScroll(
                  "${Strings.version}",
                  style: kText15BaNaBoldBlackColorStyle,
                  velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                ),
              ),
              SizedBox(height: screenHeight * 0.01), // Responsive spacing
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 35,
                child: Image(
                  image: AssetImage(Assets.imagesCglogo),
                  height: screenHeight * 0.08, // Responsive image height
                  width: screenWidth * 0.15, // Responsive image width
                ),
              ),
              SizedBox(height: screenHeight * 0.01), // Responsive spacing
              Container(
                padding: EdgeInsets.all(screenHeight * 0.01),
                decoration: Shape.cCheckBox(context),
                child: const Column(
                  children: [
                    Text(
                      Strings.higherEducation,
                      style: kTextBlackColorStyle,
                    ),
                    Text("Government Of Chhattisgarh",
                        style: kText15BaNaBoldBlackColorStyle),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01,
                  horizontal: screenWidth * 0.03,
                ),
                decoration: Shape.chooseCheckBox(context),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        Strings.attendanceId,
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.12),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.04),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.01),
                        child: TextFormField(
                          controller: employeeIdCtr,
                          keyboardType: TextInputType.phone,
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
              SizedBox(height: screenHeight * 0.03),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 4),
                decoration: Shape.scrollText(context),
                child: Row(
                  children: [
                    11.width,
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
                                    return;
                                  }

                                  profileController.isLoading.value = true;

                                  LoginStatus status = await profileController
                                      .getCheckStatusLatLong(
                                          employeeIdCtr.text, context);
                                  handleStatus(
                                    status,
                                    employeeIdCtr.text,
                                    widget.action,
                                  );
                                  profileController.isLoading.value = false;
                                  profileController.isChecked.value = false;
                                }
                              });
                    }),
                    17.width,
                    Expanded(
                      child: Text(
                        widget.action == CameraAction.login
                            ? Strings.notAttendance
                            : Strings.notRegistration,
                        style: k13BoldBlackColorStyle,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Obx(() {
                return GridView.builder(
                  itemCount: profileController.attendanceIds.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: screenWidth * 0.02,
                    mainAxisSpacing: screenHeight * 0.02,
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
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.02),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          profileController.attendanceIds[index],
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
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

  void handleStatus(
      LoginStatus status, String employeeId, CameraAction action) {
    switch (status) {
      case LoginStatus.success:
        showSuccessDialog(
          context: context,
          subTitle: action == CameraAction.login
              ? "Login Successful. You can proceed."
              : "Registration Successful. You can proceed.",
          textHeading: "Location Matched",
          navigateAfterDelay: true,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginCameraTwo(
                  attendanceId: employeeId,
                  action: action,
                ),
              ),
            );
          },
        );
        break;
      case LoginStatus.employeeNotFound:
        showErrorDialog(
          context: context,
          subTitle: "Your Attendance ID was incorrect. Please try again.",
        );
        profileController.handleIncorrectAttempt();
        break;

      case LoginStatus.locationMismatch:
        showErrorDialog(
          context: context,
          subTitle: "Your location doesn't match. Please try again.",
        );
        break;

      case LoginStatus.reRegisteredFace:
        showErrorDialog(
          context: context,
          subTitle: "Please register your face before logging in.",
        );
        break;
    }
  }
}
