import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/models/profile/user_model.dart';
import 'package:online/modules/home/main_page.dart';
import 'package:online/utils/shap/shape_design.dart';
import 'package:online/utils/utils.dart';
import 'package:online/widgets/app_button.dart';
import 'package:online/widgets/card_tittle_page_show.dart';
import 'package:online/widgets/footer_widget.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileModel? data;

  const ProfileScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.offAll(() => const MainPage());
          },
        ),
      ),
      body: Container(

        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
                'assets/icon/wallpaper.png'), // Use the asset image path
          ),
        ),
        child: Column(
          children: [
            20.height,
            const Text("Higher Education Department",
                style: kTextBlackColorStyle),
            const Text("Government Of Chhattisgarh",
                style: k13BoldBlackColorStyle),
            20.height,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: Shape.cameraView(context),
              // decoration: BoxDecoration(
              //   color: const Color(0xff204867),
              //   borderRadius: BorderRadius.circular(4),
              //   border: Border.all(
              //     color: Colors.blueGrey,
              //     width: 1.0,
              //   ),
              // ),
              child: SizedBox(
                height: screenHeight * 0.2,
                width: screenWidth * 0.4,
                child: Card(
                  elevation: 35,
                  child: Image.memory(
                    // height: 90,
                    // width: 90,
                    base64Decode(data!.encodedImage!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: Card(
                elevation: 34,
                child: Container(
                  width: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xfff6f2f2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      10.height,
                      ResultOutPutCard(
                        title: 'Name ',
                        subTitle: "${data!.name}",
                      ),
                      ResultOutPutCard(
                        title: 'Email ',
                        subTitle: Utils.maskEmail(data!.email ?? ""),
                      ),
                      ResultOutPutCard(
                        title: 'Contact ',
                        subTitle: Utils.maskContact(data!.contact.toString()),
                      ),
                      ResultOutPutCard(
                        title: 'Work Type ',
                        subTitle: "${data!.workType}",
                      ),

                      // ResultOutPutCard(
                      //   title: 'Login OutTime ',
                      //   subTitle:
                      //       Utils.formatTime(data!.logoutTime),
                      // ),
                      10.height,
                    ],
                  ),
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
            20.height,
          ],
        ),
      ),
      bottomSheet: FooterWidget(),
    );
  }
}
