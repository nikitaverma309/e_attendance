import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
<<<<<<< HEAD
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
=======
>>>>>>> 73707ac735af1804bd6daf6a49eb13ae46407c7c
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
