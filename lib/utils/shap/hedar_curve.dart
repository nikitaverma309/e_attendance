import 'package:flutter/material.dart';



class HeaderCurvedPainter extends CustomPainter {
  final Color color;

  HeaderCurvedPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path()
      ..relativeLineTo(0, 60)
      ..quadraticBezierTo(size.width / 2, 20, size.width, 60)
      ..relativeLineTo(0, -60)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}



class ShapesPainter extends CustomPainter {
  Color? color;

  ShapesPainter({this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color!;
    paint.style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height * 0.75);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height * 0.75);
    path.lineTo(size.height / 1.1, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}