import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online/models/profile/check_status_Register_Employee_model.dart';
import 'package:online/utils/utils.dart';

class CheckStatusController extends GetxController {
  var isLoading = false.obs;
  final isChecked = false.obs;
  final isUserLocation = false.obs;
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
/*  Future<void> getCheckStatusLatLong(String empCode) async {
    isLoading(true);
    final response = await http.get(
      Uri.parse(
          'http://164.100.150.78/lmsbackend/api/employee/get?empCode=$empCode'),
    );
print("http://164.100.150.78/lmsbackend/api/employee/get?empCode=$empCode");
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData['msg'] == 'Employee Not Exists') {
        Utils.showErrorToast(message: 'Employee not found');
        isLoading(false);
        return;
      }
      try {
        employeeData.value = CheckStatusModelProfileLatLong.fromJson(jsonData);
        print(employeeData);
        if (employeeData.value != null) {
          Utils.showSuccessToast(message: 'Employee data has been successfully fetched and Matched');
        }
      } catch (e) {
        Utils.showErrorToast(message: 'Failed to parse employee data');
      }
    } else {
      print("Error occurred: ${response.statusCode}");
      Utils.showErrorToast(message: 'An unexpected error occurred.');
    }
    isLoading(false);
  }*/

  Future<void> getCheckStatusLatLong(String empCode) async {
    isLoading(true);

    // Fetch API Data
    final response = await http.get(
      Uri.parse(
          'http://164.100.150.78/lmsbackend/api/employee/get?empCode=$empCode'),
    );

    print(
        "API URL: http://164.100.150.78/lmsbackend/api/employee/get?empCode=$empCode");
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      try {
        // Decode JSON response (list of employees)
        List<dynamic> jsonList = json.decode(response.body);

        // Ensure data exists in the list
        if (jsonList.isEmpty) {
          Utils.showErrorToast(message: 'Employee not found');
          isLoading(false);
          return;
        }

        employeeData.value =
            CheckStatusModelProfileLatLong.fromJson(jsonList[0]);

        // Fetch Current Location
        Position currentPosition = await _determinePosition();
        double currentLat = currentPosition.latitude;
        double currentLong = currentPosition.longitude;

        // Validate location data
        if (employeeData.value?.collegeDetails?.lat != null &&
            employeeData.value?.collegeDetails?.long != null) {
          double apiLat =
              double.tryParse(employeeData.value!.collegeDetails!.lat!) ?? 0.0;
          double apiLong =
              double.tryParse(employeeData.value!.collegeDetails!.long!) ?? 0.0;

          double distanceInMeters = Geolocator.distanceBetween(
            currentLat,
            currentLong,
            apiLat,
            apiLong,
          );
          print("distanceInMeters was $distanceInMeters");
          if (distanceInMeters <= 150) {
            Utils.showSuccessToast(
                message: 'Location Matched. You can proceed.');
            isChecked.value = true; // Enable checkbox
            isUserLocation.value = true; // Enable checkbox

          } else {
            Utils.showErrorToast(
                message: 'Your location does not match the required location.');
            isChecked.value = false; // Disable checkbox
            isUserLocation.value = false; // Disable checkbox
          }
        } else {
          Utils.showErrorToast(
              message: 'Invalid or missing location data from API.');
          isChecked.value = false;
          isUserLocation.value = false;
        }
      } catch (e) {
        Utils.showErrorToast(message: 'Failed to parse employee data: $e');
      }
    } else {
      print("Error occurred: ${response.statusCode}");
      Utils.showErrorToast(message: 'An unexpected error occurred.');
    }

    isLoading(false);
  }

// Function to determine the current position
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
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
  }
}
