import 'package:flutter/material.dart';
import 'package:online/utils/shap/shape_design.dart';

Widget customButton(BuildContext context, String label, Color bgColor,
    Color textColor, IconData icon, VoidCallback onTap) {
  return InkWell(
    onTap: onTap, // Use the passed onTap function
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bgColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(color: textColor),

          ),
          const SizedBox(width: 10),
          Icon(icon, color: textColor),
        ],
      ),
    ),
  );
}



class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedValue;
  final String hint;
  final ValueChanged<T?> onChanged;
  final String displayKey;
  final String idKey;
  final bool enabled;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.hint,
    required this.onChanged,
    required this.idKey,
    required this.displayKey,
    this.enabled = true,  // Default to enabled
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: DropdownButtonFormField<T>(
        value: selectedValue,
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(
              (item as dynamic).toJson()[displayKey],
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),// Adjust according to model fields
            ),
          );
        }).toList(),
        onChanged: enabled ? onChanged : null,
        hint: Text(
          hint,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
        ),
        iconEnabledColor: Colors.green,
        dropdownColor: Colors.white,
        isExpanded: true,
      ),
    );
  }
}

class DropDownSelectionMessage extends StatelessWidget {
  final String message;


  DropDownSelectionMessage({
    Key? key,
    required this.message,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Shape.submitContainerRed(context),
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(message),
      ),
    );
  }
}