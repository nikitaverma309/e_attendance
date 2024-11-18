import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/designation_model.dart';

class DesignationController extends GetxController {


  var designations = <Designation>[].obs;
  var selectedDesignation = ''.obs;

  var isLoading = false.obs;


  // Fetch designations for selected class
  Future<void> fetchDesignations(String classId) async {
    isLoading.value = true;
    final url =
        'https://heonline.cg.nic.in/staging/api/degisnation-class-wise/$classId';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        designations.value =
            data.map((e) => Designation.fromJson(e)).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch designations: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }



  // Set the selected designation
  void selectDesignation(String designationId) {
    selectedDesignation.value = designationId;
    print('Selected Designation ID: $designationId');
  }
}
