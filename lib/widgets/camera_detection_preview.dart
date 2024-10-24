import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:online/services/camera.service.dart'; // Adjust the path as needed
import 'package:online/services/face_detector_service.dart'; // Adjust the path as needed
import 'package:online/locator.dart'; // Adjust the path as needed
import 'FacePainter.dart'; // Adjust the path as needed

class CameraDetectionPreview extends StatelessWidget {
  CameraDetectionPreview({Key? key}) : super(key: key);

  final CameraService _cameraService = locator<CameraService>();
  final FaceDetectorService _faceDetectorService = locator<FaceDetectorService>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Center( // Center the circular camera view
      child: ClipOval( // Clip the camera view to a circular shape
        child: Container(
          width: width * 0.3, // Adjust width as needed
          height: width * 0.3, // Ensure height matches width for a circle
          child: AspectRatio(
            aspectRatio: 1.0, // Ensure the aspect ratio is 1:1 for the circular view
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                CameraPreview(_cameraService.cameraController!), // Camera preview
                if (_faceDetectorService.faceDetected)
                  CustomPaint(
                    painter: FacePainter(
                      face: _faceDetectorService.faces[0],
                      imageSize: _cameraService.getImageSize(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
