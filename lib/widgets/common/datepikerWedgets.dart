import 'package:flutter/material.dart';
import 'package:online/utils/utils.dart';

class DatePickerContainer extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const DatePickerContainer(
      {super.key, required this.selectedDate, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    final Utils globalFunction = Utils();
    return InkWell(
      onTap: () async {
        DateTime? currentDate =
        await globalFunction.showDatePickerDialog(context, selectedDate);
        if (currentDate != null) {
          onDateSelected(currentDate);
        }
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                globalFunction.formatDate(selectedDate),
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
              const Icon(
                Icons.calendar_today,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}