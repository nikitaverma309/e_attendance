import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/controllers/leave_controller.dart';
import 'package:online/widgets/common/app_bar_widgets.dart';


class LeaveListScreen extends StatelessWidget {
  final LeaveController leaveController = Get.put(LeaveController());

  LeaveListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    leaveController.fetchAppliedLeaves();

    return Scaffold(
      backgroundColor: const Color(0xF5ECF4F5),
      appBar: const CustomAppBar(
        title: "Leave Management Screen",
      ),
      body: Obx(() {
        if (leaveController.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator());
        }

        if (leaveController.errorMessage.isNotEmpty) {
          return Center(
              child: Text(
                  leaveController.errorMessage.value));
        }

        return Column(
          children: [
            _buildStatusButtons(context),
            Expanded(
              child: _buildLeaveList(
                leaveController,
                leaveController.leaveStatus
                    .value,
              ),
            ),
          ],
        );
      }),
    );
  }

  // Widget for status buttons
  Widget _buildStatusButtons(BuildContext context) {
    final statuses = {
      1: "Pending",
      2: "Forwarded",
      3: "Approved",
      4: "Rejected",
      5: "Cancelled"
    };

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: statuses.entries.map((entry) {
          final status = entry.key;
          final label = entry.value;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                leaveController.updateStatus(status); // Update the status
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: leaveController.leaveStatus.value == status
                    ? Colors.blue // Highlight the selected button
                    : Colors.grey,
              ),
              child: Text(label),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLeaveList(LeaveController controller, int status) {
    final filteredLeaves = controller.appliedLeaves
        .where((leave) => leave.leaveStatus == status)
        .toList();

    if (filteredLeaves.isEmpty) {
      return
        const Center(child: Text('No leaves found for this status.',style: kTextBlueColorStyle,));
    }

    return ListView.builder(
      itemCount: filteredLeaves.length,
      itemBuilder: (context, index) {
        final leave = filteredLeaves[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Leading Icon
                const CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.calendar_today, color: Colors.white),
                ),
                const SizedBox(width: 12),
                // Main content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        '${leave.applicantName}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Subtitle
                      Text(
                        'Date: ${leave.appliedDate ?? "N/A"}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${leave.reason}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${leave.leaveType}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Trailing button
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.grey[600]),
                  onPressed: () {
                    // Add your navigation logic here
                    print("Leave tapped: ${leave.id}");
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
