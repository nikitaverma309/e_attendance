import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/division_controller.dart';

class DivisionDropdown extends StatefulWidget {
  const DivisionDropdown({super.key});

  @override
  State<DivisionDropdown> createState() => _DivisionDropdownState();
}

class _DivisionDropdownState extends State<DivisionDropdown> {
  final DivisionController divisionController = Get.put(DivisionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Division')),
      body: Center(
        child: Column(
          children: [
            Obx(() {
              if (divisionController.divisionList.isEmpty) {
                return const CircularProgressIndicator(); // Show loading indicator
              }
              return DropdownButton<int?>(
                value: divisionController.selectedDivisionCode.value,
                onChanged: (newValue) {
                  divisionController.selectedDivisionCode.value = newValue;
                  if (newValue != null) {
                    divisionController.fetchDistrictsByDivision(newValue);
                  }
                },
                items: divisionController.divisionList.map((division) {
                  return DropdownMenuItem<int>(
                    value: division.divisionCode,
                    child: Text(division.name),
                  );
                }).toList(),
                hint: const Text('Select Division'),
              );
            }),
            Obx(() {
              if (divisionController.isLoading.value) {
                return CircularProgressIndicator();
              }
              return DropdownButton<int?>(
                value: divisionController.selectedDistrictCode.value,
                onChanged: (newValue) {
                  divisionController.selectedDistrictCode.value = newValue;
                },
                items: divisionController.districtList.map((district) {
                  return DropdownMenuItem<int>(
                    value: district.lgdCode,
                    child: Text(district.districtNameEng),
                  );
                }).toList(),
                hint: Text('Select District'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
