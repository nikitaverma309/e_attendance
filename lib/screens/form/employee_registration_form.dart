import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/constants/string_res.dart';
import 'package:online/controllers/division_controller.dart';
import 'package:online/controllers/employee_registration_controller.dart';
import 'package:online/models/division_model.dart';
import 'package:online/modules/home/home.dart';
import 'package:online/widgets/app_button.dart';
import 'package:online/widgets/common/app_bar_widgets.dart';
import 'package:online/widgets/common/custom_widgets.dart';
import 'package:online/widgets/common/form_input_widgets.dart';
import 'package:online/widgets/common/rich_title_value_list.dart';

class EmployeeRegistrationForm extends StatefulWidget {
  const EmployeeRegistrationForm({
    super.key,
  });

  @override
  State<EmployeeRegistrationForm> createState() =>
      _EmployeeRegistrationFormState();
}

class _EmployeeRegistrationFormState extends State<EmployeeRegistrationForm> {
  final GlobalKey<FormState> _bagiKey = GlobalKey<FormState>();
  final DivisionController controller = Get.put(DivisionController());
  final EmployeeRegistrationController empController =
      Get.put(EmployeeRegistrationController());
  TextEditingController empCodeCtr = TextEditingController();
  TextEditingController nameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController mobCtr = TextEditingController();
  TextEditingController divisionCtr = TextEditingController();
  TextEditingController districtCtr = TextEditingController();
  TextEditingController vidhanSabhaCtr = TextEditingController();
  TextEditingController selectCollegeCtr = TextEditingController();
  TextEditingController designationCtr = TextEditingController();
  TextEditingController selectClassCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();
  final FocusNode _focusNodeWorkBName = FocusNode();
  final FocusNode _focusNodeRashi = FocusNode();
  final FocusNode _focusNodeTotal = FocusNode();
  final FocusNode _focusNodeFixed = FocusNode();
  String? selectedCollege;


  @override
  void dispose() {
    _focusNodeWorkBName.dispose();
    _focusNodeRashi.dispose();
    _focusNodeTotal.dispose();
    _focusNodeFixed.dispose();
    super.dispose();
  }

  File? picFile;
  File? jalFile;
  File? hitFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xF5ECF4F5),
      appBar: const CustomAppBar(
        title: "Employee Registration Form",
        showBackButton: true,
      ),
      body: Form(
        key: _bagiKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.height,
                TextInputField(
                  no: "1",
                  controller: empCodeCtr,
                  title: "Employee Code",
                  focusNode: _focusNodeWorkBName,
                  validator: (value) => value!.isEmpty ? "Required" : null,
                  hintText: 'Fill details',
                ),
                10.height,
                TextInputField(
                  no: "2",
                  controller: nameCtr,
                  title: "Name",
                  focusNode: _focusNodeWorkBName,
                  validator: (value) => value!.isEmpty ? "Required" : null,
                  hintText: 'Fill details',
                ),
                10.height,
                TextInputField(
                  no: "3",
                  controller: emailCtr,
                  title: "Email",
                  focusNode: _focusNodeWorkBName,
                  validator: (value) => value!.isEmpty ? "Required" : null,
                  hintText: 'Fill details',
                ),
                10.height,
                TextInputField(
                  no: "4",
                  controller: mobCtr,
                  title: "Contact",
                  focusNode: _focusNodeWorkBName,
                  validator: (value) => value!.isEmpty ? "Required" : null,
                  hintText: 'Fill details',
                ),
                10.height,
                const TitleValueTextFormData(
                  title: '3',
                  subTitle: "Select Division",
                ),
                10.height,
                // Wrap the CustomDropdown with Obx to make it reactive
                Obx(() {
                  return CustomDropdown<Division>(
                    items: controller.divisions,
                    selectedValue: controller.divisions.firstWhereOrNull(
                          (division) => division.divisionCode == controller.selectedDivisionCode.value,
                    ),
                    onChanged: (Division? newDivision) {
                      if (newDivision != null) {
                        controller.selectedDivisionCode.value = newDivision.divisionCode!;
                      }
                    },
                    hint: "Choose a Division",
                  );
                }),
                10.height,
                const TitleValueTextFormData(
                  title: '7',
                  subTitle: "Select District",
                ),
                Obx(() {
                  return CustomDropdown<Division>(
                    items: controller.divisions,
                    selectedValue: controller.divisions.firstWhereOrNull(
                          (division) => division.divisionCode == controller.selectedDivisionCode.value,
                    ),
                    onChanged: (Division? newDivision) {
                      if (newDivision != null) {
                        controller.selectedDivisionCode.value = newDivision.divisionCode!;
                      }
                    },
                    hint: "Choose a Division",
                  );
                }),
                10.height,
                const TitleValueTextFormData(
                  title: '8',
                  subTitle: "Select Vidhan Sabha",
                ),
                10.height,
                Obx(() {
                  return CustomDropdown<Division>(
                    items: controller.divisions,
                    selectedValue: controller.divisions.firstWhereOrNull(
                          (division) => division.divisionCode == controller.selectedDivisionCode.value,
                    ),
                    onChanged: (Division? newDivision) {
                      if (newDivision != null) {
                        controller.selectedDivisionCode.value = newDivision.divisionCode!;
                      }
                    },
                    hint: "Choose a Division",
                  );
                }),
                10.height,
                const TitleValueTextFormData(
                  title: '10',
                  subTitle: "Select College",
                ),
                Obx(() {
                  return CustomDropdown<Division>(
                    items: controller.divisions,
                    selectedValue: controller.divisions.firstWhereOrNull(
                          (division) => division.divisionCode == controller.selectedDivisionCode.value,
                    ),
                    onChanged: (Division? newDivision) {
                      if (newDivision != null) {
                        controller.selectedDivisionCode.value = newDivision.divisionCode!;
                      }
                    },
                    hint: "Choose a Division",
                  );
                }),
                10.height,
                TextInputField(
                  no: "4",
                  controller: designationCtr,
                  title: "Designation",
                  focusNode: _focusNodeWorkBName,
                  validator: (value) => value!.isEmpty ? "Required" : null,
                  hintText: 'Fill details',
                ),
                10.height,
                const TitleValueTextFormData(
                  title: '10',
                  subTitle: "Select Class",
                ),
                Obx(() {
                  return CustomDropdown<Division>(
                    items: controller.divisions,
                    selectedValue: controller.divisions.firstWhereOrNull(
                          (division) => division.divisionCode == controller.selectedDivisionCode.value,
                    ),
                    onChanged: (Division? newDivision) {
                      if (newDivision != null) {
                        controller.selectedDivisionCode.value = newDivision.divisionCode!;
                      }
                    },
                    hint: "Choose a Division",
                  );
                }),
                10.height,
                TextInputField(
                  no: "4",
                  controller: addressCtr,
                  title: "Address",
                  focusNode: _focusNodeWorkBName,
                  validator: (value) => value!.isEmpty ? "Required" : null,
                  hintText: 'Fill details',
                ),
                Center(
                  child: CommonButton(
                    text: "Register",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    color: AppColors.bbAccentColor,
                  ),
                ),
                10.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
