import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ctr.dart';
class CommonDroup extends StatefulWidget {
  const CommonDroup({super.key});

  @override
  State<CommonDroup> createState() => _CommonDroupState();
}

class _CommonDroupState extends State<CommonDroup> {
  final DivisionController commonController = Get.put(DivisionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Division Dropdown')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Division Dropdown
              Obx(() {
                if (commonController.divisions.isEmpty) {
                  return const CircularProgressIndicator();
                }
                return DropdownButton<String>(
                  value: commonController.selectedDivision.value.isEmpty
                      ? null
                      : commonController.selectedDivision.value,
                  hint: const Text('Select Division'),
                  items: commonController.divisions.map<DropdownMenuItem<String>>((division) {
                    return DropdownMenuItem<String>(
                      value: division['divisionCode'].toString(),
                      child: Text(division['name']),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      commonController.selectDivision(newValue);
                      commonController.fetchDistrictsByDivision(int.parse(newValue));
                      print('Selected Division Name: ${commonController.divisions.firstWhere(
                              (div) => div['divisionCode'].toString() == newValue)['name']}');
                    }
                  },
                );
              }),
              // District Dropdown
              Obx(() {
                if (commonController.districts.isEmpty) {
                  return const Text('Please select a division to see districts.');
                }
                return DropdownButton<String>(
                  value: commonController.selectedDistrict.value.isEmpty
                      ? null
                      : commonController.selectedDistrict.value,
                  hint: const Text('Select District'),
                  items: commonController.districts.map<DropdownMenuItem<String>>((district) {
                    return DropdownMenuItem<String>(
                      value: district['LGDCode'].toString(),
                      child: Text(district['districtName']),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      commonController.selectDistrict(newValue);
                      commonController.getVidhanSabhaByDivision(int.parse(newValue));
                      print('Selected District Name: ${commonController.districts.firstWhere(
                              (dist) => dist['LGDCode'].toString() == newValue)['districtName']}');
                    }
                  },
                );
              }),
              Obx(() {
                if (commonController.selectedVidhanSabha.isEmpty) {
                  return const Text('Please select a district to see vidhanSabbha.');
                }
                return  DropdownButton<String>(
                  value: commonController.selectedVidhanSabha.value.isEmpty
                      ? null
                      : commonController.selectedVidhanSabha.value,
                  hint: const Text('Select Vidhan Sabha'),
                  items: commonController.vidhanSabha.map<DropdownMenuItem<String>>((vidhanSabha) {
                    return DropdownMenuItem<String>(
                      value: vidhanSabha['ConstituencyNumber'].toString(), // Ensure correct key
                      child: Text(vidhanSabha['ConstituencyName']), // Ensure correct key
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      commonController.selectVidhanSabha(newValue);
                      print('Selected Vidhan Sabha Name: ${commonController.vidhanSabha.firstWhere(
                              (vs) => vs['ConstituencyNumber'].toString() == newValue)['ConstituencyName']}');
                    }
                  },
                );

              }),
            ],
          ),
        ),
      ),
    );
  }
}


