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
