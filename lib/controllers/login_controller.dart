import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:online/api/api_strings.dart';
import 'package:online/modules/home/home.dart';
import 'package:online/modules/profile/profile%20page.dart';
import 'package:online/utils/utils.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  var imageFile = Rxn<File>();
  Future<void> uploadFileSignUp(int empCode, File file) async {
    final url = Uri.parse("${ApiStrings.register}$empCode");
    print("Request URL: $url");

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };

    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['username'] = empCode.toString()
      ..files.add(
        http.MultipartFile(
          // 'image',
          'file',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

    try {
      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      print("Response Data: ${responseData.body}");
      Utils.printLog(
          "Response code: ${response.statusCode} ${responseData.body}");

      // Decode the response body
      var decodedResponse = json.decode(responseData.body);

      if (response.statusCode == 201) {
        // Handle messages from the backend
        String message =
            decodedResponse['message'] ?? 'Registration was successful!';
        handleResponse(message);
      } else {
        _showMessageErrorDialog(
          "Error",
          "Failed to process your request. Please try again later.",
        );
      }
    } catch (error) {
      _showMessageErrorDialog(
        "Error",
        "Failed to process your request. Please try again later.",
      );
      Utils.printLog('Error: $error');
    }
  }

  void handleResponse(String message) {
    if (message.contains("not exist")) {
      _showMessageErrorDialog(
        "Employee Code Not Registered. Please Contact the Administrator.",
        message,
      );
    } else if (message.contains("not verified")) {
      _showMessageErrorDialog(
        "Employee Code Not Verified. Please Contact the Administrator.",
        message,
      );
    } else {
      _showMessageErrorDialog(
        "Employee Code Not Verified. Please Contact the Administrator.",
        message,
      );
    }
  }

  void _showMessageErrorDialog(String title, String message) {
    Get.dialog(
      AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.off(() => MyHomePage()); // Navigate to home page
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // Future<void> uploadFileSignUp(int empCode, File file) async {
  //   final url = Uri.parse("${ApiStrings.register}$empCode");
  //   print("Request URL: $url");
  //
  //   Map<String, String> headers = {
  //     'Content-Type': 'multipart/form-data',
  //   };
  //
  //   var request = http.MultipartRequest('POST', url)
  //     ..headers.addAll(headers)
  //     ..fields['username'] = empCode.toString()
  //     ..files.add(
  //       http.MultipartFile(
  //         'file',
  //         file.readAsBytes().asStream(),
  //         file.lengthSync(),
  //         filename: file.path.split('/').last,
  //         contentType: MediaType('image', 'jpeg'),
  //       ),
  //     );
  //
  //   try {
  //     var response = await request.send();
  //     var responseData = await http.Response.fromStream(response);
  //
  //     print("Response Data: ${responseData.body}");
  //     Utils.printLog(
  //         "Response code: ${response.statusCode} ${responseData.body}");
  //
  //     // Decode the response body
  //     var decodedResponse = json.decode(responseData.body);
  //
  //     if (response.statusCode == 201) {
  //       // Handle messages from the backend
  //       String message =
  //           decodedResponse['message'] ?? 'Registration was successful!';
  //       _showMessageDialog(
  //           "Employee Code Not Verified. Please Contact the Administrator..",
  //           message);
  //     } else {
  //       _showMessageDialog(
  //           "Employee Code Not Registered. Please Contact the Administrator.",
  //           "The provided employee code is not found in the system. Please check and try again.");
  //     }
  //   } catch (error) {
  //     _showMessageDialog(
  //         "Employee Code Not Registered. Please Contact the Administrator.",
  //         'An error occurred: $error');
  //
  //     Utils.printLog('Error: $error');
  //   }
  // }

  /// Helper method to show a dialog box
/*
  void _showMessageDialog(String title, String message) {
    Get.dialog(
      AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.off(() => MyHomePage());
              //Get.offAll(() => MyHomePage());
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
*/

  /* Future<void> uploadFileLogin(BuildContext context, File file) async {
    final url = Uri.parse(ApiStrings.login);
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..files.add(
        http.MultipartFile(
          'file',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    try {
      var response = await request.send();
      var responseData = await http.Response.fromStream(response);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(responseData.body);
        if (jsonResponse['recognized_user'] != null) {
          Utils.printLog('Face recognized successfully!');
          Get.offAll(() => MyHomePage());
        } else {
          Utils.showErrorToast(message: 'Face not recognized. Please try again.');
        }
      } else if (response.statusCode == 401) {
        Utils.showErrorToast(message: 'Unauthorized: Face not recognized.');
      } else {
        var responseBody = responseData.body;
        Utils.showErrorToast(message: 'Failed to recognize face: $responseBody');
      }
    }
    catch (e) {
      Utils.printLog('Error occurred: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('An unexpected error occurred: $e'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }*/

  Future<void> uploadFileLogin(
    BuildContext context,
    File file,
    String empCode,
  ) async {
    print("Username: $empCode");
    print("File: ${file.path}");

    // Check if file exists
    if (!file.existsSync()) {
      Utils.showErrorToast(message: 'File does not exist.');
      return;
    }

    final url = Uri.parse('http://164.100.150.78/attendance/api/recognize');
    print("API URL: $url");

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['username'] = empCode
        ..files.add(
          http.MultipartFile(
            'image',
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: file.path.split('/').last,
            contentType: MediaType('image', 'jpeg'),
          ),
        );

      print("Sending request...");
      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${responseData.body}");

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(responseData.body);
        if (jsonResponse['recognized_user'] != null) {
          final msgCode = jsonResponse['msg_code'];
          if (msgCode == 'user_does_not_exist') {
            Utils.showErrorToast(
                message: 'User does not exist. Please try again.');
          } else if (msgCode == 'image_not_found') {
            Utils.showErrorToast(
                message: 'Image not found. Please upload a valid image.');
          } else if (msgCode == 'employee_code') {
            Utils.showErrorToast(
                message: 'Invalid employee code. Please check and try again.');
          } else {
            print("User recognized. Navigating to Profile Page...");
            Get.to(() => const ProfilePage());
          }
        } else {
          Utils.showErrorToast(
              message: 'Face not recognized. Please try again.');
        }
      } else if (response.statusCode == 401) {
        Utils.showErrorToast(message: 'Unauthorized: Face not recognized.');
      } else {
        Utils.showErrorToast(
            message: 'Failed to recognize face: ${responseData.body}');
      }
    } catch (e) {
      print("Error occurred: ${e.toString()}");
      Utils.showErrorToast(message: 'An unexpected error occurred.');
    }
  }

  Future<void> uploadFileKLogin(
    BuildContext context,
    File file,
    String empCode,
  ) async {
    print("username $empCode");
    print("FIle Image $file");
    update(); // Update UI if using GetX
    final url = Uri.parse('http://164.100.150.78/attendance/api/recognize');
    print("API URL: $url");

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['username'] = empCode // Field name must match the server
        ..files.add(
          http.MultipartFile(
            'image',
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: file.path.split('/').last,
            contentType: MediaType('image', 'jpeg'),
          ),
        );

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);
      print("username Data $empCode");
      print("FIle Image Data $file");
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${responseData.body}");

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(responseData.body);

        if (jsonResponse.containsKey('recognized_user') &&
            jsonResponse['recognized_user'] == empCode) {
          // Recognized User
          Get.to(() => const ProfilePage());
        } else if (jsonResponse.containsKey('recognized_user') &&
            jsonResponse['recognized_user'] == "no match found") {
          // No match found
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Error"),
              content: const Text("No match found. Please try again."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        } else {
          // Employee not registered
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Error"),
              content: const Text("Employee is not registered."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        }
      } else if (response.statusCode == 401) {
        Utils.showErrorToast(message: 'Unauthorized: Face not recognized.');
      } else {
        Utils.showErrorToast(
            message: 'Failed to recognize face: ${responseData.body}');
      }
    } catch (e) {
      print("Error occurred: $e");
      Utils.showErrorToast(message: 'An unexpected error occurred.');
    }
  }
}
