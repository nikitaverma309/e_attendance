import 'package:get/get.dart';
import 'package:online/api/get_api_services.dart';
import 'package:online/models/all_user_type_model.dart';



class UserTypeController extends GetxController {
  var userTypes = <GetAllUserType>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserTypes();
  }

  void fetchUserTypes() async {
    try {
      isLoading(true);
      final result = await ApiServices.fetchUserTypes();
      userTypes.value = result.getAllUserType ?? [];
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
