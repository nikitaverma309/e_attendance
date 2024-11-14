import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online/controllers/check_status_employee_controller.dart';
import 'package:online/modules/auth/login/login_camera.dart';
import 'package:online/modules/auth/registration/registration_camera.dart';
import 'package:online/utils/utils.dart';
import 'package:online/widgets/common/custom_widgets.dart';
import 'package:online/widgets/common/form_input_widgets.dart';
import 'package:online/widgets/footer_widget.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = false;

  final TextEditingController empCodeController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final CheckStatusEmployeeController employeeController =
      Get.put(CheckStatusEmployeeController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff176daa),
      body: !loading
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 50),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(), // Takes up remaining space
                        Icon(Icons.more_vert, color: Colors.white),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Higher Education Department's",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),

                  const SizedBox(height: 170),

                  // Centering the logo and text
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: const Image(
                              image: AssetImage('assets/logo.png'),
                              height: 88,
                              width: 88,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Secure and Smart Online Attendance System",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        // Center the buttons
                        customButton(
                          context,
                          'LOGIN',
                          Colors.white,
                          Colors.blueAccent,
                          Icons.login,
                          () {
                            if (mounted) {
                              Get.to(() => const LoginCameraTwo());
                            }
                          },
                        ),

                        const SizedBox(height: 10),
                        customButton(
                          context,
                          'SIGN UP',
                          Colors.blueAccent,
                          Colors.white,
                          Icons.person_add,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const RegistrationScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        customButton(
                          context,
                          'EmpRegistration Form',
                          Colors.blueAccent,
                          Colors.white,
                          Icons.person_add,
                          () {
                            _showEmpRegistrationBottomSheet(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      bottomSheet: FooterWidget(),
    );
  }

  void _showEmpRegistrationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Stack(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Check status",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextInputField(
                      no: "1",
                      controller: empCodeController,
                      title: "Employee Code",
                      hintText: 'Fill details',
                    ),
                    const SizedBox(height: 10),
                    TextInputField(
                      no: "2",
                      controller: contactController,
                      title: "Contact",
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Allows only digits
                        LengthLimitingTextInputFormatter(
                            10), // Limits input to 10 digits
                      ],
                      inputType: TextInputType.phone,
                      validator: (value) => Utils.validateRequired(value),
                      hintText: 'Fill Contact Nu.',
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => InkWell(
                        onTap: () async {
                          // Add form validation check before calling fetchEmployeeData
                          if (_formKey.currentState?.validate() ?? false) {
                            if (empCodeController.text.isNotEmpty &&
                                contactController.text.isNotEmpty) {
                              await employeeController.fetchEmployeeData(
                                empCodeController.text
                                    .trim(), // Pass trimmed text
                                contactController.text.trim(),
                              );
                            } else {
                              Get.snackbar(
                                "Error",
                                "Please fill in all fields",
                                snackPosition:
                                    SnackPosition.BOTTOM, // Snackbar position
                                backgroundColor: Colors.red, // Background color
                                colorText: Colors.white, // Text color
                                borderRadius: 10, // Border radius
                                margin: EdgeInsets.all(
                                    10), // Margin around snackbar
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 10,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
