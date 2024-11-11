import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/controllers/login_controller.dart';
import 'package:online/widgets/common/custom_button.dart';
import 'package:online/widgets/footer_widget.dart';

class LoginCameraViewTwo extends StatefulWidget {
  final File? imageFile; // यह फ़ाइल जो कैमरा से ली गई इमेज है
  const LoginCameraViewTwo({super.key, this.imageFile});

  @override
  State<LoginCameraViewTwo> createState() => _LoginCameraViewTwoState();
}

class _LoginCameraViewTwoState extends State<LoginCameraViewTwo> {
  final AudioPlayer _audioPlayer = AudioPlayer(); // ऑडियो प्लेयर
  final LoginController loginController =
      Get.put(LoginController()); // लॉगिन कंट्रोलर
  bool isMatching = false; // यह वैरिएबल बताता है कि क्या इमेज मैच कर रही है

  // स्कैनिंग ऑडियो प्ले करने के लिए फ़ंक्शन
  void _playScanningAudio() {
    _audioPlayer
      ..setReleaseMode(ReleaseMode.loop)
      ..play(AssetSource("scan_beep.wav"));
  }

  // फेल ऑडियो प्ले करने के लिए फ़ंक्शन
  void _playFailedAudio() {
    _audioPlayer
      ..stop()
      ..setReleaseMode(ReleaseMode.release)
      ..play(AssetSource("failed.mp3"));
  }

  // सफल ऑथेंटिकेशन के लिए ऑडियो प्ले करने के लिए फ़ंक्शन
  void _playSuccessfulAudio() {
    _audioPlayer
      ..stop()
      ..setReleaseMode(ReleaseMode.release)
      ..play(AssetSource("success.mp3")); // आपकी सफलता की ऑडियो फाइल
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight =
        MediaQuery.of(context).size.height; // स्क्रीन की ऊँचाई
    double screenWidth = MediaQuery.of(context).size.width; // स्क्रीन की चौड़ाई

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Camera"),
        backgroundColor: AppColors.scaffoldTopGradientClr,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back icon
          onPressed: () {
            Get.back(result: null); // Pass null when going back
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.scaffoldTopGradientClr,
              AppColors.scaffoldBottomGradientClr,
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.045), // शीर्ष पर स्पेस
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(
                  0.05 * screenWidth,
                  0.025 * screenHeight,
                  0.05 * screenWidth,
                  0.04 * screenHeight,
                ),
                decoration: BoxDecoration(
                  color: AppColors.bbFacebook,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.03 * screenHeight),
                    topRight: Radius.circular(0.03 * screenHeight),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.bbAccentColor,
                          size: screenHeight * 0.038,
                        ),
                      ],
                    ),
                    SizedBox(
                        height:
                            screenHeight * 0.012), // इमेज कैप्चर के लिए स्पेस
                    Container(
                      width: screenHeight * 0.30, // कोंटेनर की चौड़ाई
                      height: screenHeight * 0.30, // कोंटेनर की ऊँचाई
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15), // गोल किनारे
                        color: const Color(0xfff1e9e9),
                      ),
                      child: widget.imageFile != null
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(3), // गोल किनारे
                              child: Image.file(
                                widget.imageFile!,
                                fit: BoxFit.contain, // इमेज को फिट करें
                              ),
                            )
                          : Icon(
                              Icons.camera_alt,
                              size: screenHeight * 0.09,
                              color: const Color(0xffa2cccc),
                            ),
                    ),

                    SizedBox(height: screenHeight * 0.025), // बटन के लिए स्पेस
                    if (widget.imageFile != null) // अगर इमेज फ़ाइल मौजूद है
                      Center(
                        child: Obx(() {
                          return loginController.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : CustomButton(
                                  onTap: () async {
                                    if (!loginController.isLoading.value) {
                                      loginController.isLoading.value =
                                          true; // लोडिंग शुरू करें

                                      if (widget.imageFile != null) {
                                        setState(() => isMatching = true);
                                        _playScanningAudio(); // स्कैनिंग ऑडियो प्ले करें

                                        // यहाँ इमेज अपलोड करें
                                        bool isAuthenticated =
                                            await loginController
                                                .uploadFileLogin(
                                                    context, widget.imageFile!);

                                        // अगर ऑथेंटिकेशन सफल हो तो ऑडियो प्ले करें
                                        if (isAuthenticated) {
                                          _playSuccessfulAudio(); // सफल ऑडियो प्ले करें
                                        } else {
                                          _playFailedAudio(); // फेल ऑडियो प्ले करें
                                        }

                                        loginController.isLoading.value =
                                            false; // लोडिंग रोकें
                                      } else {
                                        loginController.isLoading.value =
                                            false; // लोडिंग रोकें
                                      }
                                    }
                                  },
                                  text: 'Authenticate',
                                );
                        }),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: FooterWidget(),
    );
  }
}
