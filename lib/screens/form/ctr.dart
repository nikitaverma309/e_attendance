import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DivisionController extends GetxController {
  var divisions = [].obs;
  var selectedDivision = ''.obs;
  var districts = [].obs;
  var selectedDistrict = ''.obs;
  var vidhanSabha = [].obs;
  var selectedVidhanSabha = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDivisions();
    // fetchDistrictsByDivision(1);
  }

  Future<void> fetchDivisions() async {
    final url =
        Uri.parse('https://heonline.cg.nic.in/lmsbackend/api/division/get-all');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        divisions.value = json.decode(response.body);
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
        districts.value = json.decode(response.body);
      } else {
        Get.snackbar('Error', 'Failed to load districts');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
  Future<void> getVidhanSabhaByDivision(int districtLgdCode) async {
    final url = Uri.parse(
        'http://heonline.cg.nic.in/lmsbackend/api/district/getVidhansabha-district-wise/$districtLgdCode');
    // http://heonline.cg.nic.in/lmsbackend/api/district/getVidhansabha-district-wise/:districtLgdCode
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {

        var re = vidhanSabha.value = json.decode(response.body);
        print(re);
      } else {
        Get.snackbar('Error', 'Failed to load vidhanSaba');
      }
    } catch (e) {
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
    selectedDivision.value = ce;
  }
  //
  // void selectDivision(String divisionCode) {
  //   selectedDivision.value = divisionCode;
  // }
}
