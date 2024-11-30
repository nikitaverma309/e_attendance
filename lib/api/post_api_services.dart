import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online/api/api_strings.dart';

class PostApiServices {
  static Future<Map<String, dynamic>> registrationFormApi({
    required String name,
    required String empCode,
    required String email,
    required String contact,
    required String division,
    required String district,
    required String vidhanSabha,
    required String college,
    required String designation,
    required String classData,
    required String address,
    required String workType,
  }) async {
    final url = Uri.parse(ApiStrings.formRegister);

    final body = jsonEncode({
      "name": name,
      "empCode": empCode,
      "email": email,
      "contact": contact,
      "divison": division,
      "district": district,
      "vidhansabha": vidhanSabha,
      "college": college,
      "designation": designation,
      "classData": classData,
      "address": address,
      "workType": workType,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 201) {
        return {
          'success': true,
          'data': json.decode(response.body),
        };
      } else {
        return {
          'success': false,
          'data': json.decode(response.body),
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }
}
