import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';

import 'package:online/models/profile/check_status_Register_Employee_model.dart';

class ApiServices {
  ///api check status
  static Future<List<CheckStatusModelProfileLatLong>?> getCheckEmployeeLatLongApiServices(
      String empCode) async {
    final url = Uri.parse(
        'http://164.100.150.78/lmsbackend/api/employee/get?empCode=$empCode');

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
