import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:online/api/api_strings.dart';
import 'package:online/constants/string_res.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/modules/auth/models/profile_model.dart';
import 'package:online/modules/auth/views/home/main_page.dart';
import 'package:online/modules/restriction_dialog/restrict_user_dialog.dart';
import 'package:online/utils/utils.dart';
import 'package:online/widgets/common/card_button.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  var imageFile = Rxn<File>();

  Future<void> signUp(int empCode, File file) async {
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

      Utils.printLog(
          "Response code: ${response.statusCode} ${responseData.body}");

      var decodedResponse = json.decode(responseData.body);
      String message = decodedResponse['message'] ?? '';

      if (response.statusCode == 201) {
        handleResponseRegister(message);
      }
    } catch (error) {
      showMessageErrorDialog(
        "Error",
        "Failed to process your request. Please try again later.",
      );
      Utils.printLog('Error: $error');
    }
  }

  Future<void> uploadLogin(
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
            await getProfileData(context, recognizedUser);
            Utils.showSuccessToast(
                message: 'User Attendance Was Successfully Registered');
          } else if (recognizedUser ==
              "User with the given EmployeeCode does not exist.") {
            showErrorLoginDialog(context, "Error",
                "User with the given EmployeeCode does not exist.", false);
          } else if (recognizedUser == "Face Not Verified") {
            showErrorLoginDialog(context, "Face Verification Pending",
                "Face not verified. Please wait for verification.", false);
          } else if (recognizedUser == "No match found.") {
            showErrorLoginDialog(context, "Face Not Matched",
                "Face not matched. Please try again.", false);
          } else {
            showErrorLoginDialog(context, "Error",
                "Face not recognized. Please try again.", false);
          }
        } else {
          showErrorLoginDialog(
              context, "Recognition Failed", "Face not recognized.", false);
        }
      }
    } catch (e) {
      Utils.printLog("Error occurred: ${e.toString()}");
    }
  }

  Future<void> getProfileData(BuildContext context, String empCode) async {
    final url = Uri.parse('${ApiStrings.userProfile}$empCode');
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse['attendance'] != null) {
          showErrorLoginDialog(
              context, "सफलता", "उपस्थिति सफलतापूर्वक दर्ज।", true);
          final resData = AttendanceProfileModel.fromJson(jsonResponse);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              String logoutTimeText = resData!.attendance!.logoutTime != null
                  ? Utils.formatTime(resData!.attendance!.logoutTime)
                  : "...";
              String responseTimeText = resData!.attendance!.logoutTime != null
                  ? "Closing Time Response"
                  : "Login Response";
              Future.delayed(const Duration(seconds: 10), () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPage(),
                  ),
                  (Route<dynamic> route) => false, // Remove all previous routes
                );
              });

              return AlertDialog(
                title: Column(
                  children: [
                    const Text(
                      "Attendance Type ",
                      style: kText15BaNaBoldBlackColorStyle,
                    ),
                    Text(
                      "$responseTimeText ",
                      style: kText15BaNaBoldBlackColorStyle,
                    ),
                  ],
                ),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xffe4eaef),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        child: Card(
                          elevation: 35,
                          child: Image.memory(
                            // height: 90,
                            // width: 90,
                            base64Decode(resData!.employeeData!.encodedImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      10.height,
                      const Text(
                        "${Strings.inTime}:/  Login Time ",
                        style: kText15BaNaBoldBlackColorStyle,
                      ),
                      Text(
                        Utils.formatTime(resData!.attendance!.loginTime),
                        style: kTextBlueColorStyle,
                      ),
                      const Text(
                        "${Strings.outTime}:/   Logout Time",
                        style: kText15BaNaBoldBlackColorStyle,
                      ),
                      Text(
                        logoutTimeText,
                        style: kTextBlueColorStyle,
                      ),
                    ],
                  ),
                ),
                actions: [
                  ButtonCard(
                    color: Colors.green,
                    width: 60,
                    height: 40,
                    text: "Ok",
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ),
                        (Route<dynamic> route) =>
                            false, // Remove all previous routes
                      );
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      print("त्रुटि: $e");
      showErrorLoginDialog(context, "त्रुटि", "अप्रत्याशित त्रुटि।", false);
    }
  }
}