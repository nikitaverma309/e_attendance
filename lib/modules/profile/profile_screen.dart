import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/generated/assets.dart';
import 'package:online/models/profile/profile_model.dart';
import 'package:online/modules/home/main_page.dart';
import 'package:online/utils/utils.dart';
import 'package:online/widgets/app_button.dart';
import 'package:online/widgets/card_tittle_page_show.dart';
import 'package:online/widgets/footer_widget.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileModel? data;

  const ProfileScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff176daa),
          centerTitle: true,
          elevation: 7,
          title: Text(
            "Profile",
            textAlign: TextAlign.center,
            style: kWhite.copyWith(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Colors.white), // Icon for back
            onPressed: () {
              Get.offAll(() => const MainPage()); // Navigate to MainPage
            },
          ),
        ),
        body: Column(
          children: [

            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xff204867),
                      borderRadius: BorderRadius.circular(1),
                      border: Border.all(
                        color: Colors.blueGrey,
                        width: 1.0,
                      ),
                    ),
                    child: Card(
                      elevation: 12,
                      child: Image.memory(
                        // height: 90,
                        // width: 90,
                        base64Decode(data!.employeeData!.encodedImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "Login Time",
                          style: kTextBlackColorStyle,
                          textAlign: TextAlign.justify,
                        ),
                        Text(
                          Utils.formatTime(data!.attendance!.loginTime),
                          style: kTextBlueColorStyle,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: Colors.black,
            //     image: DecorationImage(
            //       fit: BoxFit.cover,
            //       image: MemoryImage(Utils.getImageFromBase64(data!
            //           .employeeData!.encodedImage!)), // Use dynamic imagePath
            //     ),
            //   ),
            //   margin: const EdgeInsets.all(2),
            //   width: MediaQuery.of(context).size.width * 0.4,
            //   height: MediaQuery.of(context).size.height * 0.26,
            // ),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 230,
                color: const Color(0xffe7eeee),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
      
                    ResultOutPutCard(
                      title: 'Name ',
                      subTitle: "${data!.employeeData!.name}",
                    ),
                    ResultOutPutCard(
                      title: 'Email ',
                      subTitle: "${data!.employeeData!.email}",
                    ),
                    ResultOutPutCard(
                      title: 'Contact ',
                      subTitle: "${data!.employeeData!.contact}",
                    ),
                    ResultOutPutCard(
                      title: 'Work Type ',
                      subTitle: "${data!.employeeData!.workType}",
                    ),
                    ResultOutPutCard(
                      title: 'Login OutTime ',
                      subTitle: Utils.formatTime(data!.attendance!.logoutTime),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            CommonButton(
              text: "Ok  \\ LOG OUT  ",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainPage()),
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
