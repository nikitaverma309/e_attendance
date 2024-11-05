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
    // final url = Uri.parse("http://192.168.197.1:5000/upload/training?username=$empCode");
    final url = Uri.parse("${ApiStrings.register}$empCode");
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
    var response = await request.send();
    var responseData = await http.Response.fromStream(response);
    Utils.printLog(
        "response code was  =${response.statusCode} ${responseData.body}");
    if (response.statusCode == 201) {
      Utils.printLog('Registration was successfully!');
      Utils.showSuccessToast(message: 'Registration was successfully!');

      Get.offAll(() => MyHomePage());
    } else {
      Utils.showErrorToast(message: 'Failed to Registration was ');

      Get.offAll(() => MyHomePage());
      Utils.printLog('Failed to upload file: ${response.statusCode} $response');
    }
  }

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
  Future<bool> uploadFileLogin(BuildContext context, File file) async {
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

      // Check the status code
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(responseData.body);
        if (jsonResponse['recognized_user'] != null) {
          Utils.showSuccessToast(message: 'Face recognized successfully!');
          Utils.printLog('Face recognized successfully!');
          Get.to(() => const ProfilePage());
          return true; // Return true on success
        } else {
          Utils.showErrorToast(
              message: 'Face not recognized. Please try again.');
          return false; // Return false if face is not recognized
        }
      } else if (response.statusCode == 401) {
        Utils.showErrorToast(message: 'Unauthorized: Face not recognized.');
        return false; // Return false for unauthorized
      } else {
        Get.offAll(() => MyHomePage());
        var responseBody = responseData.body;
        Utils.showErrorToast(
            message: 'Failed to recognize face: $responseBody');
        return false; // Return false for other errors
      }
    } catch (e) {
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
      return false; // Return false in case of exception
    }
  }
}
