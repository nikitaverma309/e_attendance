import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:online/api/api_strings.dart';
import 'package:online/api/get_api_services.dart';
import 'package:online/models/droupDown/class_model.dart';
import 'package:online/models/droupDown/college_model.dart';
import 'package:online/models/droupDown/designation_model.dart';
import 'package:online/models/droupDown/district_model.dart';
import 'package:online/models/droupDown/division_model.dart';
import 'package:online/models/droupDown/vidhan_sabha_model.dart';
import 'package:online/utils/utils.dart';

class DropDownController extends GetxController {
  var isLoading = false.obs;
  var classList = <ClassModel>[].obs;
  var selectedClass = ''.obs;
  var designationList = <DesignationModel>[].obs;
  var selDesignation = ''.obs;
  var college = <CollegeModel>[].obs;
  var selectedCollege = ''.obs;
  var divisions = <DivisionModel>[].obs;
  var selectedDivision = ''.obs;
  var districts = <DistrictModel>[].obs;
  var selectedDistrict = ''.obs;
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
    isLoading.value = true;

    final List<ClassModel>? fetchedClassList = await ApiServices.fetchClass();
    if (fetchedClassList != null) {
      classList.value = fetchedClassList;
    }
    isLoading.value = false;
  }

  Future<void> fetchClassByDesignation(String classId) async {
    isLoading(true); // Start Loading
    Utils.printLog("Fetching data for class ID: $classId");

    final fetchedData = await ApiServices.fetchClassByDesignation(classId);

    if (fetchedData != null) {
      designationList.value = fetchedData;
      Utils.printLog("Response Designation Body: ${fetchedData}");
    }

    isLoading(false); // End Loading
  }

  Future<void> fetchCollege() async {
    final url = Uri.parse(ApiStrings.college);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        college.value = collegeModelFromJson(response.body);
      }
    } catch (e) {
      Utils.printLog("Error was $e");
    }
  }

  Future<void> fetchDivisions() async {
    final url = Uri.parse(ApiStrings.division);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      divisions.value = divisionModelFromJson(response.body);
    }
  }

  Future<void> fetchDistrictsByDivision(int divisionCode) async {
    final url = Uri.parse('${ApiStrings.district}/$divisionCode');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        districts.value = districtModelFromJson(response.body);
        Utils.printLog("Data was fetch Districts By Division $districts.value");
      }
    } catch (e) {
      Utils.printLog("Error was $e");
    }
  }

  Future<void> getVidhanSabhaByDivision(int districtLgdCode) async {
    final url = Uri.parse('${ApiStrings.getVidhansabha}/$districtLgdCode');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var re = vidhanSabha.value = vidhanModelFromJson(response.body);

        Utils.printLog("Data was Vidhan Sabha By Division $re");
      }
    } catch (e) {
      Utils.printLog("error was $e");
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
}
