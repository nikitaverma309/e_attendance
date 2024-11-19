import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio_lib;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:online/api/api_strings.dart';
import 'package:online/modules/home/home.dart';
import 'package:online/modules/profile/profile%20page.dart';
import 'package:online/utils/utils.dart';

class LoginController extends GetxController {
  final dio_lib.Dio _dio = dio_lib.Dio();
  var isLoading = false.obs;
  var imageFile = Rxn<File>(); // Use Rxn for nullable File

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
        _showMessageDialog(message);
        // Get.offAll(() => MyHomePage());
      } else {
        _showMessageErrorDialog('Failed to register. Try again later.');
        // Get.offAll(() => MyHomePage());
      }
    } catch (error) {
      _showMessageDialog('An error occurred: $error');
      Utils.printLog('Error: $error');
    }
  }

  /// Helper method to show a dialog box
  void _showMessageDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: Text(
          "Employee Code Not Verifaid. Please Contact the Administrator.",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.offAll(() => MyHomePage());
              //  Get.back(); // Close the dialog
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  /// Helper method to show a dialog box
  void _showMessageErrorDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: Text(
          "Employee Code Not Registered. Please Contact the Administrator.",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.offAll(() => MyHomePage());
              //  Get.back(); // Close the dialog
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  // Future<void> uploadFileSignUp(int empCode, File file) async {
  //   // final url = Uri.parse("http://192.168.197.1:5000/upload/training?username=$empCode");
  //   final url = Uri.parse("${ApiStrings.register}$empCode");
  //   print(url);
  //
  //   Map<String, String> headers = {
  //     'Content-Type': 'multipart/form-data',
  //   };
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
  //   var response = await request.send();
  //   var responseData = await http.Response.fromStream(response);
  //   print("responseData was $responseData");
  //   Utils.printLog(
  //       "response code was  =${response.statusCode} ${responseData.body}");
  //   print("responseData was ${responseData.body}");
  //   if (response.statusCode == 201) {
  //     print("object");
  //     Utils.printLog('Registration was successfully!');
  //     Utils.showSuccessToast(message: 'Registration was successfully!');
  //
  //     Get.offAll(() => MyHomePage());
  //   } else {
  //     Utils.showErrorToast(message: 'Failed to Registration was ');
  //
  //     Get.offAll(() => MyHomePage());
  //     Utils.printLog('Failed to upload file: ${response.statusCode} $response');
  //   }
  // }

//kam ka code
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
    var isLoading = true;
    update(); // Update UI if you're using GetX
    final url = Uri.parse(ApiStrings.login);
    print("API URL: $url");

    var request = http.MultipartRequest('POST', url)
      ..fields['username'] = empCode // Field name must match the server
      ..files.add(
        http.MultipartFile(
          'file',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

    var response = await request.send();
    var responseData = await http.Response.fromStream(response);
    print("Response Status: ${response.statusCode}");
    print("Response Body: ${responseData.body}");

    print("Response Status: ${response.statusCode}");
    print("Response Body: ${responseData.body}");

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(responseData.body);
      if (jsonResponse['recognized_user'] != null) {
        print("Login Successful");
        Get.to(() => const ProfilePage());
      } else {
        Utils.showErrorToast(message: 'Face not recognized. Please try again.');
      }
    } else if (response.statusCode == 401) {
      Utils.showErrorToast(message: 'Unauthorized: Face not recognized.');
    } else {
      Utils.showErrorToast(
          message: 'Failed to recognize face: ${responseData.body}');
    }
  }


}
