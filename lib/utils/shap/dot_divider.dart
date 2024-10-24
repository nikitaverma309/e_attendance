import 'package:flutter/material.dart';

class DotDivider extends StatelessWidget {
  final double height;
  final Color color;

  const DotDivider({super.key, this.height = 1.0, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedLinePainter(height: height, color: color),
      child: SizedBox(
        height: height,
        width: double.infinity,
      ),
    );
  }
}

// Custom Painter to draw Dotted Line
class DottedLinePainter extends CustomPainter {
  final double height;
  final Color color;

  DottedLinePainter({required this.height, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 3.0; // Width of each dot
    double dashSpace = 3.0; // Space between each dot
    final paint = Paint()
      ..color = color
      ..strokeWidth = height;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}