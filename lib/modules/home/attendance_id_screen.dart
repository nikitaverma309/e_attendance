import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/constants/string_res.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/controllers/profile_ctr/profile_controller.dart';
import 'package:online/generated/assets.dart';
import 'package:online/modules/profile/prosc.dart';
import 'package:online/utils/shap/shape_design.dart';
import 'package:online/widgets/common/app_bar_widgets.dart';
import 'package:online/widgets/footer_widget.dart';
import 'package:text_scroll/text_scroll.dart';

import '../auth/login/login_camera.dart';

class FaceAttendanceScreen extends StatefulWidget {
  const FaceAttendanceScreen({super.key});

  @override
  State<FaceAttendanceScreen> createState() => _FaceAttendanceScreenState();
}

class _FaceAttendanceScreenState extends State<FaceAttendanceScreen> {
  bool isChecked = false;
  final ProfileController profileController = Get.put(ProfileController());
  // Dummy Attendance IDs
  List<String> attendanceIds = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "Reset",
    "0",
    "Back"
  ];
  TextEditingController emailCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xF5ECF4F5),
      appBar: const CustomAppBar(
        title: Strings.attendance,
        showBackButton: true,
        actionWidget: Icon(
          Icons.more_vert,
          color: Color(0xff176daa),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            10.height,
            Container(
              color: Colors.cyan.shade50,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: TextScroll(
                        'App Version: Ap@36451 Organization: National Information Center (NIC) Chhattisgarh, Blinding: Mantralaya Naya Raipur ',
                        style: kText15BaNaBoldBlackColorStyle,
                        intervalSpaces: 10,
                        velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            10.height,
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        50), // Use a high value for circular shape
                  ),
                  color: const Color(0xffb8cbd8),
                  elevation: 6,
                  child: const Image(
                    image: AssetImage(Assets.imagesCglogo),
                    height: 88,
                    width: 88,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            10.height,
            const Text("Higher Education Department's",
                style: kText15BaNaBoldBlackColorStyle),
            10.height,
            Container(
              color: const Color(0xFFE3C998),
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "उपस्थिति आईडी           \nAttendance ID         ",
                        style: k13BoldBlackColorStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: Shape.submitContainerRed(context),
                      child: TextField(
                        controller: emailCtr,
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .digitsOnly, // Allows only digits
                          LengthLimitingTextInputFormatter(
                              11), // Limits input to 10 digits
                        ],

                        readOnly: true, // Prevent manual input
                        decoration: const InputDecoration(
                          border: InputBorder.none, // Removes the underline
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8), // Adjust padding if needed
                        ),
                      ),
                    ),
                  ),
                  2.width,
                ],
              ),
            ),
            10.height,
            Container(
              color: const Color(0xFFE3C998),
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      'PERSONAL TERMINAL',
                      style: k13NormalGreyColorStyle,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            10.height,
            Container(
              color: Colors.cyan.shade50,
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Obx(() {
                  //   if (profileController.isLoading.value) {
                  //     return const Center(
                  //       child: CircularProgressIndicator(),
                  //     );
                  //   }
                  //
                  //   return ElevatedButton(
                  //     onPressed: (){
                  //       Get.to(() => const FaceAttendanceScreen());
                  //     },
                  //     // onPressed: () async {
                  //     //   profileController.isLoading.value = true; // Show loading state
                  //     //
                  //     //   // Trigger the fetchEmployeeProfile API call
                  //     //    profileController.getApiProfile(emailCtr.text);
                  //     //
                  //     //   profileController.isLoading.value = false; // Hide loading state
                  //     //
                  //     //   if (profileController.employeeData.value != null) {
                  //     //     // Show success dialog if data is fetched successfully
                  //     //     Get.defaultDialog(
                  //     //       title: "Success",
                  //     //       middleText: "Employee data fetched successfully.",
                  //     //       textConfirm: "OK",
                  //     //       onConfirm: () => Navigator.push(
                  //     //         context,
                  //     //         MaterialPageRoute(
                  //     //           builder: (context) => Asddwed(data:profileController.employeeData.value ), // Replace with your target screen
                  //     //         ),
                  //     //       ),
                  //     //     );
                  //     //
                  //     //
                  //     //   } else {
                  //     //     // Show error dialog if data is null
                  //     //     Get.defaultDialog(
                  //     //       title: "Error",
                  //     //       middleText: "Failed to fetch data. Status: ", // You can include the actual error message here
                  //     //       textConfirm: "OK",
                  //     //       onConfirm: () => Get.back(),
                  //     //     );
                  //     //   }
                  //     // },
                  //
                  //     child: const Text(
                  //       "ok", // Button text
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   );
                  // }),

                  Checkbox(
                    value: true, // Initial value, change as per your logic
                    onChanged: (bool? newValue) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginCameraTwo(
                            attendanceId: emailCtr.text,
                          ), // Replace with your target screen
                        ),
                      );
                    },
                  ),

                  const SizedBox(width: 12),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "मैं उपस्थिति को चिन्हित करने के लिए अपनी स्वीकृति देता हूँ \n I give my approval  to mark attendance",
                        style: k13BoldBlackColorStyle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
            ),
            // Grid View for Attendance ID
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: attendanceIds.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.5,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (attendanceIds[index] == "Reset") {
                        emailCtr.clear();
                      } else if (attendanceIds[index] == "Back") {
                        String currentText = emailCtr.text;
                        if (currentText.isNotEmpty) {
                          emailCtr.text =
                              currentText.substring(0, currentText.length - 1);
                        }
                      } else {
                        // Check if the current length is less than 11 before adding more digits
                        if (emailCtr.text.length < 11) {
                          emailCtr.text += attendanceIds[index];
                        }
                      }
                      setState(() {}); // Refresh UI if necessary
                    },

                    // onTap: () {
                    //   if (attendanceIds[index] == "Reset") {
                    //     emailCtr.clear();
                    //   } else if (attendanceIds[index] == "Back") {
                    //     String currentText = emailCtr.text;
                    //     if (currentText.isNotEmpty) {
                    //       emailCtr.text =
                    //           currentText.substring(0, currentText.length - 1);
                    //     }
                    //   } else {
                    //     emailCtr.text += attendanceIds[index];
                    //   }
                    //   setState(() {}); // Refresh UI if necessary
                    // },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3C998),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        attendanceIds[index],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: FooterWidget(),
    );
  }
}
