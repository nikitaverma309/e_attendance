import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online/models/profile/profile_model.dart';
import 'package:online/utils/utils.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  final isChecked = false.obs;
  var employeeData = Rx<ProfileModel?>(null); // Rx<ProfileModel?> to handle nullable state.

  Future<void> getApiProfile(String empCode) async {
    isLoading(true);
    final response = await http.get(
      Uri.parse('http://10.132.34.99/lmsbackend/api/employee/get?empCode=$empCode'),
    );

    // Print the response body for debugging
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      employeeData.value = ProfileModel.fromJson(jsonData);
      print(employeeData);

      // Show success dialog if data is fetched successfully
      if (employeeData.value != null) {
        Utils.showSuccessToast(message: 'Login');
      }
    } else {
      print("Error occurred: ");
      Utils.showErrorToast(message: 'An unexpected error occurred.');
      isLoading(false);
    }
    isLoading(false);
  }

}
