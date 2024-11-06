import 'package:flutter/material.dart';

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
  final void Function(T?) onChanged;
  final String hint;
  final bool enabled;

  const CustomDropdown({
    Key? key,
    required this.items,
    this.selectedValue,
    required this.onChanged,
    required this.hint,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: DropdownButtonFormField<T>(
        value: selectedValue,
        items: items
            .map((item) => DropdownMenuItem<T>(
          value: item,
          child: Text(
            item.toString(), // toString() shows the 'name' in dropdown
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ))
            .toList(),
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

