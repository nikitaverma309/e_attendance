import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/controllers/login_dash_bord.dart';
import 'package:online/generated/assets.dart';
import 'package:online/widgets/app_button.dart';
import 'package:online/widgets/common/app_bar_widgets.dart';

class LoginPage extends StatelessWidget {
  final LoginDashBordController loginController =
      Get.put(LoginDashBordController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


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

                50.height,
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
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Login Button with Obx loading state
                Obx(() {
                  if (loginController.isLoading.value) {
                    return const CircularProgressIndicator();
                  } else {
                    return CommonButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // If the form is valid, proceed with login
                          String username = usernameController.text.trim();
                          String password = passwordController.text.trim();
                          String userType = "Employee";
                          loginController.login(username, password, userType);
                        } else {
                          // If validation fails, show snackbar
                          Get.snackbar(
                              "Error", "Please fill in all fields correctly.");
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
                      onTap: () {
                        // Navigate to forgot password screen
                      },
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
