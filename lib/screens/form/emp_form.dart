
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/controllers/emp_controller.dart';
import 'package:online/widgets/app_button.dart';
import 'package:online/widgets/common/app_bar_widgets.dart';
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
  final EmpController empController = Get.put(EmpController());
  TextEditingController empCodeCtr = TextEditingController();
  TextEditingController nameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController mobCtr = TextEditingController();
  TextEditingController divisionCtr = TextEditingController();
  TextEditingController districtCtr = TextEditingController();
  TextEditingController selectCollegeCtr = TextEditingController();
  TextEditingController designationCtr = TextEditingController();
  TextEditingController selectClassCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();

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
                  validator: (value) => value!.isEmpty ? "Required" : null,
                  hintText: 'Fill details',
                ),
                10.height,
                TextInputField(
                  no: "2",
                  controller: nameCtr,
                  title: "Name",
                  validator: (value) => value!.isEmpty ? "Required" : null,
                  hintText: 'Fill details',
                ),
                10.height,
                TextInputField(
                  no: "3",
                  controller: emailCtr,
                  title: "Email",
                  validator: (value) => value!.isEmpty ? "Required" : null,
                  hintText: 'Fill details',
                ),
                10.height,
                TextInputField(
                  no: "4",
                  controller: mobCtr,
                  title: "Contact",
                  validator: (value) => value!.isEmpty ? "Required" : null,
                  hintText: 'Fill details',
                ),
                10.height,
                const TitleValueTextFormData(
                  title: '3',
                  subTitle: "Select Division",
                ),
                10.height,
                Obx(() {
                  if (empController.divisions.isEmpty) {
                    return const CircularProgressIndicator();
                  }
                  return DropdownButton<String>(
                    value: empController.selectedDivision.value.isEmpty
                        ? null
                        : empController.selectedDivision.value,
                    hint: const Text('Select Division'),
                    items: empController.divisions
                        .map<DropdownMenuItem<String>>((division) {
                      return DropdownMenuItem<String>(
                        value: division['divisionCode'].toString(),
                        child: Text(division['name']),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        empController.selectDivision(newValue);
                        empController
                            .fetchDistrictsByDivision(int.parse(newValue));
                        print(
                            'Selected Division Name: ${empController.divisions.firstWhere((div) => div['divisionCode'].toString() == newValue)['name']}');
                      }
                    },
                  );
                }),
                10.height,
                const TitleValueTextFormData(
                  title: '6',
                  subTitle: "Select District",
                ),
                Obx(() {
                  if (empController.districts.isEmpty) {
                    return const Text(
                        'Please select a division to see districts.');
                  }
                  return DropdownButton<String>(
                    value: empController.selectedDistrict.value.isEmpty
                        ? null
                        : empController.selectedDistrict.value,
                    hint: const Text('Select District'),
                    items: empController.districts
                        .map<DropdownMenuItem<String>>((district) {
                      return DropdownMenuItem<String>(
                        value: district['LGDCode'].toString(),
                        child: Text(district['districtName']),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        empController.selectDistrict(newValue);
                        empController
                            .getVidhanSabhaByDivision(int.parse(newValue));
                        print(
                            'Selected District Name: ${empController.districts.firstWhere((dist) => dist['LGDCode'].toString() == newValue)['districtName']}');
                      }
                    },
                  );
                }),
                10.height,
                const TitleValueTextFormData(
                  title: '7',
                  subTitle: "Select Vidhan Sabha",
                ),
                10.height,
                Obx(() {
                  if (empController.vidhanSabha.isEmpty) {
                    return const Text(
                        'Please select a district to see vidhanSabha.');
                  }
                  return DropdownButton<String>(
                    value: empController.selectedVidhanSabha.value.isEmpty
                        ? null
                        : empController.selectedVidhanSabha.value,
                    hint: const Text('Select Vidhan Sabha'),
                    items: empController.vidhanSabha
                        .map<DropdownMenuItem<String>>((vidhanSabha) {
                      return DropdownMenuItem<String>(
                        value: vidhanSabha['ConstituencyNumber'].toString(),
                        child: Text(vidhanSabha['ConstituencyName']),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        empController.selectVidhanSabha(newValue);
                        print(
                            'Selected Vidhan Sabha Name: ${empController.vidhanSabha.firstWhere((vs) => vs['ConstituencyNumber'].toString() == newValue)['ConstituencyName']}');
                      }
                    },
                  );
                }),
                10.height,
                TextInputField(
                  no: "8",
                  controller: selectCollegeCtr,
                  title: "Select College",
                  validator: (value) => value!.isEmpty ? "Required" : null,
                  hintText: 'Fill details',
                ),
                10.height,
                TextInputField(
                  no: "9",
                  controller: designationCtr,
                  title: "Designation",
                  validator: (value) => value!.isEmpty ? "Required" : null,
                  hintText: 'Fill details',
                ),
                10.height,
                TextInputField(
                  no: "10",
                  controller: selectClassCtr,
                  title: "Select Class",
                  validator: (value) => value!.isEmpty ? "Required" : null,
                  hintText: 'Fill details',
                ),
                10.height,
                TextInputField(
                  no: "11",
                  controller: addressCtr,
                  title: "Address",
                  validator: (value) => value!.isEmpty ? "Required" : null,
                  hintText: 'Fill details',
                ),
                CommonButton(
                  text: "Register",
                  onPressed: () {
                    if (_bagiKey.currentState!.validate()) {
                      // Setting default values if fields are empty
                      String name = nameCtr.text.isNotEmpty
                          ? nameCtr.text
                          : "Default Name";
                      String empCode = empCodeCtr.text.isNotEmpty
                          ? empCodeCtr.text
                          : "Default Code";
                      String email = emailCtr.text.isNotEmpty
                          ? emailCtr.text
                          : "default@example.com";
                      String contact =
                          mobCtr.text.isNotEmpty ? mobCtr.text : "0000000000";
                      String division =
                          empController.selectedDivision.value.isNotEmpty
                              ? empController.selectedDivision.value
                              : "1";
                      String district =
                          empController.selectedDistrict.value.isNotEmpty
                              ? empController.selectedDistrict.value
                              : "1";
                      String vidhanSabha =
                          empController.selectedVidhanSabha.value.isNotEmpty
                              ? empController.selectedVidhanSabha.value
                              : "1";
                      String college = selectCollegeCtr.text.isNotEmpty
                          ? selectCollegeCtr.text
                          : "Default College";
                      String designation = designationCtr.text.isNotEmpty
                          ? designationCtr.text
                          : "Default Designation";
                      String classData = selectClassCtr.text.isNotEmpty
                          ? selectClassCtr.text
                          : "1";
                      String address = addressCtr.text.isNotEmpty
                          ? addressCtr.text
                          : "Default Address";

                      empController.addEmployee(
                        name: name,
                        empCode: empCode,
                        email: email,
                        contact: contact,
                        division: division,
                        district: district,
                        vidhanSabha: vidhanSabha,
                        college: college,
                        designation: designation,
                        classData: classData,
                        address: address,
                      );
                    }
                  },
                  icon: const Icon(Icons.logout, color: Colors.white),
                  color: AppColors.bbAccentColor,
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
