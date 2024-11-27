import 'package:online/models/district_model.dart';
import 'package:online/models/division_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';

import 'package:online/models/profile/check_status_Register_Employee_model.dart';

class ApiServices {
  static Future<List<DivisionModel>?> getApiServices() async {
    final url =
        Uri.parse('https://heonline.cg.nic.in/lmsbackend/api/division/get-all');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse
            .map((data) => DivisionModel.fromJson(data))
            .toList();
      } else {
        Get.snackbar('Error', 'Failed to load divisions');
        return null;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      return null;
    }
  }

  static Future<List<DistrictModel>?> getApiServicesDistrictsByDivision(
      int divisionCode) async {
    final url = Uri.parse(
        'https://heonline.cg.nic.in/lmsbackend/api/district/get-division-district/$divisionCode');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);

        List<DistrictModel> data = jsonResponse
            .map((data) => DistrictModel.fromJson(data as Map<String, dynamic>))
            .toList();

        print(data);
        return data;
      } else {
        Get.snackbar('Error', 'Failed to load districts');
        return null;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      return null;
    }
  }
  ///api check status
  static Future<List<CheckStatusModelProfileLatLong>?> getEmployeeDetails(String empCode) async {
    final url = Uri.parse('http://164.100.150.78/lmsbackend/api/employee/get?empCode=$empCode');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse
            .map((data) => CheckStatusModelProfileLatLong.fromJson(data))
            .toList();
      } else {
        Get.snackbar('Error', 'Failed to load employee details');
        return null;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      return null;
    }
  }
}
