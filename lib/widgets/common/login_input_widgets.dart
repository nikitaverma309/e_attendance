import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:online/constants/text_size_const.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? error;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final bool showHintText;
  final TextInputType? inputType;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  final bool? enabled;
  final bool isPasswordField; // New property to check if it's a password field

  const InputField({
    super.key,
    required this.controller,
    this.error,
    this.hintText,
    this.validator,
    this.focusNode,
    this.showHintText = true,
    this.inputType,
    this.onChanged,
    this.inputFormatters,
    this.enabled = true,
    this.isPasswordField = false, // Default to false for non-password fields
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  String? _errorText;
  bool _isPasswordVisible = false; // Manages the visibility of password text

  @override
  void initState() {
    super.initState();
    _errorText = widget.error;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: kText16BoldBlackColorStyle,
      textInputAction: TextInputAction.next,
      controller: widget.controller,
      focusNode: widget.focusNode,
      autofocus: false,
      enabled: widget.enabled,
      autocorrect: true,
      onChanged: (value) {
        setState(() {
          _errorText = null;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
        // Trigger validation when the text changes
        Form.of(context)?.validate();
      },
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.inputType,
      obscureText: widget.isPasswordField &&
          !_isPasswordVisible, // Toggle password visibility
      decoration: InputDecoration(
        errorText: widget.error != null && widget.error!.trim().isNotEmpty
            ? widget.error
            : null,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white, // Default border color
            width: 1.0, // Default border width
          ),
          borderRadius: BorderRadius.circular(5.0), // Default border radius
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white, // Border color when enabled
            width: 1.0, // Border width when enabled
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white, // Border color when focused
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red, // Border color when there's an error
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red, // Border color when focused and there's an error
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        hintText: widget.showHintText ? widget.hintText : null,
        hintStyle: kText16GrayColorStyle,
        fillColor: Colors.white, // Background color
        filled: true, // Apply the background color
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignLabelWithHint: false,
        suffixIcon: widget.isPasswordField
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
      ),
      validator: (value) {
        if (widget.validator != null) {
          final error = widget.validator!(value);
          setState(() {
            _errorText = error;
          });
          return error;
        }
        return null;
      },
    );
  }
}
