import 'package:get/get.dart';
import 'package:online/api/api_services.dart';
import 'package:online/models/district_model.dart';
import 'package:online/models/division_model.dart';

class DivisionController extends GetxController {
  var isLoading = false.obs;
  var divisionList = List<DivisionModel>.empty().obs;
  var districtList = List<DistrictModel>.empty().obs;
  var selectedDivisionCode = Rx<int?>(null);
  var selectedDistrictCode = Rx<int?>(null);
  var districts = <DistrictModel>[].obs;


  var divisions = <DivisionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDivisions();
    if (selectedDivisionCode.value != null) {
      fetchDistrictsByDivision(selectedDivisionCode.value!);
    }
  }

  Future<void> fetchDivisions() async {
    try {
      final dataDivision = await ApiServices.getApiServices();
      if (dataDivision != null) {
        divisionList.value = dataDivision;
        print(dataDivision);
        selectedDivisionCode.value = dataDivision.first.divisionCode;
        // Set default division code if available
        await fetchDistrictsByDivision(selectedDivisionCode.value!);
        selectedDistrictCode.value = null;
        divisionList.clear();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load divisions');
    }
  }

  Future<void> fetchDistrictsByDivision(int selectedDivisionCode) async {
    isLoading.value = true;
    final fetchedDistricts =
        await ApiServices.getApiServicesDistrictsByDivision(selectedDivisionCode);
    if (fetchedDistricts != null && fetchedDistricts.isNotEmpty) {
      districtList.value = fetchedDistricts;
      selectedDistrictCode.value = fetchedDistricts.first.lgdCode;
    } else {
      Get.snackbar('Error', 'No districts found for the selected division');
    }

    isLoading.value = false;
  }
}
