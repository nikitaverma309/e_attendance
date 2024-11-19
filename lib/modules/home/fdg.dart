import 'package:flutter/material.dart';
import 'package:online/constants/text_size_const.dart';

class AttendanceRow extends StatefulWidget {
  @override
  _AttendanceRowState createState() => _AttendanceRowState();
}

class _AttendanceRowState extends State<AttendanceRow> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 5),
        const Flexible(
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(
              "उपस्थिति आईडी    \ Attendance ID",
              style: k13BoldBlackColorStyle,
            ),
          ),
        ),
        const SizedBox(width: 5),
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
        ),
      ],
    );
  }
}
