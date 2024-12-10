// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
//
// class FacePainter extends CustomPainter {
//   FacePainter({
//     required this.imageSize,
//     required this.face,
//   });
//
//   bool accurateFace = false;
//   final Size imageSize;
//   double? scaleX, scaleY;
//   Face? face;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (face == null) return;
//
//     Paint paint;
//
//     // Determine if the face angle is tilted and set the rectangle color accordingly
//     if (face!.headEulerAngleY! > 10 || face!.headEulerAngleY! < -10) {
//       paint = Paint()
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 3.0
//         ..color = Colors.red;  // Red color for tilted face
//       accurateFace = false;
//     } else {
//       paint = Paint()
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 3.0
//         ..color = Colors.green;  // Green color for properly aligned face
//       accurateFace = true;
//     }
//
//     // Calculate scaling factors for X and Y axis based on the widget and image sizes
//     scaleX = size.width / imageSize.width;
//     scaleY = size.height / imageSize.height;
//
//     // Ensure that scaling factors are applied to the bounding box coordinates correctly
//     if (face!.boundingBox != null) {
//       final scaledRect = _scaleRect(
//         rect: face!.boundingBox!,
//         scaleX: scaleX ?? 1,
//         scaleY: scaleY ?? 1,
//         size: size,
//       );
//
//       // Draw the scaled bounding box correctly on the canvas
//       canvas.drawRRect(
//         scaledRect,
//         paint,
//       );
//     }
//   }
//
//   @override
//   bool shouldRepaint(FacePainter oldDelegate) {
//     return oldDelegate.imageSize != imageSize || oldDelegate.face != face;
//   }
// }
//
// RRect _scaleRect({
//   required Rect rect,
//   required double scaleX,
//   required double scaleY,
//   required Size size,
// }) {
//   // Apply scaling to the bounding box coordinates
//   double left = rect.left * scaleX;
//   double top = rect.top * scaleY;
//   double right = rect.right * scaleX;
//   double bottom = rect.bottom * scaleY;
//
//   // Ensure the rectangle stays within the bounds of the canvas using clamping
//   left = left.clamp(0.0, size.width);
//   top = top.clamp(0.0, size.height);
//   right = right.clamp(0.0, size.width);
//   bottom = bottom.clamp(0.0, size.height);
//
//   // Return the scaled and clamped RRect
//   return RRect.fromLTRBR(
//     left,
//     top,
//     right,
//     bottom,
//     const Radius.circular(10),
//   );
// }
import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:online/utils/utils.dart';

class FacePainter extends CustomPainter {
  FacePainter({
    required this.imageSize,
    required this.face,
  });

  final Size imageSize;
  double? scaleX, scaleY;
  Face? face;

  @override
  void paint(Canvas canvas, Size size) {
    if (face == null) return;

    Paint paint;

    // Check head angle for determining the color
    if (face!.headEulerAngleY! > 10 || face!.headEulerAngleY! < -10) {
      paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..color = Colors.red;
    } else {
      paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..color = Colors.green;
    }

    scaleX = size.width / imageSize.width;
    scaleY = size.height / imageSize.height;

    // Draw the rectangle
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
      rect.left * scaleX,
      rect.top * scaleY,
      rect.right * scaleX,
      rect.bottom * scaleY,
      const Radius.circular(10));
}
