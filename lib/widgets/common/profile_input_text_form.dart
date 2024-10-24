import 'package:flutter/material.dart';

class ProfileInputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;

  const ProfileInputTextField(
      {super.key,
      required this.controller,
      required this.title,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Colors.black.withOpacity(.7)),
        ),
        const SizedBox(
          height: 2,
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 11,
          ),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: TextField(
            controller: controller,
            decoration:
                InputDecoration(border: InputBorder.none, hintText: hintText),
          ),
        ),
      ],
    );
  }
}
