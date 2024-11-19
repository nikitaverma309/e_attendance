import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/string_res.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/modules/auth/login/login_camera.dart';
import 'package:online/utils/shap/shape_design.dart';
import 'package:online/widgets/common/app_bar_widgets.dart';
import 'package:online/widgets/footer_widget.dart';
import 'package:text_scroll/text_scroll.dart';

class FaceAttendanceScreen extends StatefulWidget {
  const FaceAttendanceScreen({super.key});

  @override
  State<FaceAttendanceScreen> createState() => _FaceAttendanceScreenState();
}

class _FaceAttendanceScreenState extends State<FaceAttendanceScreen> {
  bool isChecked = false;

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
      appBar: CustomAppBar(
        title: Strings.attendance,
        showBackButton: true,
        actionWidget: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onSelected: (value) {
            if (value == 'option1') {
              print('Option 1 selected');
            } else if (value == 'option2') {
              print('Option 2 selected');
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'option1',
              child: Text('Option 1'),
            ),
            const PopupMenuItem(
              value: 'option2',
              child: Text('Option 2'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.height,
            const Padding(
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
            Container(
              color: const Color(0xFFE3C998),
              height: 60,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "उपस्थिति आईडी            \n Attendance ID         ",
                        style: k13BoldBlackColorStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: Shape.submitContainerRed(context),
                      child: TextField(
                        controller: emailCtr,
                        readOnly: true, // Prevent manual input
                        decoration: const InputDecoration(
                          hintText: 'Enter Attendance ID...',
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
              color: const Color(0xFFBABACF),
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value ?? false;
                      });

                      if (isChecked == true) {
                        // Navigate to another page and pass the emailCtr.text value
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginCameraTwo(attendanceId: emailCtr.text),
                          ),
                        );
                      }

                    },
                  ),
                  const SizedBox(width: 5),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "मैं उपस्थिति को चिन्हित करने के लिए अपने प्रमाण पत्र के लिए अपनी स्वीकृति देता हूँ \n I give my approval for my certificate to mark attendance",
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
                        emailCtr.text += attendanceIds[index];
                      }
                      setState(() {}); // Refresh UI if necessary
                    },
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
