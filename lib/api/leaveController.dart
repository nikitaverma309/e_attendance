// import 'package:get/get.dart';
// import 'package:online/api/leave.dart';
// import 'package:online/models/leave_model.dart';
//
// import '../models/leave_model.dart';
//
// class LeaveController extends GetxController {
//   // Observables
//   var isLoading = false.obs;
//   var appliedLeaves = <LeaveResponseModel>[].obs; // Observable list for applied leaves
//   var errorMessage = ''.obs;
//   String getStatusDescription() {
//     switch (appliedLeaves.first.leaveStatus) {
//       case 1:
//         return "Pending";
//       case 2:
//         return "Forwarded";
//       case 3:
//         return "Approved";
//       case 4:
//         return "Rejected";
//       case 5:
//         return "Cancelled";
//       case 6:
//       case 7:
//         return "Pending for Cancellation";
//       default:
//         return "Unknown";
//     }
//   }
//   // Fetch applied leaves
//   Future<void> fetchAppliedLeaves() async {
//     isLoading(true); // Set loading state to true
//     try {
//       final leaves = await LeaveApiService.fetchClass();
//       if (leaves != null) {
//         appliedLeaves.value=leaves.LeaveResponseModel ?? []; // Update the list with fetched leaves
//       } else {
//         errorMessage.value = 'No applied leaves found.';
//         appliedLeaves.clear();
//       }
//     } catch (e) {
//       errorMessage.value = 'Error fetching leaves: $e';
//       appliedLeaves.clear();
//     } finally {
//       isLoading(false); // Set loading state to false
//     }
//   }
// }
import 'package:get/get.dart';
import '../api/leave.dart'; // Adjust the path for LeaveApiService
import '../models/leave_model.dart'; // Adjust the path for LeaveResponseModel

class LeaveController extends GetxController {
  // Observables
  var isLoading = false.obs; // Observable for loading state
  var appliedLeaves = <LeaveResponseModel>[].obs; // Observable list of leaves
  var errorMessage = ''.obs; // Observable for error messages

  RxInt leaveStatus = 0.obs;
  // Fetch applied leaves
  Future<void> fetchAppliedLeaves() async {
    isLoading(true); // Start loading
    try {
      final response = await LeaveApiService.fetchClass();

      if (response != null ) {
        appliedLeaves.value = response; // Update leaves
      }
    } catch (e) {
      // Handle errors
      errorMessage.value = 'Error fetching leaves: $e';
      appliedLeaves.clear();
    } finally {
      isLoading(false); // Stop loading
    }
  }


  // Method to get button label based on leaveStatus
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

  // Method to get button color based on leaveStatus
  String getStatusColor(int status) {
    switch (status) {
      case 1:
        return "yellow"; // Pending - Yellow
      case 2:
        return "blue"; // Forwarded - Blue
      case 3:
        return "green"; // Approved - Green
      case 4:
        return "red"; // Rejected - Red
      case 5:
        return "grey"; // Cancelled - Grey
      case 6:
      case 7:
        return "orange"; // Pending for Cancellation - Orange
      default:
        return "white"; // Default - White
    }
  }

  // Example: Update leaveStatus dynamically
  void updateStatus(int status) {
    leaveStatus.value = status;
  }
}
