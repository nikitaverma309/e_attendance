import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/constants/string_res.dart';
import 'package:online/models/profile/profile_model.dart';
import 'package:online/modules/home/home.dart';
import 'package:online/utils/utils.dart';
import 'package:online/widgets/app_button.dart';
import 'package:online/widgets/footer_widget.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileModel? data;

  const ProfileScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    String currentDateTime =
        DateFormat('yyyy-MM-dd    HH:mm:ss').format(DateTime.now());

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xF5ECF4F5),
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  margin: const EdgeInsets.all(20),
                  width: 50,
                  height: 50,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.offAll(() => const MyHomePage());
                      },
                    ),
                  ),
                ),
                Text(
                  'Hi ${data?.attendance!.name!}!',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ],
            ),

            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: MemoryImage(Utils.getImageFromBase64(data!
                      .employeeData!.encodedImage!)), // Use dynamic imagePath
                ),
              ),
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.21,
            ),

            // const Spacer(),
            Text(
              '${Strings.inTime}  : $currentDateTime', // Displays current date and time
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              'Name  :  ${data!.employeeData!.name}', // Displays current date and time
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              'Email  : ${data!.employeeData!.email}', // Use dynamic inTime
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              'Contact  : ${data!.employeeData!.contact}', // Use dynamic inTime
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              'Work Type  : ${data!.employeeData!.workType}', // Use dynamic inTime
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            CommonButton(
              text: "Ok  \\ LOG OUT  ",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              color: AppColors.bbFacebook,
            ),
            const Spacer(),
          ],
        ),
        bottomSheet: FooterWidget(),
      ),
    );
  }
}
