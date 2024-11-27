// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:online/models/profile/check_status_Register_Employee_model.dart';
// import 'package:online/modules/restriction_dialog/restrict_user_dialog.dart';
// import 'package:online/utils/utils.dart';
//
// class CheckStatusController extends GetxController {
//   var isLoading = false.obs;
//   final isChecked = false.obs;
//   var employeeData = Rx<CheckStatusModelProfileLatLong?>(null);
//   var attendanceIds = <String>[
//     "1",
//     "2",
//     "3",
//     "4",
//     "5",
//     "6",
//     "7",
//     "8",
//     "9",
//     "Reset",
//     "0",
//     "Back"
//   ].obs;
// /*  Future<void> getCheckStatusLatLong(String empCode) async {
//     isLoading(true);
//     final response = await http.get(
//       Uri.parse(
//           'http://164.100.150.78/lmsbackend/api/employee/get?empCode=$empCode'),
//     );
// print("http://164.100.150.78/lmsbackend/api/employee/get?empCode=$empCode");
//     print('Response Body: ${response.body}');
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       if (jsonData['msg'] == 'Employee Not Exists') {
//         Utils.showErrorToast(message: 'Employee not found');
//         isLoading(false);
//         return;
//       }
//       try {
//         employeeData.value = CheckStatusModelProfileLatLong.fromJson(jsonData);
//         print(employeeData);
//         if (employeeData.value != null) {
//           Utils.showSuccessToast(message: 'Employee data has been successfully fetched and Matched');
//         }
//       } catch (e) {
//         Utils.showErrorToast(message: 'Failed to parse employee data');
//       }
//     } else {
//       print("Error occurred: ${response.statusCode}");
//       Utils.showErrorToast(message: 'An unexpected error occurred.');
//     }
//     isLoading(false);
//   }*/
//
//
//
//
//   Future<void> getCheckStatusLatLong(String empCode,BuildContext context) async {
//     isLoading(true);
//
//     // Fetch API Data
//     final response = await http.get(
//       Uri.parse(
//           'http://164.100.150.78/lmsbackend/api/employee/get?empCode=$empCode'),
//     );
//
//     print("API URL: http://164.100.150.78/lmsbackend/api/employee/get?empCode=$empCode");
//     print('Response Body: ${response.body}');
//
//     if (response.statusCode == 200) {
//       try {
//         // Decode JSON response (list of employees)
//         List<dynamic> jsonList = json.decode(response.body);
//
//         // Ensure data exists in the list
//         if (jsonList.isEmpty) {
//           Utils.showErrorToast(message: 'Employee not found');
//           isLoading(false);
//           return;
//         }
//
//         // Parse the first employee data
//         employeeData.value =
//             CheckStatusModelProfileLatLong.fromJson(jsonList[0]);
//
//         // Fetch Current Location
//         Position currentPosition = await _determinePosition();
//         double currentLat = currentPosition.latitude;
//         double currentLong = currentPosition.longitude;
//
//         // Validate location data
//         if (employeeData.value?.collegeDetails?.lat != null &&
//             employeeData.value?.collegeDetails?.long != null) {
//           double apiLat = double.tryParse(employeeData.value!.collegeDetails!.lat!) ?? 0.0;
//           double apiLong = double.tryParse(employeeData.value!.collegeDetails!.long!) ?? 0.0;
//
//           // Calculate Distance
//           double distanceInMeters = Geolocator.distanceBetween(
//             currentLat,
//             currentLong,
//             apiLat,
//             apiLong,
//           );
//
//           print("Current Location: ($currentLat, $currentLong)");
//           print("API Location: ($apiLat, $apiLong)");
//           print("Distance: $distanceInMeters meters");
//
//           // Match Threshold
//           if (distanceInMeters <= 160) {
//             Utils.showSuccessToast(
//                 message: 'Location Matched. You can proceed.');
//             isChecked.value = true; // Enable checkbox
//           } else {
//             Utils.showErrorToast(
//                 message: 'Your location does not match the required location.');
//             isChecked.value = false; // Disable checkbox
//           }
//         } else {
//           Utils.showErrorToast(message: 'Invalid or missing location data from API.');
//           isChecked.value = false;
//         }
//       } catch (e) {
//         Utils.showErrorToast(message: 'Failed to parse employee data: $e');
//       }
//     } else {
//       print("Error occurred: ${response.statusCode}");
//       Utils.showErrorToast(message: 'An unexpected error occurred.');
//     }
//
//     isLoading(false);
//   }
//
//
//
// // Function to determine the current position
//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       throw Exception('Location services are disabled.');
//     }
//
//     // Check location permissions
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         throw Exception('Location permissions are denied.');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       throw Exception(
//           'Location permissions are permanently denied. Cannot request permissions.');
//     }
//
//     // Get current position
//     return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//   }
//
// /*  Future<void> getCheckStatusLatLong(
//       String empCode, BuildContext context) async {
//     isLoading(true);
//
//     // Fetch API Data
//     final response = await http.get(
//       Uri.parse(
//           'http://164.100.150.78/lmsbackend/api/employee/get?empCode=$empCode'),
//     );
//
//     print(
//         "API URL: http://164.100.150.78/lmsbackend/api/employee/get?empCode=$empCode");
//     print('Response Body: ${response.body}');
//
//     if (response.statusCode == 200) {
//       try {
//         // Decode JSON response (list of employees)
//         List<dynamic> jsonList = json.decode(response.body);
//
//         // Ensure data exists in the list
//         if (jsonList.isEmpty) {
//           Utils.showErrorToast(message: 'Employee not found');
//           isLoading(false);
//           return;
//         }
//
//         // Parse the first employee data
//         employeeData.value =
//             CheckStatusModelProfileLatLong.fromJson(jsonList[0]);
//
//         // Fetch Current Location
//         try {
//           Position currentPosition = await determinePosition(context);
//           double currentLat = currentPosition.latitude;
//           double currentLong = currentPosition.longitude;
//
//           // Validate location data
//           if (employeeData.value?.collegeDetails?.lat != null &&
//               employeeData.value?.collegeDetails?.long != null) {
//             double apiLat =
//                 double.tryParse(employeeData.value!.collegeDetails!.lat!) ??
//                     0.0;
//             double apiLong =
//                 double.tryParse(employeeData.value!.collegeDetails!.long!) ??
//                     0.0;
//
//             // Calculate Distance
//             double distanceInMeters = Geolocator.distanceBetween(
//               currentLat,
//               currentLong,
//               apiLat,
//               apiLong,
//             );
//
//             print("Current Location: ($currentLat, $currentLong)");
//             print("API Location: ($apiLat, $apiLong)");
//             print("Distance: $distanceInMeters meters");
//
//             // Match Threshold
//             if (distanceInMeters <= 160) {
//               Utils.showSuccessToast(
//                   message: 'Location Matched. You can proceed.');
//               isChecked.value = true; // Enable checkbox
//             } else {
//               Utils.showErrorToast(
//                   message:
//                       'Your location does not match the required location.');
//               isChecked.value = false; // Disable checkbox
//             }
//           } else {
//             Utils.showErrorToast(
//                 message: 'Invalid or missing location data from API.');
//             isChecked.value = false;
//           }
//         } catch (e) {
//           print("Error: $e");
//           // Error handling if location is off or denied
//         }
//       } catch (e) {
//         Utils.showErrorToast(message: 'Failed to parse employee data: $e');
//       }
//     } else {
//       print("Error occurred: ${response.statusCode}");
//       Utils.showErrorToast(message: 'An unexpected error occurred.');
//     }
//
//     isLoading(false);
//   }*/
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:online/api/api_services.dart';
import 'package:online/models/profile/check_status_Register_Employee_model.dart';
import 'package:online/utils/utils.dart';

class CheckStatusController extends GetxController {
  var isLoading = false.obs;
  final isChecked = false.obs;
  final isLocationMatched = false.obs;
  var employeeData = Rx<CheckStatusModelProfileLatLong?>(null);
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






  //
  // Future<void> getCheckStatusLatLong(String empCode, BuildContext context) async {
  //   isLoading(true);
  //
  //   try {
  //     // Fetch employee data using ApiServices
  //     var employeeDetails = await ApiServices.getEmployeeDetails(empCode);
  //
  //     if (employeeDetails != null && employeeDetails.isNotEmpty) {
  //       employeeData.value = employeeDetails[0]; // Assuming first element is needed
  //
  //       // Fetch current location
  //       Position currentPosition = await _determinePosition(context); // Pass context here
  //       double currentLat = currentPosition.latitude;
  //       double currentLong = currentPosition.longitude;
  //
  //       // Validate location data
  //       if (employeeData.value?.collegeDetails?.lat != null &&
  //           employeeData.value?.collegeDetails?.long != null) {
  //         double apiLat = double.tryParse(employeeData.value!.collegeDetails!.lat!) ?? 0.0;
  //         double apiLong = double.tryParse(employeeData.value!.collegeDetails!.long!) ?? 0.0;
  //
  //         // Calculate distance between current location and API location
  //         double distanceInMeters = Geolocator.distanceBetween(
  //           currentLat,
  //           currentLong,
  //           apiLat,
  //           apiLong,
  //         );
  //
  //         print("Current Location: ($currentLat, $currentLong)");
  //         print("API Location: ($apiLat, $apiLong)");
  //         print("Distance: $distanceInMeters meters");
  //
  //         // Set the flag if location matches
  //         if (distanceInMeters <= 160) {
  //           Utils.showSuccessToast(message: 'Location Matched. You can proceed.');
  //           isChecked.value = true; // Enable checkbox
  //           isLocationMatched = true; // Set location match flag
  //         } else {
  //           Utils.showErrorToast(message: 'Your location does not match the required location.');
  //           isChecked.value = false; // Disable checkbox
  //           isLocationMatched = false; // Reset location match flag
  //         }
  //       } else {
  //         Utils.showErrorToast(message: 'Invalid or missing location data from API.');
  //         isChecked.value = false;
  //         isLocationMatched = false; // Reset location match flag
  //       }
  //     } else {
  //       Utils.showErrorToast(message: 'Employee not found');
  //       isChecked.value = false;
  //       isLocationMatched = false; // Reset location match flag
  //     }
  //   } catch (e) {
  //     // Handle any errors
  //     Utils.showErrorToast(message: e.toString());
  //     isChecked.value = false; // Disable checkbox on error
  //     isLocationMatched = false; // Reset location match flag
  //   }
  //
  //   isLoading(false);
  // }


  Future<void> getCheckStatusLatLong(String empCode, BuildContext context) async {
    isLoading(true);

    try {
      // Fetch employee data using ApiServices
      var employeeDetails = await ApiServices.getEmployeeDetails(empCode);

      if (employeeDetails != null && employeeDetails.isNotEmpty) {
        employeeData.value = employeeDetails[0]; // Assuming first element is needed

        // Fetch current location
        Position currentPosition = await _determinePosition(context); // Pass context here
        double currentLat = currentPosition.latitude;
        double currentLong = currentPosition.longitude;

        // Validate location data
        if (employeeData.value?.collegeDetails?.lat != null &&
            employeeData.value?.collegeDetails?.long != null) {
          double apiLat = double.tryParse(employeeData.value!.collegeDetails!.lat!) ?? 0.0;
          double apiLong = double.tryParse(employeeData.value!.collegeDetails!.long!) ?? 0.0;

          // Calculate distance between current location and API location
          double distanceInMeters = Geolocator.distanceBetween(
            currentLat,
            currentLong,
            apiLat,
            apiLong,
          );

          print("Current Location: ($currentLat, $currentLong)");
          print("API Location: ($apiLat, $apiLong)");
          print("Distance: $distanceInMeters meters");

          // Check if location matches
          if (distanceInMeters <= 160) {
            Utils.showSuccessToast(message: 'Location Matched. You can proceed.');
            isChecked.value = true; // Enable checkbox
          } else {
            Utils.showErrorToast(message: 'Your location does not match the required location.');
            isChecked.value = false; // Disable checkbox
          }
        } else {
          Utils.showErrorToast(message: 'Invalid or missing location data from API.');
          isChecked.value = false;
        }
      } else {
        Utils.showErrorToast(message: 'Employee not found');
      }
    } catch (e) {
      // Handle any errors
      Utils.showErrorToast(message: e.toString());
      isChecked.value = false; // Disable checkbox on error
    }

    isLoading(false);
  }

// Function to get the current position (latitude, longitude)
  Future<Position> _determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Show dialog and exit if services are disabled
        await showLocationAlert(
          context,
          message: "Please enable location services to proceed",
          bottomMessage: "Location services are required for this feature.",
          showButton: true, // Show 'Enable Location' button
        );
        isLoading(false); // Stop loading when services are disabled
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
        throw Exception('Location permissions are permanently denied. Cannot request permissions.');
      }

      // Get current position
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      // Ensure loading is stopped if an error occurs
      isLoading(false);
      rethrow; // Propagate the exception
    }
  }

// Function to show an alert dialog when location services are disabled
  Future<void> showLocationAlert(BuildContext context,
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

}
