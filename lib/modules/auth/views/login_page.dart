import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/generated/assets.dart';
import 'package:online/modules/auth/controllers/all_user_type.dart';
import 'package:online/modules/auth/controllers/login_controller.dart';
import 'package:online/modules/auth/models/all_user_type_model.dart';
import 'package:online/utils/shap/shape_design.dart';
import 'package:online/utils/utils.dart';
import 'package:online/widgets/app_button.dart';
import 'package:online/widgets/common/app_bar_widgets.dart';
import 'package:online/widgets/common/custom_widgets.dart';
import 'package:online/widgets/common/login_input_widgets.dart';

class LoginPage extends StatelessWidget {
  final LoginDashBordController loginController =
      Get.put(LoginDashBordController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserTypeController userTypeController = Get.put(UserTypeController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffe7e7ec),
      appBar: const CustomAppBar(
        title: "Login",
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: const Color(0xffb8cbd8),
                      elevation: 6,
                      child: const Image(
                        image: AssetImage(Assets.imagesCglogo),
                        height: 88,
                        width: 88,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                const Text("Higher Education Department",
                    style: kTextBlackColorStyle),
                const Text("Government Of Chhattisgarh",
                    style: k13BoldBlackColorStyle),
                SizedBox(height: screenHeight * 0.02),
                Shape.getStyledCard(
                  context,
                  [
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: Column(
                        children: [
                          SizedBox(height: screenHeight * 0.02),
                          Obx(() {
                            if (userTypeController.userTypesList.isEmpty) {
                              return const DropDownSelectionMessage(
                                message: 'Select User Type',
                              );
                            }
                            return CustomDropdown<GetAllUserType>(
                              items: userTypeController.userTypesList,
                              selectedValue:
                                  userTypeController.getSelectedUserType.value,
                              hint: 'Select User Type',
                              onChanged: (GetAllUserType? newCass) {
                                if (newCass != null) {
                                  userTypeController
                                      .selectUser(newCass.userType!);
                                }
                              },
                              idKey: '_id',
                              displayKey: 'UserType',
                            );
                          }),
                          SizedBox(height: screenHeight * 0.02),
                          InputField(
                            controller: usernameController,
                            enabled: usernameController.text.isEmpty,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(14),
                            ],
                            inputType: TextInputType.phone,
                            validator: (value) => Utils.validateRequired(value),
                            hintText: 'Please enter your username.',
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          InputField(
                            controller: passwordController,
                            enabled: passwordController.text.isEmpty,
                            validator: (value) => Utils.validateRequired(value),
                            isPasswordField: true,
                            hintText: 'Please enter your password.',
                          ),
                          SizedBox(height: screenHeight * 0.02),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.05),
                Obx(() {
                  if (loginController.isLoading.value) {
                    return const CircularProgressIndicator();
                  } else {
                    return CommonButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          String selectedUserType = userTypeController
                                  .getSelectedUserType.value?.userType ??
                              "";
                          String username = usernameController.text.trim();
                          String password = passwordController.text.trim();

                          loginController.login(
                            selectedUserType,
                            username,
                            password,
                          );
                        }
                      },
                      text: "Login",
                      color: Colors.black,
                    );
                  }
                }),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
