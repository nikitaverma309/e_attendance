import 'package:get/get.dart';
import 'package:online/api/get_api_services.dart';
import 'package:online/modules/auth/models/all_user_type_model.dart';



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
      print("object$e");
    } finally {
      isLoading(false);
    }
  }
}
