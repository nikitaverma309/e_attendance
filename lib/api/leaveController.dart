import 'package:get/get.dart';
import 'package:online/api/leave.dart';

class LeaveController extends GetxController {
  // Observables
  var isLoading = false.obs;
  var appliedLeaves = <dynamic>[].obs; // Observable list for applied leaves
  var errorMessage = ''.obs;

  // Fetch applied leaves
  Future<void> fetchAppliedLeaves() async {
    isLoading(true); // Set loading state to true
    try {
      final leaves = await LeaveApiService.fetchAppliedLeaves();
      if (leaves != null) {
        appliedLeaves.assignAll(leaves); // Update the list with fetched leaves
      } else {
        errorMessage.value = 'No applied leaves found.';
        appliedLeaves.clear();
      }
    } catch (e) {
      errorMessage.value = 'Error fetching leaves: $e';
      appliedLeaves.clear();
    } finally {
      isLoading(false); // Set loading state to false
    }
  }
}
