import 'package:online/models/district_model.dart';
import 'package:online/models/division_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';

class ApiServices {

  static Future<List<DivisionModel>?> getApidemoServices() async {
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

  static Future<List<DistrictModel>?> getApiDemoDistrictsByDivision(
      int divisionCode) async {
    final url = Uri.parse(
        'https://heonline.cg.nic.in/lmsbackend/api/district/get-division-district/$divisionCode');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Decode the JSON and cast it to a List<Map<String, dynamic>>
        List<dynamic> jsonResponse = jsonDecode(response.body);

        // Map each JSON object in the list to a DistrictModel instance
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
}
