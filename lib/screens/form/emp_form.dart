import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/controllers/check_status_employee_controller.dart';
import 'package:online/controllers/emp_controller.dart';
import 'package:online/models/check_emp_status_model.dart';
import 'package:online/models/class_model.dart';
import 'package:online/models/college_model.dart';
import 'package:online/models/designation_model.dart';
import 'package:online/models/district_model.dart';
import 'package:online/models/division_model.dart';
import 'package:online/models/vidhan_sabha_model.dart';
import 'package:online/utils/utils.dart';
import 'package:online/widgets/app_button.dart';
import 'package:online/widgets/common/app_bar_widgets.dart';
import 'package:online/widgets/common/custom_widgets.dart';
import 'package:online/widgets/common/form_input_widgets.dart';
import 'package:online/widgets/common/rich_title_value_list.dart';

class EmployeeRegistrationForm extends StatefulWidget {
  final GetEmployeeCode employeeData;
  const EmployeeRegistrationForm({
    super.key,
    required this.employeeData,
  });

  @override
  State<EmployeeRegistrationForm> createState() =>
      _EmployeeRegistrationFormState();
}

class _EmployeeRegistrationFormState extends State<EmployeeRegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final EmpController empController = Get.put(EmpController());
  final CheckStatusEmployeeController empCheckController =
      Get.put(CheckStatusEmployeeController());

  late TextEditingController empCodeCtr;
  late TextEditingController nameCtr;

  late TextEditingController mobCtr;

  @override
  void initState() {
    super.initState();

    // Initialize controllers in initState with data from widget.employeeData
    empCodeCtr = TextEditingController(text: widget.employeeData.empCode);
    nameCtr = TextEditingController(text: widget.employeeData.name);
    mobCtr =
        TextEditingController(text: widget.employeeData.contact.toString());
  }

  @override
  void dispose() {
    // Dispose of controllers when not in use
    empCodeCtr.dispose();
    nameCtr.dispose();
    emailCtr.dispose();
    mobCtr.dispose();
    addressCtr.dispose();
    super.dispose();
  }

  TextEditingController emailCtr = TextEditingController();

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
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.height,
                TextInputField(
                  no: "1",
                  controller: nameCtr,
                  title: "Name",
                  hintText: 'Enter Your Name',
                  enabled: nameCtr.text.isEmpty,
                ),
                10.height,
                TextInputField(
                  no: "2",
                  controller: empCodeCtr,
                  title: "Employee Code",
                  hintText: 'Fill details',
                  enabled: empCodeCtr.text.isEmpty,
                ),
                10.height,
                TextInputField(
                  no: "3",
                  controller: emailCtr,
                  title: "Email",
                  validator: (value) {
                    return Utils.validateEmail(value); // No error
                  },
                  hintText: 'Fill details',
                ),
                10.height,
                TextInputField(
                  no: "4",
                  controller: mobCtr,
                  enabled: mobCtr.text.isEmpty,
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
                10.height,
                const TitleValueTextFormData(
                  title: '3',
                  subTitle: "Select Division",
                ),
                10.height,
                Obx(() {
                  if (empController.divisions.isEmpty) {
                    return DropDownSelectionMessage(
                      message: 'Please Select Division',
                    );
                  }

                  return CustomDropdown<DivisionModel>(
                    items: empController.divisions, // Pass VidhanModel list
                    selectedValue: empController.selectedDivision.value.isEmpty
                        ? null
                        : empController.divisions.firstWhere((vs) =>
                            vs.divisionCode.toString() ==
                            empController.selectedDivision.value),
                    hint: 'Select Division  ',
                    idKey: 'divisionCode',
                    displayKey: 'name', // Display the 'ConstituencyName'
                    onChanged: (DivisionModel? newVidhan) {
                      if (newVidhan != null) {
                        empController
                            .selectDivision(newVidhan.divisionCode.toString());
                        empController.fetchDistrictsByDivision(
                            int.parse(newVidhan.divisionCode.toString()));
                        print('Selected division Name: ${newVidhan.name}');
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
                    return DropDownSelectionMessage(
                      message: 'Please Select District',
                    );
                  }

                  return CustomDropdown<DistrictModel>(
                    items: empController
                        .districts, // Pass DistrictModel list directly
                    selectedValue: empController.selectedDistrict.value.isEmpty
                        ? null
                        : empController.districts.firstWhere(
                            (vs) =>
                                vs.lgdCode.toString() ==
                                empController.selectedDistrict.value,
                          ),
                    hint: 'Select districtName',
                    idKey: 'LGDCode',
                    displayKey:
                        'districtName', // Display name to show in dropdown
                    onChanged: (DistrictModel? newDistrict) {
                      if (newDistrict != null) {
                        empController
                            .selectDistrict(newDistrict.lgdCode.toString());
                        empController.getVidhanSabhaByDivision(
                            int.parse(newDistrict.lgdCode.toString()));
                        print(
                            'Selected districtName: ${newDistrict.districtName}');
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
                    return DropDownSelectionMessage(
                      message: 'Please Select Vidhan Sabha',
                    );
                  }

                  return CustomDropdown<VidhanModel>(
                    items: empController.vidhanSabha,
                    selectedValue:
                        empController.selectedVidhanSabha.value.isEmpty
                            ? null
                            : empController.vidhanSabha.firstWhere((vs) =>
                                vs.constituencyNumber.toString() ==
                                empController.selectedVidhanSabha.value),
                    hint: 'Select Vidhan Sabha',
                    idKey: 'ConstituencyNumber',
                    displayKey:
                        'ConstituencyName', // Display the 'ConstituencyName'
                    onChanged: (VidhanModel? newVidhan) {
                      if (newVidhan != null) {
                        empController.selectVidhanSabha(
                            newVidhan.constituencyNumber.toString());
                        print(
                            'Selected Vidhan Sabha Name: ${newVidhan.constituencyName}');
                      }
                    },
                  );
                }),
                10.height,
                const TitleValueTextFormData(
                  title: '8',
                  subTitle: "Select College",
                ),
                10.height,
                Obx(() {
                  if (empController.college.isEmpty) {
                    return DropDownSelectionMessage(
                      message: 'Please Select college',
                    );
                  }
                  return CustomDropdown<CollegeModel>(
                    items: empController.college,
                    selectedValue: empController.selectedCollege.value.isEmpty
                        ? null
                        : empController.college.firstWhere(
                            (college) =>
                                college.id ==
                                empController.selectedCollege.value,
                          ),
                    hint: 'Select College',
                    onChanged: (CollegeModel? newCollege) {
                      if (newCollege != null) {
                        empController.selectCollege(newCollege.id);
                      }
                    },
                    idKey:
                        'id', // No need for idKey as we directly access CollegeModel fields
                    displayKey: 'name', // Display the name of the college
                  );
                }),
                10.height,
                const TitleValueTextFormData(
                  title: '9',
                  subTitle: "Select Class",
                ),
                Obx(() {
                  if (empController.classList.isEmpty) {
                    return DropDownSelectionMessage(
                      message: 'Please Select Class',
                    );
                  }

                  return CustomDropdown<ClassModel>(
                    items: empController.classList, // Pass VidhanModel list
                    selectedValue: empController.selectedClass.value.isEmpty
                        ? null
                        : empController.classList.firstWhere(
                            (vs) => vs.id == empController.selectedClass.value),
                    hint: 'Select Class  ',
                    idKey: '_id',
                    displayKey: 'className', // Display the 'ConstituencyName'
                    onChanged: (ClassModel? newValue) {
                      if (newValue != null) {
                        empController.selectClass(newValue.id);
                        empController.fetchClassByDesignation(newValue.id);
                      }
                    },
                  );
                }),
                10.height,
                const TitleValueTextFormData(
                  title: '10',
                  subTitle: "Select Designation",
                ),
                Obx(() {
                  if (empController.designationList.isEmpty) {
                    return DropDownSelectionMessage(
                      message: 'Please Select DesignationList',
                    );
                  }
                  return CustomDropdown<DesignationModel>(
                    items: empController.designationList,
                    selectedValue:
                        empController.selectedDesignation.value.isEmpty
                            ? null
                            : empController.designationList.firstWhere(
                                (college) =>
                                    college.id ==
                                    empController.selectedDesignation.value,
                              ),
                    hint: 'Select DesignationList',
                    onChanged: (DesignationModel? newCass) {
                      if (newCass != null) {
                        empController.selectDesignation(newCass.id);
                      }
                    },
                    idKey: '_id',
                    displayKey: 'designation',
                  );
                }),
                10.height,
                TextInputField(
                  no: "11",
                  controller: addressCtr,
                  title: "Address",
                  hintText: 'Fill details',
                ),
                30.height,
                Center(
                  child: CommonButton(
                    text: "Register Now",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
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
                        String college =
                            empController.selectedCollege.value.isNotEmpty
                                ? empController.selectedCollege.value
                                : "Default College";

                        String address = addressCtr.text.isNotEmpty
                            ? addressCtr.text
                            : "Default Address";

                        // Calling the addEmployee method in your controller to pass data
                        empController.addEmployee(
                          name: name,
                          empCode: empCode,
                          email: email,
                          contact: contact,
                          division: division,
                          district: district,
                          vidhanSabha: vidhanSabha,
                          college: college,
                          designation: empController.selectedDesignation.value,
                          classData: empController.selectedClass.value,
                          address: address,
                        );
                      }
                    },
                    icon: const Icon(Icons.logout, color: Colors.white),
                    color: AppColors.bbAppColor1,
                  ),
                ),
                40.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
