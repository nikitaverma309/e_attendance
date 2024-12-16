import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online/modules/auth/SharedPref.dart';

class LeaveApiService {
  static const String baseUrl =
      'http://164.100.150.78/lmsbackend/api/leave/applied_Leaves/';

  /// Fetch applied leaves for an employee
  static Future<List<dynamic>?> fetchAppliedLeaves() async {
    // Retrieve the user ID from SharedPreferences
    final userId = SharedPref.getUid();

    if (userId == null) {
      print('User ID not found in SharedPreferences.');
      return null;
    }
    print(userId);
    // Construct the API endpoint
    final url = Uri.parse('$baseUrl$userId');
    print(url);
    try {
      // Make the GET request
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final jsonData = jsonDecode(response.body);

        if (jsonData['status'] == true) {
          // Assuming the data is in the 'data' key
          return jsonData['data'];
        } else {
          print('Error in response: ${jsonData['message']}');
        }
      } else {
        print('Failed to fetch data. HTTP status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while fetching applied leaves: $e');
    }

    return null;
  }
}
