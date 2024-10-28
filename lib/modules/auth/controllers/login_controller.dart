import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final employeeCodeController = TextEditingController();
  var isLoading = false.obs;

  @override
  void onClose() {
    employeeCodeController.dispose();
    super.onClose();
  }

  // Method to handle login logic
  Future<void> login() async {
    if (employeeCodeController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your Employee Code');
      return;
    }

    isLoading.value = true;

    try {
      // Your authentication logic here (e.g., API call to validate the user)
      await Future.delayed(Duration(seconds: 2)); // Mocking a delay
      // Assume success for now
      isLoading.value = false;
      Get.snackbar('Login Successful', 'Welcome!');
      // Navigate to the next page if needed, e.g., Get.to(() => HomePage());
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Login Failed', 'Something went wrong');
    }
  }
}
