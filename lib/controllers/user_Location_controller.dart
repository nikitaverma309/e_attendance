import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:online/api/get_api_services.dart';
import 'package:online/enum/enum_screen.dart';
import 'package:online/enum/location_status.dart';
import 'package:online/models/profile/check_user_location_model.dart';
import 'package:online/modules/auth/camera_pic.dart';
import 'package:online/modules/home/home.dart';
import 'package:online/modules/home/main_page.dart';
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
  TextEditingController employeeIdCtr = TextEditingController();
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

  Future<void> getCheckStatusLatLong(
      String empCode, CameraAction action, BuildContext context) async {
    isLoading(true);
    try {
      var employeeResponse =
          await ApiServices.getUserLocationApiServices(empCode);

      if (employeeResponse.userData != null) {
        Position currentPosition = await determinePosition(context);
        employeeData.value = employeeResponse.userData;
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
            compareLat!,
            compareLong!,
          );
          double tolerance = 50.0;
          if (distanceInMeters <= 160 + tolerance) {
            isChecked.value = true;
            isLocationMatched.value = true;
            if (action == CameraAction.login) {
              showSuccessDialog(
                context: context,
                subTitle: "Attendance marked successfully!",
                navigateAfterDelay: true,
                onPressed: () {
                  navigateToCamera(
                      context, action, employeeData.value!.empCode!);
                },
              );
            } else {
              showErrorDialog(
                context: context,
                subTitle:
                "Your face is already registered. If you want to re-register, you need to login first.",

                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainPage(),
                    ),
                  );
                },
              );
            }
            // return;
          } else {
            showErrorDialog(
              context: context,
              subTitle: "Your location does not match the required location.",
            );
            Utils.showErrorToast(
                message: 'Your location does not match the required location.');
            isChecked.value = false;
            isLocationMatched.value = false;
          }
        }
      } else {
        getErrorMessage(context, employeeResponse.errorType, action);
        // handleErrorResponse(
        //     context,
        //     getErrorMessage(context, employeeResponse.errorType, action),
        //     action);
      }
    } catch (e) {
      Utils.showErrorToast(message: e.toString());
    } finally {
      isLoading(false);
      isChecked.value = false;
    }
  }

  void navigateToCamera(
      BuildContext context, CameraAction action, String empCode) {
    // Navigator.pop(context);
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
        Navigator.pop(context);
      },
    );
  }
//   String getErrorMessage(
//     BuildContext context, LoginStatus? status, CameraAction action) {
//   switch (status) {
//     case LoginStatus.faceNotExists:
//       if (action == CameraAction.login) {
//         return "Your face is not registered. Please register before login.";
//       } else if (action == CameraAction.registration) {
//         print("emp deta hai S${employeeData.value!.empCode}");
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => LoginCameraTwo(
//               attendanceId: employeeIdCtr.text,
//               action: action,
//             ),
//           ),
//         );
//       }
//       break;
//     case LoginStatus.reRegisteredFace:
//       if (action == CameraAction.login) {
//         return "Your face is not registered. Please Re Register Your Face before login.";
//       } else if (action == CameraAction.registration) {
//         showErrorDialog(
//             context: context,
//             subTitle:
//                 "Your face is not registered. To re-register your face, you need to log in first.",
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const MyHomePage(),
//                 ),
//               );
//             });
//       }
//       break;
//     case LoginStatus.faceNotVerified:
//       return action == CameraAction.login
//           ? "Face verification is pending. Please contact the web administrator."
//           : "Face verification is pending. Please complete the verification.";
//
//     case LoginStatus.employeeNotExists:
//       handleIncorrectAttempt();
//       return "Employee does not exist. Please check your employee code.";
//
//     case LoginStatus.employeeNotVerified:
//       return "Employee is not verified Please contact the web administrator.";
//     default:
//       return "An unknown error occurred. Please try again.";
//   }
//   print("Unhandled LoginStatus: $status");
//   throw Exception("Unhandled LoginStatus: $status");
// }

  /* // String getErrorMessage(
  //     BuildContext context, LoginStatus? status, CameraAction action) {
  //   switch (status) {
  //     case LoginStatus.faceNotExists:
  //       if (action == CameraAction.login) {
  //         showErrorDialog(
  //             context: context,
  //             subTitle:
  //                 "Your face is not registered. Please register before login.",
  //             onPressed: () {
  //               Navigator.pop(context);
  //             });
  //       } else if (action == CameraAction.registration) {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => LoginCameraTwo(
  //               attendanceId: employeeIdCtr.text,
  //               action: action,
  //             ),
  //           ),
  //         );
  //       }
  //     case LoginStatus.reRegisteredFace:
  //       if (action == CameraAction.login) {
  //         showErrorDialog(
  //             context: context,
  //             subTitle:
  //                 "Your face is not registered. Please Re Register Your Face before login.",
  //             onPressed: () {
  //               Navigator.pop(context);
  //             });
  //       } else if (action == CameraAction.registration) {
  //         showErrorDialog(
  //             context: context,
  //             subTitle:
  //                 "Your face is not registered. To re-register your face, you need to log in first.",
  //             onPressed: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => const MyHomePage(),
  //                 ),
  //               );
  //             });
  //       }
  //     case LoginStatus.faceNotVerified:
  //       return action == CameraAction.login
  //           ? "Face verification is pending. Please contact the web administrator."
  //           : "Face verification is pending. Please complete the verification.";
  //     case LoginStatus.employeeNotExists:
  //       handleIncorrectAttempt();
  //       return "Employee does not exist. Please check your employee code.";
  //     case LoginStatus.employeeNotVerified:
  //       return "Employee is not verified. Please contact the web administrator.";
  //     default:
  //       return "An unknown error occurred. Please try again.";
  //   }
  //
  //   // Fallback return to handle any unexpected cases
  //   throw Exception("Unhandled LoginStatus or missing return path.");
  // }*/
  String getErrorMessage(
      BuildContext context, LoginStatus? status, CameraAction action) {
    String errorMessage = ""; // Initialize the error message

    switch (status) {
      case LoginStatus.faceNotExists:
        if (action == CameraAction.login) {
          errorMessage =
          "Your face is not registered. Please register your face.";
        } else if (action == CameraAction.registration) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginCameraTwo(
                attendanceId: employeeIdCtr.text,
                action: action,
              ),
            ),
          );
        }
        break;

      case LoginStatus.reRegisteredFace:
        if (action == CameraAction.login) {
          errorMessage =
              "Your face is not registered. Please register your face .";
        } else if (action == CameraAction.registration) {
          showErrorDialog(
            context: context,
            subTitle:
            "Your face is already registered. If you want to re-register, you need to login first.",

            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ),
              );
            },
          );

        }
        break;

      case LoginStatus.faceNotVerified:
        errorMessage = action == CameraAction.login
            ? "Face verification is pending. Please contact the web administrator."
            : "Face verification is pending. Please complete the verification.";
        break;

      case LoginStatus.employeeNotExists:
        handleIncorrectAttempt();
        errorMessage =
            "Employee does not exist. Please check your employee code.";
        break;

      case LoginStatus.employeeNotVerified:
        errorMessage =
            "Employee is not verified. Please contact the web administrator.";
        break;

      default:
        errorMessage = "An unknown error occurred. Please try again.";
    }

    // Show error dialog if an error message is defined
    if (errorMessage.isNotEmpty) {
      showErrorDialog(
        context: context,
        subTitle: errorMessage,
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }

    return errorMessage;
  }
}
