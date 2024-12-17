import 'package:get/get.dart';
import 'package:online/api/get_api_services.dart';
import 'package:online/modules/auth/models/all_user_type_model.dart';
import 'package:online/utils/utils.dart';

class UserTypeController extends GetxController {
  var userTypesList = <GetAllUserType>[].obs;
  var isLoading = false.obs;
  Rx<String> selectedUserType = ''.obs;
  Rx<GetAllUserType?> get getSelectedUserType {
    return selectedUserType.value.isEmpty
        ? null.obs
        : userTypesList
            .firstWhere(
              (data) => data.userType == selectedUserType.value,
            )
            .obs;
  }

  void selectUser(String data) {
    selectedUserType.value = data;
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserTypes();
  }

  void fetchUserTypes() async {
    try {
      isLoading(true);
      final result = await ApiServices.fetchUserTypes();
      userTypesList.value = result.getAllUserType ?? [];
    } catch (e) {
      Utils.printLog("object$e");
    } finally {
      isLoading(false);
    }
  }
}
