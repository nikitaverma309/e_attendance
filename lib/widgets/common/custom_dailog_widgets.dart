import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:online/modules/home/attendance_id_screen.dart';
import 'package:online/modules/home/registration_id_screen.dart';
import 'package:online/widgets/common/card_button.dart';

void showMessageErrorDialog(String title, String message) {
  Get.dialog(
    AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: [
        ButtonCard(
          color: Colors.red, // Optional: Customize the background color
          width: 60, // Set the width for ButtonCard
          height: 50,
          text: "Ok  ",
          onPressed: () {
            Get.off(() => const RegisterFaceAttendanceScreen());
          },
        ),
      ],
    ),
  );
}

void showErrorLoginDialog(BuildContext context, String title, String message,
    bool navigateToProfile) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
              if (navigateToProfile) {
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      );
    },
  );
}
