import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:online/api/api_strings.dart';
import 'package:online/models/profile/profile_model.dart';
import 'package:online/modules/home/home.dart';
import 'package:online/modules/profile/profile_screen.dart';
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
              Get.off(() => const MyHomePage()); // Navigate to home page
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
    // Check if file exists
    if (!file.existsSync()) {
      Utils.showErrorToast(message: 'File does not exist.');
      return;
    }

    final url = Uri.parse('http://164.100.150.78/attendance/api/recognize');

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

          // Handle specific conditions
          if (recognizedUser == empCode) {
            await fetchAttendance(context, recognizedUser);
            Utils.showErrorToast(
                message: 'User Attendance Was Successfully Registered');
          } else if (recognizedUser ==
              "User with the given empCode does not exist.") {
            _showPDialog(context, "Error",
                "User with the given empCode does not exist.", false);
          } else {
            _showPDialog(context, "Error",
                "Face not recognized. Please try again.", false);
          }
        } else {
          _showPDialog(
              context, "Recognition Failed", "Face not recognized.", false);
        }
      } else if (response.statusCode == 401) {
        _showPDialog(context, "Unauthorized",
            "Face not recognized and No match found.", false);
      } else {
        _showPDialog(context, "Error",
            "Failed to recognize face: ${responseData.body}", false);
      }
    } catch (e) {
      print("Error occurred: ${e.toString()}");
      _showPDialog(
          context, "Unexpected Error", "An unexpected error occurred.", false);
    }
  }

  Future<void> fetchAttendance(BuildContext context, String empCode) async {
    final url = Uri.parse(
        'http://164.100.150.78/lmsbackend/api/attendance/add?empCode=$empCode');
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse['attendance'] != null) {
          _showPDialog(context, "सफलता", "उपस्थिति सफलतापूर्वक दर्ज।", true);
          final resData = ProfileModel.fromJson(jsonResponse);
          Get.to(() => ProfileScreen(data: resData));
        } else {
          _showPDialog(context, "त्रुटि", "अमान्य उपस्थिति डेटा।", false);
        }
      } else {
        _showPDialog(context, "त्रुटि",
            "उपस्थिति प्राप्त करने में विफल: ${response.body}", false);
      }
    } catch (e) {
      print("त्रुटि: $e");
      _showPDialog(context, "त्रुटि", "अप्रत्याशित त्रुटि।", false);
    }
  }
}

//dialog box
void _showPDialog(BuildContext context, String title, String message,
    bool navigateToProfile) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
              if (navigateToProfile) {
                Get.to(() => MyHomePage());
              } else {
                Get.offAll(() => MyHomePage());
              }
            },
          ),
        ],
      );
    },
  );
}

void _showDicxalog(BuildContext context, String title, String message,
    bool navigateToProfile) {
  String currentDateTime =
      DateFormat('yyyy-MM-dd    HH:mm:ss').format(DateTime.now());

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text('$message\n\n Login Time: $currentDateTime'),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
              if (navigateToProfile) {
                //  Get.to(() => ProfileScreen(data: profileData));
              } else {}
            },
          ),
        ],
      );
    },
  );
}
