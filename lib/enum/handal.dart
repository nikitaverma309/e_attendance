import 'package:online/enum/location_status.dart';
import 'package:online/models/profile/check_user_location_model.dart';

class UserResponseModel {
  UserLocationModel? userData;
  LoginStatus? errorType;

  UserResponseModel({
    this.userData,
    this.errorType,
  });
}
