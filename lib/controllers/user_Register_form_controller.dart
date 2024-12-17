import 'package:get/get.dart';
import 'package:online/api/get_api_services.dart';
import 'package:online/api/post_api_services.dart';
import 'package:online/models/employee_register_model.dart';
import 'package:online/modules/restriction_dialog/restrict_user_dialog.dart';
import 'package:online/modules/screens/form/emp_form.dart';


class UserRegistrationFormController extends GetxController {
  var isLoading = false.obs;
  var employeeData = {GetEmployeeDetails}.obs;
  var employeeDataA = Rxn<CheckUserRegisterModel>();
  Future<void> getUserRegisterData(String empCode, String contact) async {
    isLoading(true);
    final checkStatusModel =
        await ApiServices.checkEmployeeStatus(empCode, contact);
    if (checkStatusModel == null) {
      isLoading(false);
      CustomSnackbarError.showSnackbar(
        title: "Error",
        message: 'Employee data does not exist in the database.',
      );

      return;
    }
    if (checkStatusModel.msg == "FOUND BUT USED") {
      employeeDataA.value = checkStatusModel;

      CustomSnackbarSuccessfully.showSnackbar(
        title: "Found",
        message: 'Employee data exists in the database.',
      );

      Get.to(() => EmployeeRegistrationForm(
            employeeData: checkStatusModel.getEmployeeDetails,
          ));
    }
    isLoading(false);
  }

// from data post
  Future<void> addFormData({
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
    isLoading.value = true;

    final response = await PostApiServices.registrationFormApi(
      name: name,
      empCode: empCode,
      email: email,
      contact: contact,
      division: division,
      district: district,
      vidhanSabha: vidhanSabha,
      college: college,
      designation: designation,
      classData: classData,
      address: address,
      workType: workType,
    );

    isLoading.value = false;

    if (response['success']) {
    } else {
      String errorMessage =
          response['data']['msg'] ?? 'An unexpected error occurred';
      CustomSnackbarError.showSnackbar(
        title: 'Error',
        message: errorMessage,
      );
    }
  }
}
