import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SignupController extends GetxController {
  final employeeCodeController = TextEditingController();
  final dateController = TextEditingController();
  final locationController = TextEditingController();

  var isLoading = false.obs;

  // Variable to hold the selected image
  File? selectedImage;

  @override
  void onClose() {
    employeeCodeController.dispose();
    dateController.dispose();
    locationController.dispose();
    super.onClose();
  }

  // Method to pick an image
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
    }
  }

  // Method to send data to the API
  Future<void> signup() async {
    if (employeeCodeController.text.isEmpty ||
        dateController.text.isEmpty ||
        locationController.text.isEmpty ||
        selectedImage == null) {
      Get.snackbar('Error', 'Please fill all fields and select an image');
      return;
    }

    isLoading.value = true;

    // Create a multipart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('YOUR_API_ENDPOINT_HERE'), // Replace with your API endpoint
    );

    // Add text fields
    request.fields['employee_code'] = employeeCodeController.text;
    request.fields['date'] = dateController.text;
    request.fields['location'] = locationController.text;

    // Add image file
    request.files.add(await http.MultipartFile.fromPath(
      'image', // This should match the field name expected by your backend
      selectedImage!.path,
    ));

    try {
      // Send the request
      var response = await request.send();

      // Check the response
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Signup successful!');
      } else {
        Get.snackbar('Error', 'Signup failed. Please try again.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
