
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online/constants/text_size_const.dart';


class TextInputField extends StatefulWidget {
  final TextEditingController controller;
  final String? title;
  final String? no;
  final String? hintText;
  final String? error;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final bool showHintText;
  final TextInputType? inputType;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final bool? enabled;

  const TextInputField({
    super.key,
    required this.controller,
    this.title,
    this.no,
    this.error,
    this.hintText,
    this.validator,
    this.focusNode,
    this.showHintText = true,
    this.inputType,
    this.onChanged,
    this.inputFormatters,
    this.maxLines,
    this.maxLength,
    this.maxLengthEnforcement,
    this.enabled = true,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _errorText = widget.error;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: widget.no,
                  style: kTextBlue,
                ),
                const TextSpan(
                  text: "  ",
                ),
                const WidgetSpan(
                  child: SizedBox(width: 6,)
                ),
                TextSpan(
                  text: widget.title,
                  style: kText13BoldBlackColorStyle,
                ),
                const TextSpan(
                  text: '  *',
                  style: kText16BoldRed,
                ),
              ],
            ),
          ),
        ),
        TextFormField(
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
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          maxLengthEnforcement: widget.maxLengthEnforcement,
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
            hintStyle:   kText16GrayColorStyle,
            fillColor: Colors.white, // Background color
            filled: true, // Apply the background color
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            alignLabelWithHint: true,
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
        ),
      const SizedBox(height: 2,)
      ],
    );
  }
}
