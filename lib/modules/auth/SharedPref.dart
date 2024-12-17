import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:online/splash/feature_showcase_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _uidKey = 'id';
const String _uNameKey = 'username';
const String _uStatusKey = 'status';
const String _uUserTypeKey = 'userType';
const String _uEmpCodeKey = 'empCode';
const String _uTypeKey = 'type';
const String _tokenKey = 'token';

class ApiVariables {
  static String? uid;
  static bool loggedInUser = false;
  static String? username;
  static String? status;
  static String? userType;
  static String? empCode;
  static String? type;
  static String? token;
}

class SharedPref {
  static SharedPreferences? _prefs;

  SharedPref() {
    init();
  }

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save UID
  static void setUid(String uid) {
    ApiVariables.uid = uid;
    _prefs?.setString(_uidKey, uid);
  }

  // Retrieve UID
  static String? getUid() {
    return _prefs?.getString(_uidKey);
  }

  // Save Username
  static void setUsername(String username) {
    ApiVariables.username = username;
    _prefs?.setString(_uNameKey, username);
  }

  // Retrieve Username
  static String? getUsername() {
    return _prefs?.getString(_uNameKey);
  }

  // Save Status
  static void setStatus(String status) {
    ApiVariables.status = status;
    _prefs?.setString(_uStatusKey, status);
  }

  // Retrieve Status
  static String? getStatus() {
    return _prefs?.getString(_uStatusKey);
  }

  // Save UserType
  static void setUserType(String userType) {
    ApiVariables.userType = userType;
    _prefs?.setString(_uUserTypeKey, userType);
  }

  // Retrieve UserType
  static String? getUserType() {
    return _prefs?.getString(_uUserTypeKey);
  }

  // Save Employee Code
  static void setEmpCode(String empCode) {
    ApiVariables.empCode = empCode;
    _prefs?.setString(_uEmpCodeKey, empCode);
  }

  // Retrieve Employee Code
  static String? getEmpCode() {
    return _prefs?.getString(_uEmpCodeKey);
  }

  // Save Type as int
  static void setType(int type) {
    ApiVariables.type =
        type.toString(); // Optional: Keep as String if needed elsewhere
    _prefs?.setInt(_uTypeKey, type);
  }

  // Retrieve Type as int
  static int? getType() {
    return _prefs?.getInt(_uTypeKey);
  }

  // Save Token
  static void setToken(String token) {
    ApiVariables.token = token;
    _prefs?.setString(_tokenKey, token);
  }

  // Retrieve Token
  static String? getToken() {
    return _prefs?.getString(_tokenKey);
  }

  // Clear all stored data
  static void logout() {
    _prefs?.clear();
    ApiVariables.uid = null;
    ApiVariables.username = null;
    ApiVariables.status = null;
    ApiVariables.userType = null;
    ApiVariables.empCode = null;
    ApiVariables.type = null;
    ApiVariables.token = null;
  }

  static void logoutUser() {
    logout();

    Get.offAll(() => const FeatureShowCasePage());
  }

  // Retrieve all data as a Map (optional utility)
  static Map<String, dynamic> getAllData() {
    return {
      'id': getUid(),
      'username': getUsername(),
      'status': getStatus(),
      'userType': getUserType(),
      'empCode': getEmpCode(),
      'type': getType(),
      'token': getToken(),
    };
  }
}
