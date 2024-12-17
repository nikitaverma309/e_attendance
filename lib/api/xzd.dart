class ApiStrings {
  // static const String baseUrl = 'http://10.121.71.227';
  static const String baseUrl = 'http://164.100.150.78/attendance/api';
  static const String register = '$baseUrl/upload/training?username=';
  // static const String login = '$baseUrl:5000/api/recognize';
  static const String login = '$baseUrl/recognize';
  static const String profile =
      'http://164.100.150.78/lmsbackend/api/attendance/add?empCode=';

  //live server
  static const String lBaseUrl = 'https://heonline.cg.nic.in/lmsbackend/api';
  //staging
  static const String sBaseUrl = 'http://164.100.150.78/lmsbackend/api';
  static const String staging = 'https://heonline.cg.nic.in/staging';
  //
  static const String checkStatus = '$sBaseUrl/employee-code/check?';
  static const String empRegister = '$sBaseUrl/employee/add';
  static const String college = '$sBaseUrl/college/get-all-college';
  static const String division = '$sBaseUrl/division/get-all';
  static const String district = '$sBaseUrl/district/get-division-district/';
  static const String getVidhansabha =
      '$sBaseUrl/district/getVidhansabha-district-wise/';
}
