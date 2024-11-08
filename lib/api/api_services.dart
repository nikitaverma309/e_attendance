import 'package:online/models/district_model.dart';
import 'package:online/models/division_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart'; // Make sure to import Get for Get.snackbar
import 'dart:convert';

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

  static Future<List<DistrictModel>?> getApiDistrictsByDivision(
      int divisionCode) async {
   // final url = Uri.parse(
     //   'https://heonline.cg.nic.in/lmsbackend/api/district/get-division-district/:divisionCode=$divisionCode');
    final url = Uri.parse('https://heonline.cg.nic.in/lmsbackend/api/district/get-division-district/$divisionCode');

    try {
      final response = await http.get(url); // Changed client.get to http.get
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        var data =
            jsonResponse.map((data) => DistrictModel.fromJson(data)).toList();
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
}
