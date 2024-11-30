import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/colors_res.dart';
import 'package:online/controllers/user_Register_form_controller.dart';
import 'package:online/controllers/dropdown_controller.dart';
import 'package:online/models/check_status_user_register_model.dart';
import 'package:online/models/droupDown/class_model.dart';
import 'package:online/models/droupDown/college_model.dart';
import 'package:online/models/droupDown/designation_model.dart';
import 'package:online/models/droupDown/district_model.dart';
import 'package:online/models/droupDown/division_model.dart';
import 'package:online/models/droupDown/vidhan_sabha_model.dart';
import 'package:online/utils/utils.dart';
import 'package:online/widgets/app_button.dart';
import 'package:online/widgets/common/app_bar_widgets.dart';
import 'package:online/widgets/common/custom_widgets.dart';
import 'package:online/widgets/common/form_input_widgets.dart';
import 'package:online/widgets/common/rich_title_value_list.dart';

class EmployeeRegistrationForm extends StatefulWidget {
  final GetEmployeeDetails? employeeData;
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
  final DropDownController dropDownController = Get.put(DropDownController());

  final UserRegistrationFormController userRegistrationFormController =
      Get.put(UserRegistrationFormController());
  late TextEditingController empCodeCtr;
  late TextEditingController nameCtr;

  late TextEditingController mobCtr;

