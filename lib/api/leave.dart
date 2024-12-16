import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online/models/leave_model.dart';

import '../modules/auth/SharedPref.dart';
import '../utils/utils.dart';

class LeaveApiService {
  static const String baseUrl =
      'http://164.100.150.78/lmsbackend/api/leave/applied_Leaves/';
  static Future<List<LeaveResponseModel>?> fetchClass() async {
    final String? uid = SharedPref.getUid();

    if (uid == null || uid.isEmpty) {
      Utils.printLog("Error: UID is null or empty.");
      return null;
    }
    final url = Uri.parse("http://164.100.150.78/lmsbackend/api/leave/applied_Leaves/$uid");
    print(url);
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Decode the JSON response
        final List<dynamic> jsonData = jsonDecode(response.body);

        // Map the decoded JSON to a list of LeaveResponseModel
        final List<LeaveResponseModel> leaveList = jsonData
            .map((jsonItem) => LeaveResponseModel.fromJson(jsonItem))
            .toList();

        // Logging for debugging
        Utils.printLog("statusCode: ${response.statusCode}");
        Utils.printLog("body: ${response.body}");

        return leaveList;
      } else {
        Utils.printLog("Failed to fetch data. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      Utils.printLog("Error: $e");
      return null;
    }
  }
  // static Future<List<LeaveResponseModel>> fetchLeaveData() async {
  //   try {
  //     final response = await http.get(Uri.parse('$_baseUrl/leaves'));
  //
  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = json.decode(response.body);
  //       return data.map((json) => LeaveResponseModel.fromJson(json)).toList();
  //     } else {
  //       throw Exception('Failed to fetch leave data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }

}
