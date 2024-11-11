class ApiStrings {
  static const String baseUrl = 'http://10.121.71.227';
  static const String register = '$baseUrl:5000/upload/training?username=';
  static const String login = '$baseUrl:5000/api/recognize';
  static const String empRegister = 'http://heonline.cg.nic.in/lmsbackend/api/employee/add';
  static const String college = 'https://heonline.cg.nic.in/lmsbackend/api/college/get-all-college';
  static const String division = 'https://heonline.cg.nic.in/lmsbackend/api/division/get-all';
  static const String district = 'https://heonline.cg.nic.in/lmsbackend/api/district/get-division-district/';
  static const String getVidhansabha = 'https://heonline.cg.nic.in/lmsbackend/api/district/getVidhansabha-district-wise/';


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
