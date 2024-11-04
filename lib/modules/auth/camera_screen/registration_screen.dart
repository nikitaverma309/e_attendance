import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online/modules/auth/camera_screen/enter_details_view.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/widgets/common/custom_button.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  File? _image;
  ImagePicker? _imagePicker;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera"),
        backgroundColor:
        AppColors.scaffoldTopGradientClr, // You can customize this color
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              // Action for info button, if needed
            },
          ),
        ],
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
            SizedBox(height: screenHeight * 0.045),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(
                    0.05 * screenWidth,
                    0.025 * screenHeight,
                    0.05 * screenWidth,
                    0.04 * screenHeight),
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
                          size:
                          screenHeight * 0.038, // Updated to use MediaQuery
                        ),
                      ],
                    ),
                    SizedBox(
                        height:
                        screenHeight * 0.025), // Updated to use MediaQuery
                    _image != null
                        ? CircleAvatar(
                      radius: screenHeight *
                          0.15, // Updated to use MediaQuery
                      backgroundColor: const Color(0xffb4e3c9),
                      backgroundImage: FileImage(_image!),
                    )
                        : CircleAvatar(
                      radius: screenHeight *
                          0.15, // Updated to use MediaQuery
                      backgroundColor: const Color(0xfff1e9e9),
                      child: Icon(
                        Icons.camera_alt,
                        size: screenHeight *
                            0.09, // Updated to use MediaQuery
                        color: const Color(0xffa2cccc),
                      ),
                    ),
                    GestureDetector(
                      onTap: _getImage,
                      child: Container(
                        width: 60,
                        height: 60,
                        margin: const EdgeInsets.only(top: 44, bottom: 20),
                        decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            stops: [0.4, 0.65, 1],
                            colors: [
                              Color(0xff211414),
                              Color(0xff211414),
                              Color(0xff211414),
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius:
                          screenHeight * 0.15, // Updated to use MediaQuery
                          backgroundColor: const Color(0xfff1e9e9),
                          child: Icon(
                            Icons.camera_alt,
                            size: screenHeight *
                                0.03, // Updated to use MediaQuery
                            color: const Color(0xffa2cccc),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Click here to Capture",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.white.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    if (_image != null)
                      CustomButton(
                        text: "Start Registering",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EnterDetailsView(
                                image: _image!,
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _getImage() async {
    setState(() {
      _image = null;
    });
    final pickedFile = await _imagePicker?.pickImage(
      source: ImageSource.camera,
      maxWidth: 400,
      maxHeight: 400,
      // imageQuality: 50,
    );
    if (pickedFile != null) {
      _setPickedFile(pickedFile);
    }
    setState(() {});
  }

  Future _setPickedFile(XFile? pickedFile) async {
    final path = pickedFile?.path;
    if (path == null) {
      return;
    }
    setState(() {
      _image = File(path);
    });
  }
}
