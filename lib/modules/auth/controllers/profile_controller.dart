import 'package:get/get.dart';
import 'package:online/api/get_api_services.dart';
import 'package:online/modules/auth/models/user_model.dart';
import 'package:online/modules/auth/views/profile_screen.dart';
import 'package:online/utils/utils.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var employeeDataA = Rxn<ProfileModel>();

  Future<void> getProfile(String empCode) async {
    isLoading(true);
    try {
      final profileData = await ApiServices.profileApi(empCode);
      if (profileData != null) {
        employeeDataA.value = profileData;
        Get.to(() => ProfileScreen(
          data: employeeDataA.value,
        ));
      } else {
        Utils.showErrorToast(message: "Invalid employee code. Please try again.");
      }
    } catch (e) {
      Utils.showErrorToast(message: "An error occurred: $e");
      print("An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }

}
