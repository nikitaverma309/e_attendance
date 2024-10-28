import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:online/modules/auth/sign-up.dart';

import 'controllers/login_controller.dart';

class LoginPageTwo extends StatefulWidget {
  const LoginPageTwo({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPageTwo> createState() => _LoginPageTwoState();
}

class _LoginPageTwoState extends State<LoginPageTwo> {
  final LoginController loginController = Get.put(LoginController());
  final TextEditingController empCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    var statusBarHeight = MediaQuery.of(context).padding.top;
    mediaHeight = mediaHeight - statusBarHeight;
    if (mediaHeight < 300) {
      mediaHeight = 300;
    }
    if (mediaWidth > 500) {
      mediaWidth = 500;
    }

    print('height is $mediaHeight');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Shining',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Colors.white,
                  Colors.white,
                  Colors.white,
                  Color(0xff176daa),
                  Color(0xff176daa),
                ])),
          ),
        ),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff176daa), Color(0xff447897)])),
            height: mediaHeight,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff176daa), Color(0xff447897)])),
                height: mediaHeight,
                width: mediaWidth,
                child: Stack(children: [
                  Positioned(
                    top: -mediaHeight * 0.04,
                    right: 0,
                    child: Transform.rotate(
                      angle: 0.785398,
                      child: Container(
                        height: mediaHeight * 0.9,
                        width: mediaWidth * 0.527,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          gradient: const LinearGradient(
                              //transform: GradientRotation(1.5708),
                              colors: [
                                Color(0xff87bee6),
                                Color(0xff274f6c),
                              ]),
                        ),
                      ),
                    ),
                  ),
                  //Shape 4

                  //Shape 3
                  Positioned(
                    top: -mediaHeight * 0.04,
                    right: 0,
                    child: Transform.rotate(
                      angle: 0.785398,
                      child: Container(
                        height: mediaHeight * 0.9,
                        width: mediaWidth * 0.527,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          gradient: const LinearGradient(
                              //transform: GradientRotation(1.5708),
                              colors: [
                                Color(0xff87bee6),
                                Color(0xff274f6c),
                              ]),
                        ),
                      ),
                    ),
                  ),
                  //Shape 2
                  Positioned(
                    top: -mediaHeight * 0.286,
                    right: 0,
                    child: Transform.rotate(
                      angle: 0.785398,
                      child: Container(
                        height: mediaHeight * 0.36,
                        width: mediaWidth * 0.61,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Color(0xff274b65),
                        ),
                      ),
                    ),
                  ),
                  //Shape 1
                  Positioned(
                    top: -(mediaHeight * 0.083),
                    right: mediaWidth * 0.33,
                    child: Transform.rotate(
                      angle: 0.785398,
                      child: Container(
                        height: mediaHeight * 0.86,
                        width: mediaWidth * 1.4,
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(72)),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const Image(
                      image: AssetImage('assets/face-id.png'),
                      height: 88,
                      width: 88,
                      fit: BoxFit.cover,
                    ),
                  ),
                  //UserName
                  Container(
                    margin: EdgeInsets.only(
                        top: mediaHeight * 0.26, left: mediaWidth * 0.1),
                    width: mediaWidth * 0.6,
                    child: TextField(
                      controller: empCode,
                      decoration: InputDecoration(
                        label: Text(
                          'User Employee code',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff747474)),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffD1D1D4), width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffD1D1D4), width: 2),
                        ),
                      ),
                    ),
                  ),

                  // Log in button
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SignUp(employeeCode: empCode.text),
                        ),
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: mediaWidth * 0.05),
                      margin: EdgeInsets.only(
                          top: mediaHeight * 0.5, left: mediaWidth * 0.1),
                      height: mediaHeight * 0.1,
                      width: mediaWidth * 0.7,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Color(0xffa4c6dc),
                                offset: Offset(0.0, 0.75),
                                spreadRadius: 2,
                                blurRadius: 2)
                          ],
                          color: Colors.white,
                          border: Border.all(color: Color(0xffD4D3E8)),
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('LOG IN NOW CAMERA',
                                style: TextStyle(
                                  color: const Color(0xff103149),
                                  fontWeight: FontWeight.bold,
                                  fontSize: (mediaHeight * 0.1) * 0.2,
                                )),
                            Transform.rotate(
                              angle: 3.14159,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xff7875B5),
                                size: (mediaHeight * 0.1) * 0.35,
                              ),
                            )
                          ]),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
