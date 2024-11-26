import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:online/models/class_model.dart';
import 'dart:convert';

import 'package:online/models/college_model.dart';
import 'package:online/models/designation_model.dart';
import 'package:online/models/district_model.dart';
import 'package:online/models/division_model.dart';
import 'package:online/models/vidhan_sabha_model.dart';
import 'package:online/utils/utils.dart';
import 'package:online/widgets/common/custom_widgets.dart';

class EmpController extends GetxController {
  var isLoading = false.obs;
  var classList = <ClassModel>[].obs;
  var selectedClass = ''.obs;
  var designationList = <DesignationModel>[].obs;
  var selDesignation = ''.obs;
  var college = <CollegeModel>[].obs;
  var selectedCollege = ''.obs;
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
        Uri.parse('https://heonline.cg.nic.in/staging/api/class/getAll');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Utils.printLog("Response  Body ${response.body}");
        Utils.printLog("Response statusCode ${response.statusCode}");
        classList.value = classModelFromJson(response.body);
        Utils.printLog("Response  Body ${response.body}");
        Utils.printLog("Response statusCode ${response.statusCode}");
      } else {
        CustomSnackbarError.showSnackbar(
          title: "Error",
          message: 'Failed to load Class',
        );
      }
    } catch (e) {
      Utils.printLog("classList ${classList.value}");
      CustomSnackbarError.showSnackbar(
        title: "Error",
        message: 'An error occurred: $e',
      );
    }
  }

  Future<void> fetchClassByDesignation(String classId) async {
    print("pass data $classId");
    final url = Uri.parse(
        'https://heonline.cg.nic.in/staging/api/degisnation-class-wise/$classId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      designationList.value = designationModelFromMap(response.body);
      Utils.printLog("Response Designation Body ${response.body}");
      Utils.printLog("Response statusCode ${response.statusCode}");
    } else {
      CustomSnackbarError.showSnackbar(
        title: "Error",
        message: 'Failed to load Designation',
      );
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
        CustomSnackbarError.showSnackbar(
          title: "Error",
          message: 'Failed to load colleges',
        );
      }
    } catch (e) {
      Utils.printLog("Error was $e");
      CustomSnackbarError.showSnackbar(
        title: "Error",
        message: 'An error occurred: $e',
      );
    }
  }

  Future<void> fetchDivisions() async {
    final url =
        Uri.parse('https://heonline.cg.nic.in/lmsbackend/api/division/get-all');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      divisions.value = divisionModelFromJson(response.body);
    } else {
      CustomSnackbarError.showSnackbar(
        title: "Error",
        message: 'Failed to load divisions',
      );
    }
  }

  Future<void> fetchDistrictsByDivision(int divisionCode) async {
    final url = Uri.parse(
        'https://heonline.cg.nic.in/lmsbackend/api/district/get-division-district/$divisionCode');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        districts.value = districtModelFromJson(response.body);
        Utils.printLog("Data was $districts.value");
      } else {
        CustomSnackbarError.showSnackbar(
          title: "Error",
          message: 'Failed to load districts',
        );
      }
    } catch (e) {
      Utils.printLog("Error was $e");
      CustomSnackbarError.showSnackbar(
        title: "Error",
        message: 'An error occurred: $e',
      );
    }
  }

  Future<void> getVidhanSabhaByDivision(int districtLgdCode) async {
    final url = Uri.parse(
        'https://heonline.cg.nic.in/lmsbackend/api/district/getVidhansabha-district-wise/$districtLgdCode');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var re = vidhanSabha.value = vidhanModelFromJson(response.body);
        Utils.printLog("Data was $re");
      } else {
        CustomSnackbarError.showSnackbar(
          title: "Error",
          message: 'Failed to load vidhanSaba',
        );
      }
    } catch (e) {
      Utils.printLog("error was $e");
      CustomSnackbarError.showSnackbar(
        title: "Error",
        message: 'An error occurred: $e',
      );
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
    selDesignation.value = "";
    designationList.clear();
  }

  void selectDesignationOOb(String designation) {
    selDesignation.value = designation;
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
    required String workType,
  }) async {
    final url =
        Uri.parse('https://heonline.cg.nic.in/staging/api/employee/add');

    final body = jsonEncode({
      "name": name,
      "empCode": empCode,
      "email": email,
      "contact": contact,
      "divison": division,
      "district": district,
      "vidhansabha": vidhanSabha,
      "college": college,
      "designation": designation,
      "classData": classData,
      "address": address,
      "workType": workType,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        print("Request Parameters:");
        print("Name: $name");
        print("EmpCode: $empCode");
        print("Email: $email");
        print("Contact: $contact");
        print("Division: $division");
        print("District: $district");
        print("Vidhan Sabha: $vidhanSabha");
        print("College: $college");
        print("Designation: $designation");
        print("ClassData: $classData");
        print("Address: $address");
        print("WorkType: $workType");
        print("Success: $responseData");
        Get.snackbar(
          'Success',
          'Employee registered successfully.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        final responseData = json.decode(response.body);
        print(responseData);
        print(response.body);
        print("Request Body: $body");

        print(response.statusCode);
        String errorMessage =
            responseData['msg'] ?? 'An unexpected error occurred';
        print("Error: $errorMessage");
        print("Request Parameters:");
        print("Name: $name");
        print("EmpCode: $empCode");
        print("Email: $email");
        print("Contact: $contact");
        print("Division: $division");
        print("District: $district");
        print("Vidhan Sabha: $vidhanSabha");
        print("College: $college");
        print("Designation: $designation");
        print("ClassData: $classData");
        print("Address: $address");
        print("WorkType: $workType");
        CustomSnackbarError.showSnackbar(
          title:
              "This employee already exists. Please verify the details or try a different entry",
          message: errorMessage,
        );
      }
    } catch (e) {
      CustomSnackbarError.showSnackbar(
        title: "Error",
        message: "An error occurred: $e",
      );
    }
  }
}
