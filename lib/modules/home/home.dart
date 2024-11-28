import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/controllers/check_status_Register_emp_controller.dart';
import 'package:online/controllers/profile_ctr/profile_controller.dart';
import 'package:online/generated/assets.dart';
import 'package:online/modules/home/attendance_id_screen.dart';
import 'package:online/modules/home/registration_id_screen.dart';
import 'package:online/screens/comman_screen/faq_screen.dart';
import 'package:online/widgets/app_button.dart';
import 'package:online/widgets/common/custom_widgets.dart';
import 'package:online/widgets/common/form_input_widgets.dart';
import 'package:online/widgets/footer_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = false;

  final TextEditingController empCodeController = TextEditingController();
  final TextEditingController empCodeProController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final CheckStatusController profileController =
      Get.put(CheckStatusController());
  final CheckStatusRegistrationEmployeeController employeeController =
      Get.put(CheckStatusRegistrationEmployeeController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff176daa),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // const Expanded(
                        //   child: Text("Welcome To face Attendance",
                        //       style: kText15whiteColorStyle),
                        // ),
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
                                  builder: (context) => FaqScreen(),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
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
                  10.height,
                  const Text("Higher Education Department",
                      style: kText15BaNaBoldWhiteColorStyle),
                  const Text("Government Of Chhattisgarh",
                      style: kText15BaNaBoldWhiteColorStyle),
                  58.height,
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: const Image(
                        image: AssetImage('assets/logo.png'),
                        height: 48,
                        width: 48,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  15.height,
                  const Text("Welcome To face Attendance System",
                      style: kText13BoldWhiteColor),
                  21.height,
                  customButton(
                    context,
                    'Face Attendance',
                    const Color(0xFFCEEEEE),
                    Colors.black,
                    Icons.login,
                    () {
                      if (mounted) {
                        Get.to(() => const FaceAttendanceScreen());
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => const RegisterFaceAttendanceScreen());
          },
          icon: const Icon(Icons.person_add),
          label: const Text('Register'),
          backgroundColor: const Color(0xFFD7DEEE),
        ),
        // bottomSheet: FooterWidget(),
      ),
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
                      inputType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Allows only digits
                        LengthLimitingTextInputFormatter(11),
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
                                              .checkRegisterEmployeeData(
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

  void _profileBottomSheet(BuildContext context) {
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
                    40.height,
                    const Text(
                      "Before Open Your Profile Check status",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    20.height,
                    TextInputField(
                      no: "1",
                      controller: empCodeProController,
                      inputType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Allows only digits
                        LengthLimitingTextInputFormatter(11),
                      ],
                      title: "Employee Code",
                      hintText: 'Fill details',
                    ),
                    20.height,
                    // Obx(
                    //   () => profileController.isLoading.value
                    //       ? const Center(
                    //           child:
                    //               CircularProgressIndicator()) // Show loading spinner
                    //       : CommonButton(
                    //           text: "Profile Page",
                    //           onPressed: employeeController.isLoading.value
                    //               ? null // Disable the button if loading
                    //               : () async {
                    //                   // Check if the email field is empty
                    //                   if (empCodeProController.text.isEmpty) {
                    //                     // Show an error if Attendance ID is not entered
                    //                     Get.defaultDialog(
                    //                       title: "Error",
                    //                       middleText:
                    //                           "Please enter your Attendance ID before proceeding.",
                    //                       textConfirm: "OK",
                    //                       onConfirm: () => Get.back(),
                    //                     );
                    //                     return;
                    //                   }
                    //
                    //                   // Show loading state
                    //                   profileController.isLoading.value = true;
                    //
                    //                   // Call the API to fetch profile data
                    //                   await profileController.getCheckStatus(
                    //                       empCodeProController.text);
                    //
                    //                   profileController.isLoading.value = false;
                    //
                    //                   // Handle API response
                    //                   if (profileController
                    //                           .employeeData.value !=
                    //                       null) {
                    //                     Get.to(
                    //                       () => ProfileScreen(
                    //                         data: profileController
                    //                             .employeeData.value,
                    //                       ),
                    //                     );
                    //                     Get.defaultDialog(
                    //                       title: "Success",
                    //                       middleText:
                    //                           "Employee data fetched successfully.",
                    //                       textConfirm: "OK",
                    //                       onConfirm: () => Navigator.push(
                    //                         context,
                    //                         MaterialPageRoute(
                    //                           builder: (context) =>
                    //                               ProfileScreen(
                    //                             data: profileController
                    //                                 .employeeData.value,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     );
                    //                   } else {
                    //                     // Show error dialog if data is null
                    //                     Get.defaultDialog(
                    //                       title: "Error",
                    //                       middleText:
                    //                           "Your Attendance ID was incorrect. Please try again.",
                    //                       textConfirm: "OK",
                    //                       onConfirm: () {
                    //                         // Close the dialog and navigate back to the previous screen
                    //                         Get.back();
                    //
                    //                         // Clear the controller value if the ID is incorrect
                    //                         empCodeProController.clear();
                    //                       },
                    //                     );
                    //                   }
                    //                 },
                    //         ),
                    // ),
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
