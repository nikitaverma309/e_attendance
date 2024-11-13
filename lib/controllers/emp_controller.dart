import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:online/models/class_model.dart';
import 'dart:convert';

import 'package:online/models/college_model.dart';
import 'package:online/models/designation_model.dart';
import 'package:online/models/district_model.dart';
import 'package:online/models/division_model.dart';
import 'package:online/models/vidhan_sabha_model.dart';

class EmpController extends GetxController {
  var classList = <ClassModel>[].obs;
  var selectedClass = ''.obs;
  var designationList = <DesignationModel>[].obs;
  var selectedDesignation = ''.obs;
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
    fetchClass();
  }

  Future<void> fetchClass() async {
    final url =
        Uri.parse('https://heonline.cg.nic.in/lmsbackend/api/class/getAll');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        classList.value = classModelFromJson(response.body);
      } else {
        Get.snackbar('Error', 'Failed to load colleges');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
  Future<void> fetchClassByDesignation(String classId) async {
    final url = Uri.parse(
        'https://heonline.cg.nic.in/lmsbackend/api/degisnation-class-wise/$classId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        designationList.value = designationModelFromJson(response.body);
      } else {
        Get.snackbar('Error', 'Failed to load districts');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
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

  void selectClass(String classS) {
    selectedClass.value = classS;
    selectedDesignation.value = "";
    designationList.clear();
  }
  void selectDesignation(String designation) {
    selectedDesignation.value = designation;
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
