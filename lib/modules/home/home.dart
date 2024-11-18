import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/controllers/check_status_employee_controller.dart';
import 'package:online/generated/assets.dart';
import 'package:online/modules/auth/login/login_camera.dart';
import 'package:online/modules/auth/registration/registration_camera.dart';
import 'package:online/screens/comman_screen/faq.dart';
import 'package:online/widgets/app_button.dart';
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
  final CheckStatusEmployeeController employeeController = Get.put(CheckStatusEmployeeController());
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Welcome ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow
                                .ellipsis, // Prevent text from overflowing
                          ),
                        ),
                        DropdownButton<String>(
                          icon:
                              const Icon(Icons.more_vert, color: Colors.white),
                          dropdownColor:
                              Colors.white, // Dropdown menu background color
                          underline: const SizedBox(), // Remove the underline
                          items: const [
                            DropdownMenuItem(
                              value: 'page1',
                              child: Text('Employee Registration Form',
                                  style: kText10BlueBlackColorStyle),
                            ),
                            DropdownMenuItem(
                              value: 'page2',
                              child: Text('FAQ',
                                  style: kText10BlueBlackColorStyle),
                            ),
                          ],
                          onChanged: (value) {
                            if (value == 'page1') {
                              _showEmpRegistrationBottomSheet(context);
                            } else if (value == 'page2') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                       FAQPage(),
                                ),
                              );
                            }
                          },
                        ),
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
                  68.height,

                  // Centering the logo and text
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    50), // Use a high value for circular shape
                              ),
                              color: const Color(0xff5699c9),
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
                        10.height,
                        const Text(
                          "Secure and Smart Online Attendance System",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        30.height,
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    50), // Use a high value for circular shape
                              ),
                              color: const Color(0xff204867),
                              elevation: 55,
                              child: const Image(
                                image: AssetImage('assets/logo.png'),
                                height: 44,
                                width: 44,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        5.height,
                        customButton(
                          context,
                          'LOGIN',
                          Colors.white,
                          Colors.black,
                          Icons.login,
                          () {
                            if (mounted) {
                              Get.to(() => const LoginCameraTwo());
                            }
                          },
                        ),
                        5.height,
                        customButton(
                          context,
                          'SIGN UP',
                          AppColors.lighterBlue,
                          Colors.black,
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
                        5.height,
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
                      "Before Registration Check status",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    20.height,
                    TextInputField(
                      no: "1",
                      controller: empCodeController,
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Allows only digits
                        LengthLimitingTextInputFormatter(17),
                      ],
                      title: "Employee Code",
                      hintText: 'Fill details',
                    ),
                    10.height,
                    TextInputField(
                      no: "2",
                      controller: contactController,
                      title: "Contact",
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Allows only digits
                        LengthLimitingTextInputFormatter(10),
                      ],
                      inputType: TextInputType.phone,
                      hintText: 'Fill Contact Nu.',
                    ),
                    20.height,
                    Obx(
                      () => employeeController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : CommonButton(
                              text: "Check status",
                              onPressed: employeeController.isLoading.value
                                  ? null
                                  : () async {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        if (empCodeController.text.isNotEmpty &&
                                            contactController.text.isNotEmpty) {
                                          employeeController.isLoading.value =
                                              true;
                                          await employeeController
                                              .fetchEmployeeData(
                                            empCodeController.text.trim(),
                                            contactController.text.trim(),
                                          );
                                          employeeController.isLoading.value =
                                              false;
                                        } else {
                                          CustomSnackbarError.showSnackbar(
                                            title: "Error",
                                            message:
                                                'Please fill in all fields',
                                          );
                                        }
                                      }
                                    },
                            ),
                    ),
                    40.height,
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
