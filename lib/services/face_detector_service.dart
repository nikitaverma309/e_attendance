// import 'package:camera/camera.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:online/utils/utils.dart';
// import 'package:image/image.dart' as img;
// import 'package:online/services/image_converter.dart';
// import 'camera.service.dart';
//
// class FaceDetectorService {
//   final CameraService _cameraService = CameraService();
//   late FaceDetector _faceDetector;
//   CameraImage? currentImage;
//   bool captureImage = false;
//   List<Face> _faces = [];
//
//   List<Face> get faces => _faces;
//   bool get faceDetected => _faces.isNotEmpty;
//
//   void initialize() {
//     Utils.printLog('Initializing Face Detector...');
//     _faceDetector = GoogleMlKit.vision.faceDetector(
//       FaceDetectorOptions(
//
//         minFaceSize: 0.1,
//         performanceMode: FaceDetectorMode.accurate,
//       ),
//     );
//     Utils.printLog('Face Detector Initialized');
//     print('Camera Rotation: ${_cameraService.cameraRotation}');
//     print('Preview Size: 640x480');
//   }
//
//   Future<void> detectFacesFromImage(CameraImage image) async {
//     try {
//       final InputImageData firebaseImageMetadata = InputImageData(
//         imageRotation:
//             _cameraService.cameraRotation ?? InputImageRotation.rotation0deg,
//         inputImageFormat:
//             InputImageFormatValue.fromRawValue(image.format.raw) ??
//                 InputImageFormat.yuv_420_888,
//         size: Size(image.width.toDouble(), image.height.toDouble()),
//         planeData: image.planes.map((Plane plane) {
//           return InputImagePlaneMetadata(
//             bytesPerRow: plane.bytesPerRow,
//             height: plane.height,
//             width: plane.width,
//           );
//         }).toList(),
//       );
//
//       // Convert CameraImage to bytes
//       final WriteBuffer allBytes = WriteBuffer();
//       for (final Plane plane in image.planes) {
//         allBytes.putUint8List(plane.bytes);
//       }
//       final bytes = allBytes.done().buffer.asUint8List();
//
//       // Create InputImage from bytes
//       InputImage firebaseVisionImage = InputImage.fromBytes(
//         bytes: bytes,
//         inputImageData: firebaseImageMetadata,
//       );
//
//       // Process face detection
//       _faces = await _faceDetector.processImage(firebaseVisionImage);
//       print('Faces detected: ${_faces.length}');
//
//       if (_faces.isNotEmpty) {
//         _faces.forEach((face) {
//           print('Face detected: ${face.boundingBox}');
//         });
//       }
//     } catch (e) {
//       print("Error in face detection: $e");
//     }
//   }
//
//   Future<img.Image?> cropFaceFromImage(CameraImage cameraImage) async {
//     try {
//       final InputImageData firebaseImageMetadata = InputImageData(
//         imageRotation:
//             _cameraService.cameraRotation ?? InputImageRotation.rotation0deg,
//         inputImageFormat:
//             InputImageFormatValue.fromRawValue(cameraImage.format.raw) ??
//                 InputImageFormat.yuv_420_888,
//         size: Size(cameraImage.width.toDouble(), cameraImage.height.toDouble()),
//         planeData: cameraImage.planes.map((Plane plane) {
//           return InputImagePlaneMetadata(
//             bytesPerRow: plane.bytesPerRow,
//             height: plane.height,
//             width: plane.width,
//           );
//         }).toList(),
//       );
//
//       final WriteBuffer allBytes = WriteBuffer();
//       for (final Plane plane in cameraImage.planes) {
//         allBytes.putUint8List(plane.bytes);
//       }
//       final bytes = allBytes.done().buffer.asUint8List();
//
//       InputImage firebaseVisionImage = InputImage.fromBytes(
//         bytes: bytes,
//         inputImageData: firebaseImageMetadata,
//       );
//
//       final faces = await _faceDetector.processImage(firebaseVisionImage);
//       if (faces.isEmpty) {
//         Utils.printLog('No face detected.');
//         return null;
//       }
//
//       final face = faces.first;
//       final boundingBox = face.boundingBox;
//
//       final img.Image originalImage = convertCameraImage(cameraImage);
//
//       const double expansionFactor = 0.2; // Padding for cropping
//       final int extraWidth = (boundingBox.width * expansionFactor).toInt();
//       final int extraHeight = (boundingBox.height * expansionFactor).toInt();
//
//       final int x = (boundingBox.left.toInt() - extraWidth)
//           .clamp(0, originalImage.width - 1);
//       final int y = (boundingBox.top.toInt() - extraHeight)
//           .clamp(0, originalImage.height - 1);
//       final int width = (boundingBox.width.toInt() + 2 * extraWidth)
//           .clamp(0, originalImage.width - x);
//       final int height = (boundingBox.height.toInt() + 2 * extraHeight)
//           .clamp(0, originalImage.height - y);
//
//       if (width <= 0 || height <= 0) {
//         Utils.printLog('Invalid crop dimensions: width=$width, height=$height');
//         return null;
//       }
//
//       final img.Image faceImage =
//           img.copyCrop(originalImage, x, y, width, height);
//
//       Utils.printLog('Cropped Image Successfully.');
//       return faceImage;
//     } catch (e) {
//       Utils.printLog('Error cropping face: $e');
//       return null;
//     }
//   }
//
//   void dispose() {
//     print('Disposing Face Detector...');
//     _faceDetector.close();
//     print('Face Detector disposed.');
//   }
// }
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:online/locator.dart';
import 'package:online/utils/utils.dart';
import 'package:image/image.dart' as img;
import 'package:online/services/image_converter.dart';
import 'package:image/image.dart' as imglib;
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
    Utils.printLog('Initializing Face Detector...');
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableContours: true, // Enable contours if needed
        enableLandmarks: true, // Enable landmarks if needed
        performanceMode: FaceDetectorMode
            .accurate, // Performance mode: accurate for better quality
      ),
    );
    Utils.printLog('Face Detector Initialized');
  }

  Future<void> detectFacesFromImage(CameraImage image) async {
    try {
      // Create InputImageMetadata
    final  metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      );
      final metadata = InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotation.rotation0deg, // Adjust as per your camera rotation
        format: InputImageFormat.yuv_420_888, // Set the appropriate format for your image
        bytesPerRow: image.planes[0].bytesPerRow,
      );
      // Convert CameraImage to bytes
      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      // Create InputImage from bytes and metadata
      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: metadata,
      );

      // Pass the InputImage to checkImage
      await inputImage;
    } catch (e) {
      print("Error in face detection: $e");
    }
  }
  InputImage? inputImageFromCameraImage(CameraImage image) {
    final camera = cameras[1]; // Adjust this index based on your configuration
    final sensorOrientation = camera.sensorOrientation;

    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
      orientations[controller!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) {
      return null;
    }

    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }


  final orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  Future<img.Image?> resizeImage(CameraImage cameraImage) async {
    final int maxWidth = 800; // Adjust max width as needed
    final int maxHeight = 800; // Adjust max height as needed

    final img.Image originalImage = convertCameraImage(cameraImage);

    // Resize the image
    img.Image resizedImage =
        img.copyResize(originalImage, width: maxWidth, height: maxHeight);

    return resizedImage;
  }

  Future<imglib.Image?> cropFaceFromImage(CameraImage cameraImage) async {
    try {
      // Create metadata for the image
      final metadata = InputImageMetadata(
        size: Size(cameraImage.width.toDouble(), cameraImage.height.toDouble()),
        rotation:
            _cameraService.cameraRotation ?? InputImageRotation.rotation0deg,
        format: InputImageFormatValue.fromRawValue(cameraImage.format.raw) ??
            InputImageFormat.yuv_420_888,
        bytesPerRow: cameraImage
            .planes[0].bytesPerRow, // Adjust as per your image's first plane
      );

      // Convert the camera image to bytes
      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in cameraImage.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      // Create InputImage from the bytes and metadata
      final firebaseVisionImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: metadata, // Pass metadata here
      );

      // Detect faces using the face detector
      final faces = await _faceDetector.processImage(firebaseVisionImage);

      if (faces.isEmpty) {
        Utils.printLog('No face detected.');
        return null;
      }

      // Get the first face and its bounding box
      final face = faces.first;
      final boundingBox = face.boundingBox;

      // Convert the CameraImage to img.Image for cropping
      final img.Image originalImage = convertCameraImage(cameraImage);

      // Add padding around the bounding box for a better crop
      const double expansionFactor = 0.2;
      final int extraWidth = (boundingBox.width * expansionFactor).toInt();
      final int extraHeight = (boundingBox.height * expansionFactor).toInt();

      // Calculate the new crop boundaries, ensuring we don't go out of bounds
      final int x = (boundingBox.left.toInt() - extraWidth)
          .clamp(0, originalImage.width - 1);
      final int y = (boundingBox.top.toInt() - extraHeight)
          .clamp(0, originalImage.height - 1);
      final int width = (boundingBox.width.toInt() + 2 * extraWidth)
          .clamp(0, originalImage.width - x);
      final int height = (boundingBox.height.toInt() + 2 * extraHeight)
          .clamp(0, originalImage.height - y);

      // Ensure valid crop dimensions
      if (width <= 0 || height <= 0) {
        Utils.printLog('Invalid crop dimensions: width=$width, height=$height');
        return null;
      }

      // Crop the face image
      final img.Image faceImage =
          img.copyCrop(originalImage, x, y, width, height);

      Utils.printLog('Cropped Image Successfully.');
      return faceImage;
    } catch (e) {
      Utils.printLog('Error cropping face: $e');
      return null;
    }
  }

  void dispose() {
    print('Disposing Face Detector...');
    _faceDetector.close();
    print('Face Detector disposed.');
  }
}
