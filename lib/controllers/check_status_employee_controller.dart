import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:online/api/api_strings.dart';
import 'package:online/models/check_emp_status_model.dart';
import 'package:online/screens/form/emp_form.dart';
import 'dart:convert';

import 'package:online/utils/utils.dart';

class CheckStatusEmployeeController extends GetxController {
  var isLoading = false.obs;
  var employeeData = {GetEmployeeCode}.obs;
  var employeeDataA = Rxn<CheckStatusModel>();


  Future<void> fetchEmployeeData(String empCode, String contact) async {
    isLoading(true);
    final url = '${ApiStrings.checkStatus}empCode=$empCode&contact=$contact';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final checkStatusModel = CheckStatusModel.fromJson(data);

      if (checkStatusModel.msg == "FOUND") {
        employeeDataA.value = checkStatusModel;

        // Create an instance of GetEmployeeCode and pass it to the next page
        final sendData = checkStatusModel.getEmployeeCode;
        Utils.showSuccessToast(message: 'Employee data found successfully!');

        // Navigate to EmployeeRegistrationForm with sendData
        Get.to(() => EmployeeRegistrationForm(
          employeeData: sendData,
        ));
      } else {
        Utils.showErrorToast(message: 'Employee not found');
      }
    }
    isLoading(false);
  }



}