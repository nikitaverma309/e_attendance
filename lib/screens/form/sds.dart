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
        child: Column(
          children: [
            // Division Dropdown
            Obx(() {
              if (commonController.divisions.isEmpty) {
                return CircularProgressIndicator();
              }
              return DropdownButton<String>(
                value: commonController.selectedDivision.value.isEmpty
                    ? null
                    : commonController.selectedDivision.value,
                hint: Text('Select Division'),
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
                return Text('Please select a division to see districts.');
              }
              return DropdownButton<String>(
                value: commonController.selectedDistrict.value.isEmpty
                    ? null
                    : commonController.selectedDistrict.value,
                hint: Text('Select District'),
                items: commonController.districts.map<DropdownMenuItem<String>>((district) {
                  return DropdownMenuItem<String>(
                    value: district['_id'].toString(),
                    child: Text(district['districtName']),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    commonController.selectDistrict(newValue);
                    print('Selected District Name: ${commonController.districts.firstWhere(
                            (dist) => dist['_id'].toString() == newValue)['districtName']}');
                  }
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}


