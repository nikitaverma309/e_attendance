import 'package:get/get.dart';
import 'package:online/api/get_api_services.dart';
import 'package:online/models/profile/profile_model.dart';
import 'package:online/modules/profile/profile_screen.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var employeeDataA = Rxn<ProfileModel>();

  Future<void> getProfile(String empCode) async {
    isLoading(true);
    final profileData = await ApiServices.profileApi(empCode);
    if (profileData != null) {
      employeeDataA.value = profileData;
      Get.to(() => ProfileScreen(
        data: employeeDataA.value,
      ));
    } else {

    }
    isLoading(false);
  }
}
