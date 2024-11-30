class ApiStrings {
  static const String baseUrl = 'http://164.100.150.78';
  static const String lms = '$baseUrl/lmsbackend/api';
  static const String register = '$baseUrl/attendance/api/upload/training?username=';
  static const String login = '$lms/recognize';
  static const String userProfile = '$lms/attendance/add?empCode=';
  static const String userLocation = '$lms/employee/get?empCode=';
  //live server
  static const String he = 'https://heonline.cg.nic.in/lmsbackend/api';
  //staging
  static const String staging = 'https://heonline.cg.nic.in/staging';
  //
  static const String checkStatus = '$lms/employee-code/check?';
  static const String empRegister = '$lms/employee/add';
  static const String formRegister = '$staging/api/employee/add';
  static const String getClass = '$staging/api/class/getAll';
  static const String designation = '$staging/api/designation-class-wise';
  static const String college = '$he/college/get-all-college';
  static const String division = '$he/division/get-all';
  static const String district = '$he/district/get-division-district';
  static const String getVidhansabha =
      '$he/district/getVidhansabha-district-wise';
}

class ApiVariables {
  static const String id = 'id';
}

class ApiMethods {
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String get = 'GET';
  static const String delete = 'DELETE';
  static const String patch = 'PATCH';
}
