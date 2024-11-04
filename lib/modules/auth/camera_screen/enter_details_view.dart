import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/controllers/login_controller.dart';
import 'package:online/models/user_register_model.dart';
import 'package:online/utils/utils.dart';
import 'package:online/widgets/app_text_field.dart';
import 'package:online/widgets/common/app_bar_widgets.dart';

class EnterDetailsView extends StatefulWidget {
  final File image;

  const EnterDetailsView({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<EnterDetailsView> createState() => _EnterDetailsViewState();
}

class _EnterDetailsViewState extends State<EnterDetailsView> {
  bool isRegistering = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController empController = TextEditingController();
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
      title: "Add Detail - Enter Details View",
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
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey, // Use Form widget for validation
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextField(
                    labelText: 'Employee Code',
                    controller: empController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20), // Add some space
                  // Display the captured image in a circular container
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Optional: Add a circular border or shadow
                      Container(
                        width:
                            150, // Set a fixed width for the circular container
                        height:
                            150, // Set a fixed height for the circular container
                        decoration: BoxDecoration(
                          color: AppColors.athensGray
                              .withOpacity(0.5), // Background color
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      ClipOval(
                        child: Image.file(
                          widget.image,
                          fit: BoxFit.cover,
                          width: 150, // Set the same width as the container
                          height: 150, // Set the same height as the container
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20), // Add some space
                  Center(
                    child: Obx(() {
                      return _loginController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () async {
                                if (!_loginController.isLoading.value) {
                                  if (_formKey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    _loginController.isLoading.value =
                                        true; // Start loading

                                    int? empCode =
                                        int.tryParse(empController.text.trim());
                                    if (empCode != null) {
                                      RegisterUserModel user =
                                          RegisterUserModel(
                                        empCode: empCode,
                                        image: widget.image,
                                      );

                                      await _loginController.uploadFileSignUp(
                                          empCode, widget.image);
                                      _loginController.isLoading.value =
                                          false; // Stop loading

                                      Utils.showSuccessToast(
                                          message:
                                              'Image uploaded successfully!');
                                    } else {
                                      _loginController.isLoading.value =
                                          false; // Stop loading
                                      Utils.showSuccessToast(
                                          message:
                                              'Please capture an image and enter employee code');
                                    }
                                  }
                                }
                              },
                              child: _loginController.isLoading.value
                                  ? const CircularProgressIndicator(
                                      color: Colors
                                          .white) // Change color as needed
                                  : const Text('Register Now'),
                            );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
