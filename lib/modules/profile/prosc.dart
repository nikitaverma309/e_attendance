
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../constants/colors_res.dart';
import '../../constants/string_res.dart';
import '../../models/profile/profile_model.dart';
import '../../res/assetimagespath.dart';
import '../../widgets/app_button.dart';
import '../../widgets/common/app_bar_widgets.dart';
import '../../widgets/footer_widget.dart';
import '../home/home.dart';

class Asddwed extends StatelessWidget {
  final ProfileModel? data;

  const Asddwed({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xF5ECF4F5),
        appBar: AppBar(
          backgroundColor: const Color(0xff176daa),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Colors.white), // Set the back icon color to white
            onPressed: () {
              Get.offAll(() => MyHomePage());
            },
          ),
          centerTitle: false,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the title
            children: [
              Expanded(
                child: Text(
                  "Hi Nikita Verma",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, // Set the title color to white
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(File(data!.image)), // Use dynamic imagePath
                    ),
                  ),
                  margin: const EdgeInsets.all(20),
                  width: 50,
                  height: 50,
                ),
                Text(
                  'Hi ${data?.name.toString()}!', // Use dynamic username
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ],
            ),

            // Text(
            //   'Shift Name \\ ${data!.updatedAt} !  : ${Strings.morning}', // Use dynamic shiftName
            //   style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            // ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(File(data!.image)), // Use dynamic imagePath
                ),
              ),
              margin: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.21,
            ),
            // Text(
            //   '${Strings.inTime}  : ${data!.createdAt}', // Use dynamic inTime
            //   style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            // ),
            // Text(
            //   '${Strings.outTime}   : ${data!.updatedAt}', // Use dynamic outTime
            //   style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            // ),
            // Text(
            //   '${Strings.responseTime}  \\ Response Time:  ${data?.updatedAt.toString()}', // Use dynamic responseTime
            //   style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            // ),
            // const Spacer(),
            Text(
              '${Strings.inTime}  : $currentDateTime', // Displays current date and time
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              'Name  :  ${data!.name}', // Displays current date and time
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
