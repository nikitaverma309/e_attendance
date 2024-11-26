import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online/models/profile/check_status_profile_model.dart';
import 'package:online/utils/utils.dart';

class CheckStatusController extends GetxController {
  var isLoading = false.obs;
  final isChecked = false.obs;
  var employeeData = Rx<CheckStatusModelProfile?>(null);
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

  Future<void> getCheckStatus(String empCode) async {
    isLoading(true);
    final response = await http.get(
      Uri.parse(
          'http://164.100.150.78/lmsbackend/api/employee/get?empCode=$empCode'),
    );

    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData['msg'] == 'Employee Not Exists') {
        Utils.showErrorToast(message: 'Employee not found');
        isLoading(false);
        return;
      }
      try {
        employeeData.value = CheckStatusModelProfile.fromJson(jsonData);
        print(employeeData);
        if (employeeData.value != null) {
          Utils.showSuccessToast(message: 'Employee data fetched successfully');
        }
      } catch (e) {
        print("Error parsing employee data: $e");
        Utils.showErrorToast(message: 'Failed to parse employee data');
      }
    } else {
      print("Error occurred: ${response.statusCode}");
      Utils.showErrorToast(message: 'An unexpected error occurred.');
    }
    isLoading(false);
  }
}
