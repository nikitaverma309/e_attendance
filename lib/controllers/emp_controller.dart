import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:online/models/college_model.dart';
import 'package:online/models/district_model.dart';
import 'package:online/models/division_model.dart';
import 'package:online/models/vidhan_sabha_model.dart';

class EmpController extends GetxController {
  var college = <CollegeModel>[].obs;
  var selectedCollege = ''.obs;
  //var divisions = [].obs;
  var divisions = <DivisionModel>[].obs;
  var selectedDivision = ''.obs;
  // var districts = [].obs;
  var districts = <DistrictModel>[].obs;
  var selectedDistrict = ''.obs;
  // var vidhanSabha = [].obs;
  var vidhanSabha = <VidhanModel>[].obs;
  var selectedVidhanSabha = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDivisions();
    fetchCollege();
  }

  Future<void> fetchCollege() async {
    final url = Uri.parse(
        'https://heonline.cg.nic.in/lmsbackend/api/college/get-all-college');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Parse JSON data to List<CollegeModel>
        college.value = collegeModelFromJson(response.body);
      } else {
        Get.snackbar('Error', 'Failed to load colleges');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  Future<void> fetchDivisions() async {
    final url =
        Uri.parse('https://heonline.cg.nic.in/lmsbackend/api/division/get-all');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        divisions.value = divisionModelFromJson(response.body);
      } else {
        Get.snackbar('Error', 'Failed to load divisions');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  Future<void> fetchDistrictsByDivision(int divisionCode) async {
    final url = Uri.parse(
        'https://heonline.cg.nic.in/lmsbackend/api/district/get-division-district/$divisionCode');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        districts.value = districtModelFromJson(response.body);
      } else {
        Get.snackbar('Error', 'Failed to load districts');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  Future<void> getVidhanSabhaByDivision(int districtLgdCode) async {
    final url = Uri.parse(
        'https://heonline.cg.nic.in/lmsbackend/api/district/getVidhansabha-district-wise/$districtLgdCode');
    //http://heonline.cg.nic.in/lmsbackend/api/district/getVidhansabha-district-wise/:districtLgdCode
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var re = vidhanSabha.value = vidhanModelFromJson(response.body);
        print(re);
      } else {
        Get.snackbar('Error', 'Failed to load vidhanSaba');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  void selectDivision(String divisionCode) {
    selectedDivision.value = divisionCode;
    selectedDistrict.value = '';
    districts.clear();
  }

  void selectDistrict(String districtId) {
    selectedDistrict.value = districtId;
    selectedVidhanSabha.value = '';
    vidhanSabha.clear();
  }

  void selectVidhanSabha(String ce) {
    selectedVidhanSabha.value = ce;
  }

  void selectCollege(String college) {
    selectedCollege.value = college;
  }

  Future<void> addEmployee({
    required String name,
    required String empCode,
    required String email,
    required String contact,
    required String division,
    required String district,
    required String vidhanSabha,
    required String college,
    required String designation,
    required String classData,
    required String address,
  }) async {
    final url =
        Uri.parse('http://heonline.cg.nic.in/lmsbackend/api/employee/add');
    final body = jsonEncode({
      "name": name,
      "empCode": empCode,
      "email": email,
      "contact": contact,
      "division": division,
      "district": district,
      "vidhanSabha": vidhanSabha,
      "college": college,
      "designation": designation,
      "classData": classData,
      "address": address,
    });

    try {
      print("Employee Data: $name, $empCode, "
          "$email, $contact, $division, $district,"
          " $vidhanSabha, $college, $designation,"
          " $classData, $address");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Employee registered successfully');
      } else {
        Get.snackbar('Error', 'Failed to register employee');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
