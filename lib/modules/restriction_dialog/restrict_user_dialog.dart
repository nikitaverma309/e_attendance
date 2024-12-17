import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:online/enum/enum_screen.dart';
import 'package:online/modules/auth/views/home/main_page.dart';
import 'package:online/modules/screens/camera/check_emp_id_screen.dart';
import 'package:online/utils/utils.dart';
import 'package:online/widgets/common/card_button.dart';



Future<void> showLocationAlert(BuildContext context,
    {String message = "Please enable location service and try again",
    bottomMessage = "We are only available in Specified region.",
    bool showButton = false}) async {
  return showDialog<void>(
      context: Utils.appNavigatorKey.currentContext!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return PopScope(
            canPop: false,
            child: AlertDialog(
              key: Utils.locationDialogKey,
              title: Text(
                message,
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const Icon(Icons.location_off, size: 50),
                    const SizedBox(height: 20),
                    Text(
                      bottomMessage,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    if (showButton) ...[
                      ElevatedButton(
                        onPressed: () {
                          Geolocator.openLocationSettings();

                        },
                        child: const Text("Continue"),
                      )
                    ]
                  ],
                ),
              ),
            ));
      });
}



//profile controller

void handleResponseRegister(String message) {
  if (message.contains("User ID does not exist.")) {
    showMessageErrorDialog(
      "Employee Code Not Registered. Please Contact the Administrator.",
      message,
    );
  } else if (message.contains("Employee Not Verified")) {
    showMessageErrorDialog(
      "Employee Not Verified. Please Contact the Administrator.",
      message,
    );
  } else if (message.contains(RegExp(r'^\d{11}$'))) {
    showMessageErrorDialog(
      "Employee Code Verified and Please wait, the face verification is being processed.",
      "Employee Code: $message",
    );
    Future.delayed(const Duration(seconds: 4), () {
      Get.off(() => const MainPage());
    });
  } else {
    showMessageErrorDialog(
      "Unexpected Response. Please Contact the Administrator.",
      message,
    );
  }
}
void showMessageErrorDialog(String title, String message) {
  Get.dialog(
    AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: [
        ButtonCard(
          color: Colors.red, // Optional: Customize the background color
          width: 60, // Set the width for ButtonCard
          height: 50,
          text: "Ok  ",
          onPressed: () {
            Get.off(() => const FaceAttendanceScreen(
              action: CameraAction.registration,
            ));
          },
        ),
      ],
    ),
  );
}

void showErrorLoginDialog(BuildContext context, String title, String message,
    bool navigateToProfile) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
              if (navigateToProfile) {
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      );
    },
  );
}

// Function to get the current position (latitude, longitude)
  Future<Position> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Show dialog and exit if services are disabled
        await showProfileLocationAlert(
          context,
          message: "Please enable location services to proceed",
          bottomMessage: "Location services are required for this feature.",
          showButton: true, // Show 'Enable Location' button
        );

        throw Exception('Location services are disabled.');
      }

      // Check location permissions
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied. Cannot request permissions.');
      }

      // Get current position
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {

      rethrow; // Propagate the exception
    }
  }

// Function to show an alert dialog when location services are disabled
  Future<void> showProfileLocationAlert(BuildContext context,
      {String message = "Please enable location service and try again",
      String bottomMessage = "We are only available in Specified region.",
      bool showButton = false}) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap the button
      builder: (BuildContext context) {
        // Automatically close the dialog after 2 seconds
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });

        return AlertDialog(
          title: Text(
            message,
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Icon(Icons.location_off, size: 50),
                const SizedBox(height: 20),
                Text(
                  bottomMessage,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                if (showButton) ...[
                  ElevatedButton(
                    onPressed: () async {
                      // Open location settings
                      await Geolocator.openLocationSettings();
                      Navigator.pop(context); // Close dialog after button press
                    },
                    child: const Text("Enable Location"),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }





class CustomSnackbarError {
  static void showSnackbar({
    String? title,
    required String message,
    SnackPosition position = SnackPosition.TOP,
    Color backgroundColor = Colors.red,
    Color textColor = Colors.white,
    double borderRadius = 10.0,
    EdgeInsets margin = const EdgeInsets.all(10),
  }) {
    Get.snackbar(
      title!,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: textColor,
      borderRadius: borderRadius,
      margin: margin,
    );
  }
}

class CustomSnackbarSuccessfully {
  static void showSnackbar({
    required String title,
    required String message,
    SnackPosition position = SnackPosition.BOTTOM,
    Color backgroundColor = Colors.green,
    Color textColor = Colors.white,
    double borderRadius = 10.0,
    EdgeInsets margin = const EdgeInsets.all(10),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: textColor,
      borderRadius: borderRadius,
      margin: margin,
    );
  }
}

void showSuccessDialog({
  required BuildContext context,
  String? textHeading,
  required String subTitle,
  VoidCallback? onPressed,
  bool navigateAfterDelay = false,
}) {
  if (navigateAfterDelay) {
    Future.delayed(const Duration(seconds: 0), () {
      if (Get.isDialogOpen!) {
        Get.back();
        onPressed?.call();
      }
    });
  }

  Get.defaultDialog(
    title: textHeading ?? "",
    titleStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.green,
    ),
    middleText: subTitle,
    middleTextStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    radius: 8.0,
    barrierDismissible: false,
    actions: [
      navigateAfterDelay == true
          ? const SizedBox
          .shrink() // यदि navigateAfterDelay false है तो खाली Widget दिखाएं
          : ButtonCard(
        color: Colors.green,
        width: 60,
        height: 40,
        text: "process",
        onPressed: onPressed ?? () => Get.back(),
      ),
    ],
  );
}

void showErrorDialog({
  required BuildContext context,
  required String subTitle,
  String? textHeading,
  VoidCallback? onPressed, // Optional onPressed parameter
  bool permanentlyDisableButton = false,
}) {
  RxBool isButtonDisabled = permanentlyDisableButton.obs;

  if (permanentlyDisableButton) {
    Future.delayed(const Duration(seconds: 10), () {
      if (Get.isDialogOpen!) {
        Get.back();
        onPressed?.call();
      }
    });
  }
  Get.defaultDialog(
    title: textHeading ?? "",
    titleStyle: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: Colors.red,
    ),
    middleText: subTitle,
    middleTextStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    radius: 8.0,
    barrierDismissible: false,
    actions: [
      Obx(() {
        if (isButtonDisabled.value) {
          return const SizedBox.shrink();
        } else {
          return ButtonCard(
            color: Colors.red,
            width: 60,
            height: 40,
            text: "Ok",
            onPressed: onPressed ?? () => Get.back(),
          );
        }
      }),
    ],
  );
}