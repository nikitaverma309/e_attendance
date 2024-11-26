import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/models/profile/profile_model.dart';
import 'package:online/modules/home/home.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xF5ECF4F5),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                  const Text(
                    'Profile',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: MemoryImage(Utils.getImageFromBase64(data!
                        .employeeData!.encodedImage!)), // Use dynamic imagePath
                  ),
                ),
                margin: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.26,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  decoration: Shape.boxContainer(context),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ResultOutPutCard(
                        title: 'Day  ',
                        subTitle: Utils.formatDay(data!.attendance!.loginTime),
                      ),
                      ResultOutPutCard(
                        title: 'Login Time ',
                        subTitle: Utils.formatTime(data!.attendance!.loginTime),
                      ),
                      ResultOutPutCard(
                        title: 'Login OutTime ',
                        subTitle:
                            Utils.formatTime(data!.attendance!.logoutTime),
                      ),
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
        ),
        bottomSheet: FooterWidget(),
      ),
    );
  }
}
