import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:online/api/api_services.dart';
import 'package:online/models/division_model.dart';

class EmployeeRegistrationController extends GetxController {
  var isLoading = false.obs;
  var errorMsg = ''.obs;
  var mVisible = false.obs;
  var isUpdated = false.obs;
  var divisionsList = [].obs;
  var divisionList = List<DivisionModel>.empty().obs;
  var selectedDivision = Rxn<DivisionModel>();
  var districts = [].obs;
  var selectedDistrict = ''.obs;
  var selectedDivisionCode = RxnInt(); // Use RxnInt for nullable int


  @override
  void onInit() {
    super.onInit();
    getDivision();
  }

  void getDivision() async {
    try {
      isLoading(true);
      var data = await ApiServices.getApiServices();
      if (data != null) {
        divisionsList.value = data;
        errorMsg.value = '';
      } else {
        errorMsg.value = 'Data not found!';
      }
    } finally {
      isLoading(false);
    }
  }

  // This method can be used to select a division and update the selected division
  void selectDivision(DivisionModel division) {
    selectedDivision.value = division;
  }

  void getDistrict(int divisionCode) async {
    try {
      isLoading(true);
      divisionsList.value = [];
      var data = await ApiServices.getApiDistrictsByDivision(
          divisionCode); // Removed 'int'
      if (data != null) {
        divisionsList.value = data as List; // Ensure data is a List here
        errorMsg.value = '';
      } else {
        errorMsg.value = 'Data not found!';
      }
    } finally {
      isLoading(false);
    }
  }
}
