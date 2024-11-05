import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/shap/shape_design.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      required this.labelText,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.autofocus = false,
      this.isPassword = false});

  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool autofocus;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Container(

        decoration: Shape.choosePdfWhite(context),
        child: TextField(
          controller: controller,
          autofocus: autofocus,
          cursorColor: const Color(0xFF5BC8AA),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: labelText,
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[200],
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
          obscureText: isPassword,
          keyboardType: keyboardType,
        ),
      ),
    );
  }
}
