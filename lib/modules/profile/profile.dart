import 'dart:io';

import 'package:flutter/material.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/res/assetimagespath.dart';
import 'package:online/widgets/app_button.dart';
import 'package:online/widgets/common/app_bar_widgets.dart';
import 'package:online/widgets/footer_widget.dart';

import '../home/home.dart';
import '../../constants/string_res.dart';

class Profile extends StatelessWidget {
  const Profile(this.username, {Key? key, required this.imagePath})
      : super(key: key);
  final String username;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xF5ECF4F5),
        appBar: const CustomAppBar(
          title: Strings.guest,
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
                      image: FileImage(File(imagePath)),
                    ),
                  ),
                  margin: const EdgeInsets.all(20),
                  width: 50,
                  height: 50,
                ),
                Text(
                  'Hi $username!',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                AssetImagePath.logoPath,
                width: MediaQuery.of(context).size.width *
                    0.2, // Screen width ka 30%
                height: MediaQuery.of(context).size.height * 0.12,
              ),
            ),
            const Text(
              'Shift Name \\ ${Strings.shiftName} !  : ${Strings.morning}',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(File(imagePath)),
                ),
              ),
              margin: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width *
                  0.4, // Screen width ka 30%
              height: MediaQuery.of(context).size.height *
                  0.21, // Screen height ka 15%
            ),
            const Text(
              '${Strings.inTime}  : ${Strings.morning}',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              '${Strings.outTime}   : ${Strings.morning}',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              '${Strings.responseTime}  \\ Response Time:  11:254',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Spacer(),
            AppButton(
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
              color: AppColors.bbAccentColor,
            ),
            Spacer(),
          ],
        ),
        bottomSheet: FooterWidget(),
      ),
    );
  }
}
