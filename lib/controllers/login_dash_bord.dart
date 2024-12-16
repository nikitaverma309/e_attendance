import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:online/models/login_model.dart';
import 'package:online/modules/auth/SharedPref.dart';
import 'package:online/screens/emp_dash_bord/cmo_dash_bord.dart';

class LoginDashBordController extends GetxController {
  var isLoading = false.obs;
  var loginResponse = Rxn<LoginResponseModel>();
  var errorMessage = ''.obs; // Observable for error messages

  // Method to handle login
  Future<void> login(
    String userType,
    String username,
    String password,
  ) async {
    isLoading(true);
    try {
      var url = Uri.parse('http://164.100.150.78/lmsbackend/api/login');
      var headers = {'Content-Type': 'application/json'};
      print(url);
      print("userType = $userType");
      print("user name was = $username");
      print("password was = $password");
      // Prepare the body
      var body = json.encode({
        "userType": userType,
        "username": username,
        "password": password,
      });

      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        var data = json.decode(response.body); // Decode the JSON response
        print(response.statusCode);
        print(response.body);
        if (data['status'] == true) {
          SharedPref.setUid(data['id']);
          SharedPref.setUsername(data['username']);
          SharedPref.setUserType(data['userType']);
          SharedPref.setEmpCode(data['empCode']);
          SharedPref.setType(data['type']);
          SharedPref.setToken(data['token']);
          loginResponse.value = LoginResponseModel.fromJson(data);

          Get.to(() => const UserDashBord());
        } else {
          errorMessage.value = "Login Failed. Please check your credentials.";
        }
      } else {
        errorMessage.value = "Error: ${response.statusCode}";
        print("ud ${response.statusCode}");
      }
    } catch (e) {
      errorMessage.value = "Failed to connect to server: $e";
      print("ud $e");
    } finally {
      isLoading(false); // Set loading state to false
    }
  }
}
