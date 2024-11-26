import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:online/api/api_strings.dart';
import 'package:online/models/profile/profile_model.dart';
import 'package:online/modules/profile/profile_screen.dart';
import 'package:online/utils/utils.dart';
import 'package:online/widgets/common/custom_dailog_widgets.dart';

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

      var decodedResponse = json.decode(responseData.body);
      String message = decodedResponse['message'] ?? '';

      if (response.statusCode == 201) {
        handleResponseRegister(message);
      } else {
        showMessageErrorDialog(
          "Error",
          "Failed to process your request. Please try again later.",
        );
      }
    } catch (error) {
      showMessageErrorDialog(
        "Error",
        "Failed to process your request. Please try again later.",
      );
      Utils.printLog('Error: $error');
    }
  }

  void handleResponseRegister(String message) {
    if (message.contains("User ID does not exist.")) {
      showMessageErrorDialog(
        "Employee Code Not Registered. Please Contact the Administrator.",
        message,
      );
    } else if (message.contains("Employee Not Verified")) {
      showMessageErrorDialog(
        "Employee Not Verified. Please Contact the Administrator.",
        message,
      );
    } else if (message.contains(RegExp(r'^\d{11}$'))) {
      showMessageErrorDialog(
        "Employee Code Verified and Please wait, the face verification is being processed.",
        "Employee Code: $message",
      );
    } else {
      showMessageErrorDialog(
        "Unexpected Response. Please Contact the Administrator.",
        message,
      );
    }
  }

  Future<void> uploadFileLogin(
    BuildContext context,
    File file,
    String empCode,
  ) async {
    if (!file.existsSync()) {
      Utils.showErrorToast(message: 'File does not exist.');
      return;
    }

    final url = Uri.parse(ApiStrings.login);

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

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(responseData.body);
        if (jsonResponse['recognized_user'] != null) {
          final recognizedUser = jsonResponse['recognized_user'];

          if (recognizedUser == empCode) {
            await getAttendanceProfileData(context, recognizedUser);
            Utils.showSuccessToast(
                message: 'User Attendance Was Successfully Registered');
          } else if (recognizedUser ==
              "User with the given EmployeeCode does not exist.") {
            showPDialog(context, "Error",
                "User with the given EmployeeCode does not exist.", false);
          } else if (recognizedUser == "Face Not Verified") {
            showPDialog(context, "Face Verification Pending",
                "Face not verified. Please wait for verification.", false);
          } else if (recognizedUser == "No match found.") {
            showPDialog(context, "Face Not Matched",
                "Face not matched. Please try again.", false);
          } else {
            showPDialog(context, "Error",
                "Face not recognized. Please try again.", false);
          }
        } else {
          showPDialog(
              context, "Recognition Failed", "Face not recognized.", false);
        }
      } else if (response.statusCode == 401) {
        showPDialog(context, "Unauthorized",
            "Face not recognized and No match found.", false);
      } else {
        showPDialog(context, "Error",
            "Failed to recognize face: ${responseData.body}", false);
      }
    } catch (e) {
      print("Error occurred: ${e.toString()}");
      showPDialog(
          context, "Unexpected Error", "An unexpected error occurred.", false);
    }
  }

  Future<void> getAttendanceProfileData(BuildContext context, String empCode) async {
    final url = Uri.parse(
        '${ApiStrings.profile}$empCode');
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse['attendance'] != null) {
          showPDialog(context, "सफलता", "उपस्थिति सफलतापूर्वक दर्ज।", true);
          final resData = ProfileModel.fromJson(jsonResponse);
          Get.to(() => ProfileScreen(data: resData));
        } else {
          showPDialog(context, "त्रुटि", "अमान्य उपस्थिति डेटा।", false);
        }
      } else {
        showPDialog(context, "त्रुटि",
            "उपस्थिति प्राप्त करने में विफल: ${response.body}", false);
      }
    } catch (e) {
      print("त्रुटि: $e");
      showPDialog(context, "त्रुटि", "अप्रत्याशित त्रुटि।", false);
    }
  }
}

//dialog box
