import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:online/models/division_model.dart';

class DivisionController extends GetxController {
  var isLoading = false.obs;

  var btnText = 'GET OTP'.obs;
  var isEnabled = false.obs;
  var isDetailLoading = false.obs;
  var isAddLoading = false.obs;
  var isDeleteLoading = false.obs;
  var edit = false.obs;
  var errorMsg = ''.obs;
  var selectedCompany = ''.obs;
  var selectedGroupWiseCompany = ''.obs;
  var divisionDetail = List<Division>.empty().obs;
  var mVisible = false.obs;
  var isUpdated = false.obs;
  var divisions = <Division>[].obs;
  var selectedDivisionCode = Rxn<int>();

  @override
  void onInit() {
    fetchDivisions();
    super.onInit();
  }

  Future<void> fetchDivisions() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(
          'https://heonline.cg.nic.in/lmsbackend/api/division/get-all'));

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        divisions.value = data.map((json) => Division.fromJson(json)).toList();
        if (divisions.isNotEmpty) {
          selectedDivisionCode.value = divisions.first.divisionCode!;
        }
      } else {
        print('Failed to load divisions');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
