import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:online/api/get_api_services.dart';
import 'package:online/enum/enum_screen.dart';
import 'package:online/enum/location_status.dart';
import 'package:online/models/profile/check_user_location_model.dart';
import 'package:online/modules/auth/camera_pic.dart';
import 'package:online/modules/restriction_dialog/restrict_user_dialog.dart';
import 'package:online/utils/utils.dart';
import 'package:online/widgets/common/custom_widgets.dart';

class UserLocationController extends GetxController {
  var isLoading = false.obs;
  final isChecked = false.obs;
  final isLocationMatched = false.obs;
  var incorrectAttempts = 0.obs;
  var isBlocked = false.obs;
  Timer? blockTimer;

  void resetBlock() {
    Utils.printLog("timer reset after 10seconds");
    incorrectAttempts.value = 0;
    isBlocked.value = false;
    blockTimer?.cancel();
  }

  void handleIncorrectAttempt() {
    incorrectAttempts.value++;
    if (incorrectAttempts.value >= 3) {
      isBlocked.value = true;
      blockTimer = Timer(const Duration(seconds: 13), resetBlock);
    }
  }

  @override
  void onClose() {
    blockTimer?.cancel();
    super.onClose();
  }

  var employeeData = Rx<UserLocationModel?>(null);
  var attendanceIds = <String>[
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
  ].obs;


