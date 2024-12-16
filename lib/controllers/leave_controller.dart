import 'package:get/get.dart';
import 'package:online/api/get_api_services.dart';
import '../models/leave_model.dart';

class LeaveController extends GetxController {
  var isLoading = false.obs;
  var appliedLeaves = <LeaveResponseModel>[].obs;
  var errorMessage = ''.obs;

  RxInt leaveStatus = 0.obs;
  Future<void> fetchAppliedLeaves() async {
    isLoading(true);
    try {
      final response = await ApiServices.fetchLeave();

      if (response != null) {
        appliedLeaves.value = response;
      }
    } catch (e) {
      errorMessage.value = 'Error fetching leaves: $e';
      appliedLeaves.clear();
    } finally {
      isLoading(false); // Stop loading
    }
  }

  String getStatusLabel(int status) {
    switch (status) {
      case 1:
        return "Pending";
      case 2:
        return "Forwarded";
      case 3:
        return "Approved";
      case 4:
        return "Rejected";
      case 5:
        return "Cancelled";
      case 6:
        return "Pending for Cancellation";
      case 7:
        return "Pending for Cancellation";
      default:
        return "Unknown Status";
    }
  }

  String getStatusColor(int status) {
    switch (status) {
      case 1:
        return "yellow";
      case 2:
        return "blue";
      case 3:
        return "green";
      case 4:
        return "red";
      case 5:
        return "grey";
      case 6:
      case 7:
        return "orange";
      default:
        return "white";
    }
  }

  void updateStatus(int status) {
    leaveStatus.value = status;
  }
}
