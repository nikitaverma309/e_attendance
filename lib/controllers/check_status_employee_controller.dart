import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:online/screens/form/emp_form.dart';
import 'dart:convert';

import 'package:online/utils/utils.dart';

class CheckStatusEmployeeController extends GetxController {
  var isLoading = false.obs;
  var employeeData = {}.obs;

  Future<void> fetchEmployeeData(String empCode, String contact) async {
    isLoading(true);
    try {
      final url = 'https://heonline.cg.nic.in/lmsbackend/api/employee-code/check?empCode=$empCode&contact=$contact';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print(response.statusCode);
        final data = json.decode(response.body);
        print(data);
        if (data['msg'] == "FOUND") {
          employeeData.value = data['getEmployeeCode'];
          Utils.showSuccessToast(message: 'Employee data found was successfully!');
          Get.to(() => EmployeeRegistrationForm(
            employeeData: employeeData.value as Map<String, dynamic>,
          ));
          Get.snackbar("Success", "Employee data found");
        } else {
          Get.snackbar("Error", "Employee not found");
        }
      } else {
        Get.snackbar("Error", "Failed to fetch data");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}
