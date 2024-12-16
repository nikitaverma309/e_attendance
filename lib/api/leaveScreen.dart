import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Add intl for date formatting.
import 'package:online/api/leaveController.dart';

class AppliedLeaveListScreen extends StatelessWidget {
  final LeaveController leaveController = Get.put(LeaveController());

  String formatDate(String? isoDate) {
    if (isoDate == null) return 'N/A';
    try {
      final date = DateTime.parse(isoDate);
      return DateFormat('dd-MM-yyyy').format(date);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  String getStatusText(int? status) {
    // Define leave statuses based on your application's logic.
    switch (status) {
      case 5:
        return 'Approved';
      case 6:
        return 'Pending';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Applied Leave List')),
      body: Obx(() {
        if (leaveController.isLoading.value) {
          // Show a loading indicator while data is being fetched.
          return Center(child: CircularProgressIndicator());
        }

        if (leaveController.appliedLeaves.isEmpty) {
          return Center(
            child: Text(leaveController.errorMessage.value.isEmpty
                ? 'No applied leaves found.'
                : leaveController.errorMessage.value),
          );
        }

        // Display the list of applied leaves.
        return ListView.builder(
          itemCount: leaveController.appliedLeaves.length,
          itemBuilder: (context, index) {
            final leave = leaveController.appliedLeaves[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(leave['leaveType'] ?? 'Unknown Leave Type'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status: ${getStatusText(leave['leaveStatus'])}'),
                    Text('From: ${formatDate(leave['fromDate'])}'),
                    Text('To: ${formatDate(leave['tillDate'])}'),
                    Text('Reason: ${leave['reason'] ?? 'N/A'}'),
                  ],
                ),
                trailing: Text('Days: ${leave['dayCount'] ?? 'N/A'}'),
              ),
            );
          },
        );
      }),
    );
  }
}