  @override
  void initState() {
    super.initState();

    empCodeCtr = TextEditingController(text: widget.employeeData!.empCode!);
    nameCtr = TextEditingController(text: widget.employeeData!.name);
    mobCtr =
        TextEditingController(text: widget.employeeData!.contact.toString());
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
  TextEditingController workTypeCtr = TextEditingController();

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
                    LengthLimitingTextInputFormatter(10),
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
                  if (dropDownController.divisions.isEmpty) {
                    return const DropDownSelectionMessage(
                      message: 'Please Select Division',
                    );
                  }

                  return CustomDropdown<DivisionModel>(
                    items: dropDownController.divisions,
                    selectedValue:
                        dropDownController.selectedDivision.value.isEmpty
                            ? null
                            : dropDownController.divisions.firstWhere((vs) =>
                                vs.divisionCode.toString() ==
                                dropDownController.selectedDivision.value),
                    hint: 'Select Division  ',
                    idKey: 'divisionCode',
                    displayKey: 'name', // Display the 'ConstituencyName'
                    onChanged: (DivisionModel? Value) {
                      if (Value != null) {
                        dropDownController
                            .selectDivision(Value.divisionCode.toString());
                        dropDownController.fetchDistrictsByDivision(
                            int.parse(Value.divisionCode.toString()));
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
                  if (dropDownController.districts.isEmpty) {
                    return const DropDownSelectionMessage(
                      message: 'Please Select District',
                    );
                  }

                  return CustomDropdown<DistrictModel>(
                    items: dropDownController.districts,
                    selectedValue:
                        dropDownController.selectedDistrict.value.isEmpty
                            ? null
                            : dropDownController.districts.firstWhere(
                                (vs) =>
                                    vs.lgdCode.toString() ==
                                    dropDownController.selectedDistrict.value,
                              ),
                    hint: 'Select districtName',
                    idKey: 'LGDCode',
                    displayKey:
                        'districtName', // Display name to show in dropdown
                    onChanged: (DistrictModel? newDistrict) {
                      if (newDistrict != null) {
                        dropDownController
                            .selectDistrict(newDistrict.lgdCode.toString());
                        dropDownController.getVidhanSabhaByDivision(
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
                  if (dropDownController.vidhanSabha.isEmpty) {
                    return const DropDownSelectionMessage(
                      message: 'Please Select Vidhan Sabha',
                    );
                  }

                  return CustomDropdown<VidhanModel>(
                    items: dropDownController.vidhanSabha,
                    selectedValue:
                        dropDownController.selectedVidhanSabha.value.isEmpty
                            ? null
                            : dropDownController.vidhanSabha.firstWhere((vs) =>
                                vs.constituencyNumber.toString() ==
                                dropDownController.selectedVidhanSabha.value),
                    hint: 'Select Vidhan Sabha',
                    idKey: 'ConstituencyNumber',
                    displayKey:
                        'ConstituencyName', // Display the 'ConstituencyName'
                    onChanged: (VidhanModel? newVidhan) {
                      if (newVidhan != null) {
                        dropDownController.selectVidhanSabha(
                            newVidhan.constituencyNumber.toString());
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
                  if (dropDownController.college.isEmpty) {
                    return const DropDownSelectionMessage(
                      message: 'Please Select college',
                    );
                  }
                  return CustomDropdown<CollegeModel>(
                    items: dropDownController.college,
                    selectedValue:
                        dropDownController.selectedCollege.value.isEmpty
                            ? null
                            : dropDownController.college.firstWhere(
                                (college) =>
                                    college.id ==
                                    dropDownController.selectedCollege.value,
                              ),
                    hint: 'Select College',
                    onChanged: (CollegeModel? newCollege) {
                      if (newCollege != null) {
                        dropDownController.selectCollege(newCollege.id);
                      }
                    },
                    idKey: 'id',
                    displayKey: 'name',
                  );
                }),
                10.height,
                const TitleValueTextFormData(
                  title: '9',
                  subTitle: "Select Class",
                ),
                Obx(() {
                  if (dropDownController.classList.isEmpty) {
                    return const DropDownSelectionMessage(
                      message: 'Please Select class',
                    );
                  }
                  return CustomDropdown<ClassModel>(
                    items: dropDownController.classList,
                    selectedValue:
                        dropDownController.selectedClass.value.isEmpty
                            ? null
                            : dropDownController.classList.firstWhere(
                                (college) =>
                                    college.id ==
                                    dropDownController.selectedClass.value,
                              ),
                    hint: 'Select Class',
                    onChanged: (ClassModel? newCass) {
                      if (newCass != null) {
                        dropDownController.selectClass(newCass.id!);
                        dropDownController.fetchClassByDesignation(newCass.id!);
                      }
                    },
                    idKey: '_id',
                    displayKey: 'className',
                  );
                }),
                10.height,
                const TitleValueTextFormData(
                  title: '10',
                  subTitle: "Select Designation",
                ),
                Obx(() {
                  if (dropDownController.designationList.isEmpty) {
                    return const DropDownSelectionMessage(
                      message: 'Please Select DesignationList',
                    );
                  }
                  return CustomDropdown<DesignationModel>(
                    items: dropDownController.designationList,
                    selectedValue:
                        dropDownController.selDesignation.value.isEmpty
                            ? null
                            : dropDownController.designationList.firstWhere(
                                (college) =>
                                    college.id ==
                                    dropDownController.selDesignation.value,
                              ),
                    hint: 'Select DesignationList',
                    onChanged: (DesignationModel? newCass) {
                      if (newCass != null) {
                        dropDownController.selectDesignationOOb(newCass!.id!);
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
                TextInputField(
                  no: "11",
                  controller: workTypeCtr,
                  title: "Work",
                  hintText: 'Fill details',
                ),
                30.height,
                Center(
                  child: Obx(
                    () => userRegistrationFormController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : CommonButton(
                            text: "Register Now",
                            icon: const Icon(Icons.logout, color: Colors.white),
                            color: AppColors.bbAppColor1,
                            onPressed: userRegistrationFormController.isLoading.value
                                ? null
                                : () async {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      userRegistrationFormController.addFormData(
                                        name: nameCtr.text.trim(),
                                        empCode: empCodeCtr.text.trim(),
                                        email: emailCtr.text.trim(),
                                        contact: mobCtr.text.trim(),
                                        division: dropDownController
                                            .selectedDivision.value,
                                        district: dropDownController
                                            .selectedDistrict.value,
                                        vidhanSabha: dropDownController
                                            .selectedVidhanSabha.value,
                                        college: dropDownController
                                            .selectedCollege.value,
                                        classData: dropDownController
                                            .selectedClass.value,
                                        designation: dropDownController
                                            .selDesignation.value,
                                        address: addressCtr.text.trim(),
                                        workType: workTypeCtr.text.trim(),
                                      );
                                    }
                                  },
                          ),
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
