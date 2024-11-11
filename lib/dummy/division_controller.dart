import 'package:get/get.dart';
import 'package:online/api/api_services.dart';
import 'package:online/models/district_model.dart';
import 'package:online/models/division_model.dart';

class DivisionController extends GetxController {
  var isLoading = false.obs;
  var divisionList = List<DivisionModel>.empty().obs;
  var districtList = List<DistrictModel>.empty().obs;
  var selectedDivisionCode = Rx<int?>(null); // Set to null initially
  var selectedDistrictCode = Rx<int?>(null); // Set to null initially
  var districts = <DistrictModel>[].obs;
  var division = <DistrictModel>[].obs;

  var divisions = <DivisionModel>[].obs;
  //var selectedDivisionCode = Rxn<int>();

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
      final dataDivision = await ApiServices.getApidemoServices();
      if (dataDivision != null) {
        divisionList.value = dataDivision;
        print(dataDivision);
        // Set default division code and fetch corresponding districts
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

    // Fetch districts from the API
    final fetchedDistricts = await ApiServices.getApiDemoDistrictsByDivision(selectedDivisionCode);

    if (fetchedDistricts != null && fetchedDistricts.isNotEmpty) {
      // Set districtList with the fetched list of DistrictModel
      districtList.value = fetchedDistricts;

      // Assign the lgdCode of the first district to selectedDistrictCode
      selectedDistrictCode.value = fetchedDistricts.first.lgdCode;
    } else {
      // Handle empty or null fetchedDistricts
      Get.snackbar('Error', 'No districts found for the selected division');
    }

    isLoading.value = false;
  }

}