  // Future<void> getCheckStatusLatLong(
  //     String empCode, CameraAction login, BuildContext context) async {
  //   isLoading(true);
  //   try {
  //     var employeeDetails =
  //         await ApiServices.getUserLocationApiServices(empCode);
  //     if (employeeDetails.userData != null) {
  //       Position currentPosition = await determinePosition(context);
  //       employeeData.value = employeeDetails.userData;
  //
  //       double currentLat = currentPosition.latitude;
  //       double currentLong = currentPosition.longitude;
  //
  //       double? compareLat =
  //           double.tryParse(employeeData.value!.collegeDetails!.lat!);
  //       double? compareLong =
  //           double.tryParse(employeeData.value!.collegeDetails!.long!);
  //
  //       if (compareLat != null && compareLong != null) {
  //         double distanceInMeters = Geolocator.distanceBetween(
  //           currentLat,
  //           currentLong,
  //           compareLat,
  //           compareLong,
  //         );
  //
  //         if (distanceInMeters <= 160) {
  //           isChecked.value = true;
  //           isLocationMatched.value = true;
  //
  //           showSuccessDialog(
  //             context: context,
  //             subTitle: "Attendance marked successfully!",
  //             navigateAfterDelay: true,
  //             onPressed: () {
  //               print("object");
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => LoginCameraTwo(
  //                     attendanceId: employeeData.value?.empCode!,
  //                     action: CameraAction.login,
  //                   ),
  //                 ),
  //               );
  //             },
  //           );
  //           isLoading(false);
  //         } else {
  //           isChecked.value = false;
  //           isLocationMatched.value = false;
  //           isLoading(false);
  //         }
  //       } else {
  //         isChecked.value = false;
  //         isLocationMatched.value = false;
  //         isLoading(false);
  //       }
  //     } else {
  //       String msgError = "";
  //       if (employeeDetails.errorType == LoginStatus.faceNotVerified) {
  //         msgError =
  //             "Face verification is pending. Please contact the web administrator";
  //       } else if (employeeDetails.errorType == LoginStatus.employeeNotExists) {
  //         msgError = "Face not employeeNotVerified";
  //       } else if (employeeDetails.errorType == LoginStatus.reRegisteredFace) {
  //         msgError = "Please re-register your face. ";
  //       } else if (employeeDetails.errorType == LoginStatus.faceNotExists) {
  //         showSuccessDialog(
  //           context: context,
  //           subTitle: "your FACE NOT EXISTS",
  //           navigateAfterDelay: true,
  //           onPressed: () {
  //             print("object");
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => LoginCameraTwo(
  //                   attendanceId: employeeData.value?.empCode!,
  //                   action: CameraAction.login,
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //
  //       } else if (employeeDetails.errorType == LoginStatus.employeeVerified) {
  //         msgError = "employeeNotFound";
  //       }
  //       isLoading(false);
  //       showErrorDialog(
  //         context: context,
  //         subTitle: msgError,
  //       );
  //     }
  //   } catch (e) {
  //     Utils.showErrorToast(message: e.toString());
  //     isChecked.value = false;
  //     isLocationMatched.value = false;
  //     isLoading(false);
  //   }
  //
  //   isLoading(false);
  // }

  Future<void> getCheckStatusLatLong(
      String empCode, CameraAction action, BuildContext context) async {
    isLoading(true);
    try {
      var employeeDetails = await ApiServices.getUserLocationApiServices(empCode);

      if (employeeDetails.userData != null) {
        Position currentPosition = await determinePosition(context);
        employeeData.value = employeeDetails.userData;

        double currentLat = currentPosition.latitude;
        double currentLong = currentPosition.longitude;

        double? compareLat =
        double.tryParse(employeeData.value!.collegeDetails!.homeLat!);
        double? compareLong =
        double.tryParse(employeeData.value!.collegeDetails!.homeLong!);

        if (compareLat != null && compareLong != null) {
          double distanceInMeters = Geolocator.distanceBetween(
            currentLat,
            currentLong,
            compareLat,
            compareLong,
          );

          if (distanceInMeters <= 160) {
            isChecked.value = true;
            isLocationMatched.value = true;
            if (action == CameraAction.login) {
              showSuccessDialog(
                context: context,
                subTitle: action == CameraAction.login
                    ? "Attendance marked successfully!"
                    : "Registration completed successfully!",
                navigateAfterDelay: true,
                onPressed: () {
                  navigateToCamera(context, action, employeeData.value!.empCode!);
                },
              );
            }
            else {
              // Registration Action - Just show success dialog but no navigation
              showErrorDialog(
                context: context,
                subTitle: "You are already registered. If you want to re-register, please proceed.",

                onPressed: () {
                  Navigator.pop(context);
                  navigateToCamera(context, action, employeeData.value!.empCode!);
                },
              );
            }

            // showSuccessDialog(
            //   context: context,
            //   subTitle: action == CameraAction.login
            //       ? "Attendance marked successfully!"
            //       : "Registration completed successfully!",
            //   navigateAfterDelay: true,
            //   onPressed: () {
            //     navigateToCamera(context, action, employeeData.value!.empCode!);
            //   },
            // );
          }
        } else {
          handleErrorResponse(context, "Invalid location data.", action);
        }
      } else {
        handleErrorResponse(
            context, getErrorMessage(employeeDetails.errorType, action), action);
      }
    } catch (e) {
      Utils.showErrorToast(message: e.toString());
    } finally {
      isLoading(false);
      isChecked.value = false;

    }
  }

  void navigateToCamera(BuildContext context, CameraAction action, String empCode) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginCameraTwo(
          attendanceId: empCode,
          action: action,
        ),
      ),
    );
  }

  void handleErrorResponse(
      BuildContext context, String errorMessage, CameraAction action) {
    showErrorDialog(
      context: context,
      subTitle: errorMessage,
      onPressed: () {
        if (action == CameraAction.registration) {
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
        }
      },
    );
  }

  String getErrorMessage(LoginStatus? status, CameraAction action) {
    switch (status) {
      case LoginStatus.faceNotVerified:
        return action == CameraAction.login
            ? "Face verification is pending. Please contact the web administrator."
            : "Face verification is pending. Please complete the verification.";
      case LoginStatus.employeeNotExists:
        handleIncorrectAttempt();
        return "Employee does not exist. Please check your emp code.";
      case LoginStatus.reRegisteredFace:
        return "Please re-register your face.";
      case LoginStatus.faceNotExists:
        return "Your face is not registered. Please register before login.";
      case LoginStatus.employeeVerified:
        return "Employee is verified but not found.";
      default:
        return "An unknown error occurred. Please try again.";
    }
  }


}
