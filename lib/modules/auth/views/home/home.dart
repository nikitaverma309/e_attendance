import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/text_size_const.dart';
import 'package:online/modules/auth/controllers/profile_controller.dart';
import 'package:online/controllers/user_Register_form_controller.dart';
import 'package:online/enum/enum_screen.dart';
import 'package:online/modules/restriction_dialog/restrict_user_dialog.dart';
import 'package:online/modules/screens/camera/check_emp_id_screen.dart';
import 'package:online/modules/auth/views/login_page.dart';
import 'package:online/utils/utils.dart';
import 'package:online/widgets/app_button.dart';
import 'package:online/widgets/common/custom_widgets.dart';
import 'package:online/widgets/common/form_input_widgets.dart';
import 'package:online/widgets/logo_widgets.dart';

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

  final ProfileController profileController = Get.put(ProfileController());

  final UserRegistrationFormController userRegistrationFormController =
      Get.put(UserRegistrationFormController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff176daa),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Expanded(
                        child: Text(
                            "App Version: 1.0,\nApp Release Date: 03/12/2024.",
                            style: kText11BoldWhiteColor),
                      ),
                      DropdownButton<String>(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        dropdownColor: Colors.white,
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(
                            value: 'page1',
                            child: Text('Employee Registration Form',
                                style: kText10BlueBlackColorStyle),
                          ),
                          DropdownMenuItem(
                            value: 'page2',
                            child: Text('Profile',
                                style: kText10BlueBlackColorStyle),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == 'page1') {
                            _showEmpRegistrationBottomSheet(context);
                          } else if (value == 'page2') {
                            _profileDialog(context);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            30.height,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomLogoWidget(),
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
                      Get.to(() => const FaceAttendanceScreen(
                            action: CameraAction.login,
                          ));
                    }
                  },
                ),
                10.height,
                customButton(
                  context,
                  'Login',
                  const Color(0xFFCEEEEE),
                  Colors.black,
                  Icons.perm_contact_calendar_outlined,
                  () {
                    // _profileDialog(context);
                    Get.to(() => LoginPage());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => const FaceAttendanceScreen(
                action: CameraAction.registration,
              ));
        },
        icon: const Icon(Icons.person_add),
        label: const Text('Face Register'),
        backgroundColor: const Color(0xFFD7DEEE),
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
                      () => userRegistrationFormController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : CommonButton(
                              text: "Check status",
                              onPressed: userRegistrationFormController
                                      .isLoading.value
                                  ? null
                                  : () async {
                                      print("jij");
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        if (empCodeController.text.isNotEmpty &&
                                            contactController.text.isNotEmpty) {
                                          userRegistrationFormController
                                              .isLoading.value = true;
                                          await userRegistrationFormController
                                              .getUserRegisterData(
                                            empCodeController.text.trim(),
                                            contactController.text.trim(),
                                          );
                                          userRegistrationFormController
                                              .isLoading.value = false;
                                        } else {
                                          CustomSnackbarError.showSnackbar(
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

  void _profileDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Stack(
          children: [
            Form(
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
                    50.height,
                    const Text(
                      "Enter Your Employee Code",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    20.height,
                    TextInputField(
                      controller: empCodeController,
                      inputType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      title: "Employee Code",
                      hintText: 'Fill details',
                    ),
                    20.height,
                    Obx(
                      () => profileController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : CommonButton(
                              text: "Verify",
                              onPressed: () async {
                                if (empCodeController.text.isEmpty) {
                                  // Show an error message or highlight the input field
                                  Utils.showErrorToast(
                                      message:
                                          "Please enter the employee code.");
                                  return; // Don't proceed if the input is empty
                                }

                                profileController.isLoading.value = true;
                                await profileController
                                    .getProfile(empCodeController.text);
                                profileController.isLoading.value = false;
                                empCodeController.clear();
                              },
                            ),
                    ),
                    30.height,
                  ],
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
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