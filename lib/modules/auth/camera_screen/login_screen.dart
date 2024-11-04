import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online/controllers/login_controller.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/utils/utils.dart';

class LoginCameraView extends StatefulWidget {
  const LoginCameraView({Key? key}) : super(key: key);

  @override
  State<LoginCameraView> createState() => _LoginCameraViewState();
}

class _LoginCameraViewState extends State<LoginCameraView> {
  File? _image;
  ImagePicker? _imagePicker;
  final LoginController _loginController = Get.put(LoginController());
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
        backgroundColor: AppColors.scaffoldTopGradientClr,
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
                          size: screenHeight * 0.038,
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    _image != null
                        ? CircleAvatar(
                      radius: screenHeight * 0.15,
                      backgroundColor: const Color(0xffb4e3c9),
                      backgroundImage: FileImage(_image!),
                    )
                        : CircleAvatar(
                      radius: screenHeight * 0.15,
                      backgroundColor: const Color(0xfff1e9e9),
                      child: Icon(
                        Icons.camera_alt,
                        size: screenHeight * 0.09,
                        color: const Color(0xffa2cccc),
                      ),
                    ),
                    GestureDetector(
                      onTap: _showImageSourceDialog,
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
                          radius: screenHeight * 0.15,
                          backgroundColor: const Color(0xfff1e9e9),
                          child: Icon(
                            Icons.camera_alt,
                            size: screenHeight * 0.03,
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
                      Center(
                        child: Obx(() {
                          return _loginController.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                            onPressed: () async {
                              if (!_loginController.isLoading.value) {
                                _loginController.isLoading.value =
                                true; // Start loading

                                if (_image != null) {
                                  await _loginController
                                      .uploadFileLogin(context, _image!);
                                  _loginController.isLoading.value =
                                  false; // Stop loading

                                  Utils.showSuccessToast(
                                      message:
                                      'Image uploaded successfully!');
                                } else {
                                  _loginController.isLoading.value =
                                  false; // Stop loading
                                }
                              }
                            },
                            child: _loginController.isLoading.value
                                ? const CircularProgressIndicator(
                                color: Colors.black)
                                : const Text('Login Now'),
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
    );
  }

  Future<void> _showImageSourceDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _getImage(ImageSource.camera);
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _getImage(ImageSource.gallery);
              },
              child: const Text('Gallery'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    setState(() {
      _image = null;
    });
    final pickedFile = await _imagePicker?.pickImage(
      source: source,
      maxWidth: 400,
      maxHeight: 400,
      // imageQuality: 50, // Uncomment to reduce quality if needed
    );
    if (pickedFile != null) {
      _setPickedFile(pickedFile);
    }
    setState(() {});
  }

  Future<void> _setPickedFile(XFile? pickedFile) async {
    final path = pickedFile?.path;
    if (path == null) {
      return;
    }
    setState(() {
      _image = File(path);
    });
  }
}
