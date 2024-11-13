import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  Future<void> clearLoginStatus() async {

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Log out"),
      content: const Text("Are you sure you want to logout?"),
      actions: [
        TextButton(
          onPressed: () async {
            await clearLoginStatus();
           // Get.offAll(() => const UlbLoginPage());
          },
          child: const Text("Yes"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Theme.of(context).primaryColor,
          ),
          child: const Text("No"),
        ),
      ],
    );
  }
}
