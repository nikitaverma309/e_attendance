import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:online/api/api_services.dart';
import 'package:online/models/profile/check_status_Register_Employee_model.dart';
import 'package:online/modules/restriction_dialog/restrict_user_dialog.dart';
import 'package:online/utils/utils.dart';

class CheckStatusController extends GetxController {
  var isLoading = false.obs;
  final isChecked = false.obs;
  final isLocationMatched = false.obs;
  var incorrectAttempts = 0.obs;
  var isBlocked = false.obs; // To block the user
  Timer? blockTimer;

// Method to reset the block state
  void resetBlock() {
    Utils.printLog("timer reset after 10seconds");
    incorrectAttempts.value = 0;
    isBlocked.value = false;
    blockTimer?.cancel();
  }

// Method to handle incorrect attempts
  void handleIncorrectAttempt() {
    incorrectAttempts.value++;
    if (incorrectAttempts.value >= 3) {
      isBlocked.value = true;
      blockTimer = Timer(const Duration(seconds: 30), resetBlock);

    }
  }

  @override
  void onClose() {
    blockTimer?.cancel();
    super.onClose();
  }

  var employeeData = Rx<UserProfileModel?>(null);
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
      String empCode, BuildContext context) async {
    isLoading(true);

    try {
      // Fetch employee data using ApiServices
      var employeeDetails =
          await ApiServices.getCheckEmployeeLatLongApiServices(empCode);

      if (employeeDetails != null && employeeDetails.isNotEmpty) {
        employeeData.value =
            employeeDetails[0]; // Assuming first element is needed

        // Fetch current location
        Position currentPosition =
            await determinePosition(context); // Pass context here
        double currentLat = currentPosition.latitude;
        double currentLong = currentPosition.longitude;
        double? compareLat = double.tryParse(kDebugMode
            ? employeeData.value!.collegeDetails!.homeLat!
            : employeeData.value!.collegeDetails!.lat!);
        double? compareLong = double.tryParse(kDebugMode
            ? employeeData.value!.collegeDetails!.homeLong!
            : employeeData.value!.collegeDetails!.long!);
        // Validate location data
        if (compareLat != null && compareLong != null) {
          double distanceInMeters = Geolocator.distanceBetween(
            currentLat,
            currentLong,
            compareLat,
            compareLong,
          );
          print("Current Location: ($currentLat, $currentLong)");
          print("API Location: ($compareLat, $compareLong)");
          print("check lat home : (${employeeData.value!.collegeDetails!.homeLong})");
          print("check lat mantralaya: (${employeeData.value!.collegeDetails!.long})");
          print("Distance: $distanceInMeters meters");

          // Check if location matches
          if (distanceInMeters <= 160) {
            Utils.showSuccessToast(
                message: 'Location Matched. You can proceed.');
            isChecked.value = true; // Enable checkbox
            isLocationMatched.value = true; // Enable checkbox
          } else {
            Utils.showErrorToast(
                message: 'Your location does not match the required location.');
            isChecked.value = false; // Disable checkbox
            isLocationMatched.value = false; // Disable checkbox
          }
        } else {
          Utils.showErrorToast(
              message: 'Invalid or missing location data from API.');
          isChecked.value = false;
          isLocationMatched.value = false;
        }
      } else {
        Utils.showErrorToast(message: 'Employee not found');
      }
    } catch (e) {
      // Handle any errors
      Utils.showErrorToast(message: e.toString());
      isChecked.value = false; // Disable checkbox on error
      isLocationMatched.value = false; // Disable checkbox on error
    }

    isLoading(false);
  }
}
