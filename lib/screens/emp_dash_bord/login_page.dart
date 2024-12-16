import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/controllers/all_user_type.dart';
import 'package:online/controllers/login_dash_bord.dart';
import 'package:online/generated/assets.dart';
import 'package:online/models/all_user_type_model.dart';
import 'package:online/widgets/app_button.dart';
import 'package:online/widgets/common/app_bar_widgets.dart';

import 'cmo_dash_bord.dart';

class LoginPage extends StatelessWidget {
  final LoginDashBordController loginController =
      Get.put(LoginDashBordController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userType = TextEditingController();
  final UserTypeController userTypeController = Get.put(UserTypeController());
  GetAllUserType? selectedUserType;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color
      backgroundColor: const Color(0xFFf0f0f0),
      appBar: const CustomAppBar(
        title: "Login",
        actionIcon: Icons.ice_skating,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey, // Assigning the form key
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
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

                20.height,
                const Text("Higher Education Department",
                    style: kTextBlackColorStyle),
                const Text("Government Of Chhattisgarh",
                    style: k13BoldBlackColorStyle),
                Obx(() {
                  if (userTypeController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (userTypeController.userTypes.isEmpty) {
                    return const Center(child: Text("No data found"));
                  }
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButtonFormField<GetAllUserType>(
                      decoration: const InputDecoration(
                        labelText: "Select User Type",
                        border: OutlineInputBorder(),
                      ),
                      items: userTypeController.userTypes.map((userType) {
                        return DropdownMenuItem<GetAllUserType>(
                          value: userType,
                          child: Text(
                              userType.userType ?? userType.userType ?? ""),
                        );
                      }).toList(),
                      onChanged: (selected) {
                        if (selected != null) {
                          selectedUserType = selected;
                          if (kDebugMode) {
                            print("Selected User Type: ${selected.userType}");
                          }
                        }
                      },
                    ),
                  );
                }),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                // Password TextField
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // CommonButton(
                //   onPressed: () {
                //     Get.to(() => const UserDashBord());
                //   },
                //   text: "sd",
                //   color: Colors.black,
                // ),
                // Login Button with Obx loading state
                Obx(() {
                  if (loginController.isLoading.value) {
                    return const CircularProgressIndicator();
                  } else {
                    return CommonButton(
                      onPressed: () {

                        if (_formKey.currentState?.validate() ?? false) {
                          if (selectedUserType == null) {
                            toast("Please select a user type");
                            return;
                          }
                          String username = usernameController.text.trim();
                          String password = passwordController.text.trim();

                          loginController.login(
                            selectedUserType?.userType ?? "",
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

                50.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
