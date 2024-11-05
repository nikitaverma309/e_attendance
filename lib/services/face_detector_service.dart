import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../locator.dart';
import 'camera.service.dart';

class FaceDetectorService {
  final CameraService _cameraService = serviceLocator<CameraService>();
  late FaceDetector _faceDetector;
  CameraImage? currentImage;
  bool captureImage = false;
  List<Face> _faces = [];

  List<Face> get faces => _faces;
  bool get faceDetected => _faces.isNotEmpty;

  void initialize() {
    print('Initializing Face Detector...');
    _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
      ),
    );
    print('Face Detector Initialized');
  }

  Future<void> detectFacesFromImage(CameraImage image) async {
    print('Starting face detection...');
    InputImageData firebaseImageMetadata = InputImageData(
      imageRotation:
          _cameraService.cameraRotation ?? InputImageRotation.rotation0deg,
      inputImageFormat: InputImageFormatValue.fromRawValue(image.format.raw) ??
          InputImageFormat.yuv_420_888,
      size: Size(image.width.toDouble(), image.height.toDouble()),
      planeData: image.planes.map(
        (Plane plane) {
          return InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList(),
    );

    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    InputImage firebaseVisionImage = InputImage.fromBytes(
      bytes: bytes,
      inputImageData: firebaseImageMetadata,
    );

    _faces = await _faceDetector.processImage(firebaseVisionImage);
    print(
        'Faces detected: ${_faces.length}'); // Log the number of detected faces
  }

  dispose() {
    print('Disposing Face Detector...');
    _faceDetector.close();
    print('Face Detector disposed.');
  }
}
