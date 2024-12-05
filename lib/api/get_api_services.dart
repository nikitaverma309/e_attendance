import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:online/api/api_strings.dart';
import 'package:online/models/check_status_user_register_model.dart';
import 'package:online/models/droupDown/class_model.dart';
import 'package:online/models/droupDown/designation_model.dart';
import 'dart:convert';
import 'package:online/models/profile/check_user_location_model.dart';
import 'package:online/models/profile/profile_model.dart';
import 'package:online/utils/utils.dart';
import 'package:online/widgets/common/custom_widgets.dart';

class ApiServices {
  //Profile
  static Future<ProfileModel?> profileApi(String empCode) async {
    final url = Uri.parse('${ApiStrings.userProfile}$empCode');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ProfileModel.fromJson(data);
      } else {
        CustomSnackbarError.showSnackbar(
          title: "Error",
          message: 'Employee data does not exist in the database.',
        );
        return null;
      }
    } catch (e) {
      CustomSnackbarError.showSnackbar(
        title: "Error",
        message: 'An error occurred: $e',
      );
      return null;
    }
  }
  /// API to update faceVerified to true
  static Future<bool> updateFaceVerifiedStatus(String empCode) async {
    final url = Uri.parse('${ApiStrings.userLocation}$empCode');

    try {
      final response = await http.put(url, body: {'faceVerified': 'true'});
      if (response.statusCode == 200) {
        return true;
      } else {
        Get.snackbar('Error', 'Failed to update face verification status');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      return false;
    }
  }

  /// check Location
  // static Future<List<UserLocationModel>?> getUserLocationApiServices(
  //     String empCode) async {
  //   final url = Uri.parse('${ApiStrings.userLocation}$empCode');
  //
  //   try {
  //     final response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       List<dynamic> jsonResponse = jsonDecode(response.body);
  //       return jsonResponse
  //           .map((data) => UserLocationModel.fromJson(data))
  //           .toList();
  //     } else {
  //       Get.snackbar('Error', 'Failed to load employee details');
  //       return null;
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'An error occurred: $e');
  //     return null;
  //   }
  // }
  static Future<List<UserLocationModel>?> getUserLocationApiServices(
      String empCode) async {
    final url = Uri.parse('${ApiStrings.userLocation}$empCode');

    try {
      print("Requesting API: $url");

      final response = await http.get(url);
      print("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Response Body: ${response.body}");

        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse is List) {
          return jsonResponse.map((data) => UserLocationModel.fromJson(data)).toList();
        } else if (jsonResponse is Map<String, dynamic>) {
          if (jsonResponse['msg'] == 'FACE NOT EXISTS') {
            Utils.showErrorToast(message: 'FACE NOT EXISTS');
            return null;
          } else if (jsonResponse['msg'] == 'RE-REGISTERED YOUR FACE') {
            Utils.showErrorToast(message: 'RE-REGISTERED YOUR FACE.');
            return null;
          }else if (jsonResponse['msg'] == 'FACE NOT VERIFIED') {
            Utils.showErrorToast(message: 'FACE NOT VERIFIED.');
            return null;
          }
        }

        print("Unexpected response format.");
        Get.snackbar('Error', 'Unexpected response format.');
        return null;
      } else {
        print("Error: Non-200 status code received: ${response.statusCode}");
        Get.snackbar('Error', 'Failed to load employee details. Status Code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print("Exception occurred: $e");
      Get.snackbar('Error', 'An error occurred: $e');
      return null;
    }
  }

  //check User register from Status user was true ya not
  static Future<CheckUserRegisterModel?> checkEmployeeStatus(
      String empCode, String contact) async {
    final url = '${ApiStrings.checkStatus}empCode=$empCode&contact=$contact';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["msg"] == "NOT FOUND") {
          return null; // Data not found
        }
        return CheckUserRegisterModel.fromJson(data);
      } else {
        CustomSnackbarError.showSnackbar(
          title: "Error",
          message: 'Employee data does not exist in the database.',
        );
        return null;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      return null;
    }
  }

  //  getClass
  static Future<List<ClassModel>?> fetchClass() async {
    final url = Uri.parse(ApiStrings.getClass);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<ClassModel> classList = classModelFromJson(response.body);
        return classList;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //designation api
  static Future<List<DesignationModel>?> fetchClassByDesignation(
      String classId) async {
    final url = Uri.parse('${ApiStrings.designation}/$classId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          Utils.printLog("Full Response Body: ${response.body}");
          final List<DesignationModel> fetchedData =
          designationModelFromJson(response.body);
          return fetchedData;
        } else {
          Utils.printLog("Empty response body for class ID $classId.");
          return [];
        }
      } else if (response.statusCode == 404) {
        Utils.printLog("Error: 404 - Class ID $classId not found.");
        return [];
      } else {
        Utils.printLog("Error: ${response.statusCode}, Body: ${response.body}");
        return null;
      }
    } catch (e) {
      Utils.printLog("Error fetching data for class ID $classId: $e");
      return null;
    }
  }
}