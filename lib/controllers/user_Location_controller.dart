import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:online/api/get_api_services.dart';
import 'package:online/models/profile/check_user_location_model.dart';
import 'package:online/modules/restriction_dialog/restrict_user_dialog.dart';
import 'package:online/utils/utils.dart';

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
  //     String empCode, BuildContext context) async {
  //   isLoading(true);
  //   try {
  //     var employeeDetails =
  //         await ApiServices.getUserLocationApiServices(empCode);
  //     if (employeeDetails != null && employeeDetails.isNotEmpty) {
  //       Position currentPosition = await determinePosition(context);
  //       employeeData.value = employeeDetails[0];
  //       double currentLat = currentPosition.latitude;
  //       double currentLong = currentPosition.longitude;
  //       double? compareLat = double.tryParse(kDebugMode
  //           ? employeeData.value!.collegeDetails!.homeLat!
  //           : employeeData.value!.collegeDetails!.lat!);
  //       double? compareLong = double.tryParse(kDebugMode
  //           ? employeeData.value!.collegeDetails!.homeLong!
  //           : employeeData.value!.collegeDetails!.long!);
  //       if (compareLat != null && compareLong != null) {
  //         double distanceInMeters = Geolocator.distanceBetween(
  //           currentLat,
  //           currentLong,
  //           compareLat,
  //           compareLong,
  //         );
  //         Utils.printLog("Current Location: ($currentLat, $currentLong)");
  //         Utils.printLog("API Location: ($compareLat, $compareLong)");
  //         Utils.printLog(
  //             "check lat home : (${employeeData.value!.collegeDetails!.homeLat})");
  //         Utils.printLog(
  //             "check lat : (${employeeData.value!.collegeDetails!.lat})");
  //         Utils.printLog("Distance: $distanceInMeters meters");
  //
  //         if (distanceInMeters <= 160) {
  //           Utils.showSuccessToast(
  //               message: 'Location Matched. You can proceed.');
  //           isChecked.value = true;
  //           isLocationMatched.value = true;
  //         } else {
  //           Utils.showErrorToast(
  //               message: 'Your location does not match the required location.');
  //           isChecked.value = false;
  //           isLocationMatched.value = false;
  //         }
  //       } else {
  //         Utils.showErrorToast(
  //             message: 'Invalid or missing location data from API.');
  //         isChecked.value = false;
  //         isLocationMatched.value = false;
  //       }
  //     } else {
  //       Utils.showErrorToast(message: 'Employee not found');
  //     }
  //   } catch (e) {
  //     // Handle any errors
  //     Utils.showErrorToast(message: e.toString());
  //     isChecked.value = false; // Disable checkbox on error
  //     isLocationMatched.value = false; // Disable checkbox on error
  //   }
  //
  //   isLoading(false);
  // }

  Future<void> getCheckStatusLatLong(String empCode, BuildContext context) async {
    isLoading(true);
    try {
      var employeeDetails =
      await ApiServices.getUserLocationApiServices(empCode);
      if (employeeDetails != null && employeeDetails.isNotEmpty) {
        Position currentPosition = await determinePosition(context);
        employeeData.value = employeeDetails[0];
        double currentLat = currentPosition.latitude;
        double currentLong = currentPosition.longitude;
        double? compareLat = double.tryParse(kDebugMode
            ? employeeData.value!.collegeDetails!.lat!
            : employeeData.value!.collegeDetails!.lat!);
        double? compareLong = double.tryParse(kDebugMode
            ? employeeData.value!.collegeDetails!.long!
            : employeeData.value!.collegeDetails!.long!);

        // If latitude and longitude from API are valid
        if (compareLat != null && compareLong != null) {
          double distanceInMeters = Geolocator.distanceBetween(
            currentLat,
            currentLong,
            compareLat,
            compareLong,
          );

          Utils.printLog("Current Location: ($currentLat, $currentLong)");
          Utils.printLog("API Location: ($compareLat, $compareLong)");
          Utils.printLog("Distance: $distanceInMeters meters");

          // Check if the distance is within 160 meters
          if (distanceInMeters <= 160) {
            Utils.showSuccessToast(message: 'Location Matched. You can proceed.');
            isChecked.value = true;
            isLocationMatched.value = true;
          } else {
            Utils.showErrorToast(
                message: 'Your location does not match the required location.');
            isChecked.value = false;
            isLocationMatched.value = false;
          }
        } else {
          Utils.showErrorToast(
              message: 'Invalid or missing location data from API.');
          isChecked.value = false;
          isLocationMatched.value = false;
        }
      } else {
        // Employee not found case
        Utils.showErrorToast(message: 'Employee not found.');
        isChecked.value = false;
        isLocationMatched.value = false;
      }
    } catch (e) {
      // Handle any errors
      Utils.showErrorToast(message: e.toString());
      isChecked.value = false;
      isLocationMatched.value = false;
    }
    isLoading(false);
  }

}
