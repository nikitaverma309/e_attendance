import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'package:online/utils/utils.dart';

class FacePainter extends CustomPainter {
  FacePainter({
    required this.imageSize,
    required this.face,
  });
  bool accurateFace = false;
  final Size imageSize;
  double? scaleX, scaleY;
  Face? face;
  @override
  void paint(Canvas canvas, Size size) {
    if (face == null) return;

    Paint paint;

    if (face!.headEulerAngleY! > 10 || face!.headEulerAngleY! < -10) {
      paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..color = Colors.red;
      if (accurateFace != false) {
        Utils.printLog("accurate red $accurateFace");
      }
      accurateFace = false;
    } else {
      paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..color = Colors.green;
      if (accurateFace != true) {
        accurateFace = true;
      }
    }

    scaleX = size.width / imageSize.width;
    scaleY = size.height / imageSize.height;

    canvas.drawRRect(
        _scaleRect(
            rect: face!.boundingBox,
            imageSize: imageSize,
            widgetSize: size,
            scaleX: scaleX ?? 1,
            scaleY: scaleY ?? 1),
        paint);
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.face != face;
  }
}

RRect _scaleRect(
    {required Rect rect,
    required Size imageSize,
    required Size widgetSize,
    double scaleX = 1,
    double scaleY = 1}) {
  return RRect.fromLTRBR(
      (widgetSize.width - rect.left.toDouble() * scaleX),
      rect.top.toDouble() * scaleY,
      widgetSize.width - rect.right.toDouble() * scaleX,
      rect.bottom.toDouble() * scaleY,
      const Radius.circular(10));
}
/*
import 'dart:math' as math;

class FacePainter extends CustomPainter {
  FacePainter({
    required this.imageSize,
    required this.face,
    required this.isAligned,
    required this.rotationAngle,
  });

  final Size imageSize;
  final Face? face;
  final bool isAligned;
  final double rotationAngle;
  double? scaleX, scaleY;

  @override
  void paint(Canvas canvas, Size size) {
    if (face == null) return;

    scaleX = size.width / imageSize.width;
    scaleY = size.height / imageSize.height;

    final center = Offset(
      size.width - (face!.boundingBox.center.dx * (scaleX ?? 1)),
      face!.boundingBox.center.dy * (scaleY ?? 1),
    );

    final radius = (face!.boundingBox.width / 2) * scaleX!;

    // Face bounding circle
    Paint facePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = isAligned ? Colors.green : Colors.red;

    canvas.drawCircle(center, radius, facePaint);

    // Rotating circle
    if (isAligned) {
      Paint rotatingPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..color = Colors.green;

      double outerRadius = radius + 10; // Slightly larger than face circle
      double startAngle = rotationAngle;
      double sweepAngle = math.pi / 4;

      for (int i = 0; i < 8; i++) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: outerRadius),
          startAngle + i * (math.pi / 4),
          sweepAngle / 2,
          false,
          rotatingPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant FacePainter oldDelegate) {
    return oldDelegate.imageSize != imageSize ||
        oldDelegate.face != face ||
        oldDelegate.isAligned != isAligned ||
        oldDelegate.rotationAngle != rotationAngle;
  }
}*/
