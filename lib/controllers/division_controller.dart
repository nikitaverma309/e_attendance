import 'package:get/get.dart';
import 'package:online/api/api_services.dart';
import 'package:online/models/district_model.dart';
import 'package:online/models/division_model.dart';

class DivisionController extends GetxController {
  var divisionList = List<DivisionModel>.empty().obs;
  var districtList = List<DistrictModel>.empty().obs;
  var selectedDivisionCode = Rx<int?>(null); // Set to null initially
  var selectedDistrictCode = Rx<int?>(null); // Set to null initially
  var districts = <DistrictModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDivisions();
// Ensure selectedDivisionCode.value is not null before using it
    if (selectedDivisionCode.value != null) {
      fetchDistrictsByDivision(selectedDivisionCode.value!);
    }
  }

  Future<void> fetchDivisions() async {
    try {
      final divisionsList = await ApiServices.getApiServices();
      if (divisionsList != null) {
        divisionList.value = divisionsList;
        print(divisionsList);
        // Set default division code and fetch corresponding districts
        selectedDivisionCode.value = divisionsList.first.divisionCode;
        // Set default division code if available
        await fetchDistrictsByDivision(selectedDivisionCode.value!);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load divisions');
    }
  }

  Future<void> fetchDistrictsByDivision(int selectedDivisionCode) async {
    isLoading.value = true;
    final fetchedDistricts =
        await ApiServices.getApiDistrictsByDivision(selectedDivisionCode);
    // Reset selectedDistrictCode if districtList is updated
    selectedDistrictCode.value = districtList.isNotEmpty ? districtList.first.lgdCode : null;
    if (fetchedDistricts != null) {
      districtList.value =
          fetchedDistricts; // Ensure the districtList is updated
    }
    isLoading.value = false;
  }
/*  Future<void> fetchDistrictsByDivision(int selectedDivisionCode) async {
    isLoading.value = true;
    try {
      final fetchedDistricts = await ApiServices.getApiDistrictsByDivision(selectedDivisionCode);
      if (fetchedDistricts != null) {
        districtList.value = fetchedDistricts;
        // Reset selectedDistrictCode if districtList is updated
        selectedDistrictCode.value = districtList.isNotEmpty ? districtList.first.lgdCode : null;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load districts');
    } finally {
      isLoading.value = false;
    }
  }*/
  // Future<void> fetchDistrictsByDivision(int divisionCode) async {
  //   isLoading.value = true;
  //   final fetchedDistricts = await ApiServices.getApiDistrictsByDivision(divisionCode);
  //   if (fetchedDistricts != null) {
  //     districts.value = fetchedDistricts;
  //   }
  //   isLoading.value = false;
  // }
}
