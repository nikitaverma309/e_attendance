import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({
    super.key,
    this.onPressed,
    this.text,
    this.color = Colors.blue,
    this.icon = const Icon(
      Icons.add,
      color: Colors.white,
    ),
    this.width,
    this.height,
  });

  final void Function()? onPressed;
  final String? text;
  final Icon icon;
  final Color color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        elevation: 12,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                blurRadius: 1,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          child: Text(
            text ?? '',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
