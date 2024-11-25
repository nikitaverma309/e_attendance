import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:online/api/api_strings.dart';
import 'package:online/models/check_emp_status_model.dart';
import 'package:online/screens/form/emp_form.dart';
import 'dart:convert';

import 'package:online/utils/utils.dart';
import 'package:online/widgets/common/custom_widgets.dart';

class CheckStatusEmployeeController extends GetxController {
  var isLoading = false.obs;
  var employeeData = {GetEmployeeCode}.obs;
  var employeeDataA = Rxn<CheckStatusModel>();

  Future<void> fetchEmployeeData(String empCode, String contact) async {
    isLoading(true);
    final url = '${ApiStrings.checkStatus}empCode=$empCode&contact=$contact';
    final response = await http.get(Uri.parse(url));
    print("API Response: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data["msg"] == "NOT FOUND") {
        isLoading(false); // Loading false करें
        CustomSnackbarError.showSnackbar(
          title: "Error",
          message: 'Employee data does not exist in the database.',
        );
        Utils.showErrorToast(
            message: "Employee data does not exist in the database.");
        return;
      }

      final checkStatusModel = CheckStatusModel.fromJson(data);

      if (checkStatusModel.msg == "FOUND") {
        employeeDataA.value = checkStatusModel;

        final sendData = checkStatusModel.getEmployeeCode;
        CustomSnackbarSuccessfully.showSnackbar(
          title: "found",
          message: 'Employee data  exist in the database.',
        );
        print("Decoded Data: $data");
        Utils.printLog(
            "Response code: ${response.statusCode} ${response.body}");
        Get.to(() => EmployeeRegistrationForm(
              employeeData: sendData,
            ));
      }
    } else {
      Utils.printLog("Response code: ${response.statusCode} ${response.body}");

      Utils.showErrorToast(
        message: 'Failed to fetch data. Status Code: ${response.statusCode}',
      );
      isLoading(false);
    }
    isLoading(false);
  }
}
