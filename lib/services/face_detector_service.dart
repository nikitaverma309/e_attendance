import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:online/locator.dart';
import 'package:online/utils/utils.dart';
import 'package:image/image.dart' as img;
import 'package:online/services/image_converter.dart';
import 'package:path_provider/path_provider.dart';
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
    _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate),
    );
    Utils.printLog('Face Detector Initialized');
  }

  Future<void> detectFacesFromImage(CameraImage image) async {
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
    print('Faces detected: ${_faces.length}');
  }

  // Future<File?> cropFaceFromImage(CameraImage cameraImage) async {
  //   try {
  //     InputImageData firebaseImageMetadata = InputImageData(
  //       imageRotation:
  //       _cameraService.cameraRotation ?? InputImageRotation.rotation0deg,
  //       inputImageFormat:
  //       InputImageFormatValue.fromRawValue(cameraImage.format.raw) ??
  //           InputImageFormat.yuv_420_888,
  //       size: Size(cameraImage.width.toDouble(), cameraImage.height.toDouble()),
  //       planeData: cameraImage.planes.map(
  //             (Plane plane) {
  //           return InputImagePlaneMetadata(
  //             bytesPerRow: plane.bytesPerRow,
  //             height: plane.height,
  //             width: plane.width,
  //           );
  //         },
  //       ).toList(),
  //     );
  //
  //     final WriteBuffer allBytes = WriteBuffer();
  //     for (final Plane plane in cameraImage.planes) {
  //       allBytes.putUint8List(plane.bytes);
  //     }
  //     final bytes = allBytes.done().buffer.asUint8List();
  //
  //     InputImage firebaseVisionImage = InputImage.fromBytes(
  //       bytes: bytes,
  //       inputImageData: firebaseImageMetadata,
  //     );
  //
  //     final face =
  //         (await _faceDetector.processImage(firebaseVisionImage)).first;
  //
  //     // Get the bounding box of the detected face
  //     final boundingBox = face.boundingBox;
  //
  //     final img.Image originalImage = convertCameraImage(cameraImage);
  //
  //     // Expand the bounding box by 20% on each side
  //     const double expansionFactor = 0.2;
  //     final int extraWidth = (boundingBox.width * expansionFactor).toInt();
  //     final int extraHeight = (boundingBox.height * expansionFactor).toInt();
  //
  //     // Adjust expanded bounding box to ensure it's within image bounds
  //     final x = (boundingBox.left.toInt() - extraWidth)
  //         .clamp(0, originalImage.width - 1);
  //     final y = (boundingBox.top.toInt() - extraHeight)
  //         .clamp(0, originalImage.height - 1);
  //     final width = (boundingBox.width.toInt() + 2 * extraWidth)
  //         .clamp(0, originalImage.width - x);
  //     final height = (boundingBox.height.toInt() + 2 * extraHeight)
  //         .clamp(0, originalImage.height - y);
  //
  //     // Crop the face from the image
  //     final img.Image faceImage =
  //     img.copyCrop(originalImage, x, y, width, height);
  //
  //     final faceFile = convertImageToFile(faceImage);
  //
  //     return faceFile;
  //   } catch (e) {
  //     Utils.printLog('Error cropping face: $e');
  //     return null;
  //   }
  // }
  Future<imglib.Image?> cropFaceFromImage(CameraImage cameraImage) async {
    try {
      InputImageData firebaseImageMetadata = InputImageData(
        imageRotation: _cameraService.cameraRotation ?? InputImageRotation.rotation0deg,
        inputImageFormat: InputImageFormatValue.fromRawValue(cameraImage.format.raw) ??
            InputImageFormat.yuv_420_888,
        size: Size(cameraImage.width.toDouble(), cameraImage.height.toDouble()),
        planeData: cameraImage.planes.map((Plane plane) {
          return InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        }).toList(),
      );

      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in cameraImage.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      InputImage firebaseVisionImage = InputImage.fromBytes(
        bytes: bytes,
        inputImageData: firebaseImageMetadata,
      );

      final faces = await _faceDetector.processImage(firebaseVisionImage);
      if (faces.isEmpty) {
        Utils.printLog('कोई फेस डिटेक्ट नहीं हुआ।');
        return null;
      }

      final face = faces.first;
      final boundingBox = face.boundingBox;

      final img.Image originalImage = convertCameraImage(cameraImage);

      // Adjust bounding box
      const double expansionFactor = 0.2;
      final int extraWidth = (boundingBox.width * expansionFactor).toInt();
      final int extraHeight = (boundingBox.height * expansionFactor).toInt();

      final int x = (boundingBox.left.toInt() - extraWidth).clamp(0, originalImage.width - 1);
      final int y = (boundingBox.top.toInt() - extraHeight).clamp(0, originalImage.height - 1);
      final int width = (boundingBox.width.toInt() + 2 * extraWidth).clamp(0, originalImage.width - x);
      final int height = (boundingBox.height.toInt() + 2 * extraHeight).clamp(0, originalImage.height - y);

      if (width <= 0 || height <= 0) {
        Utils.printLog('Invalid crop dimensions: width=$width, height=$height');
        return null;
      }

      final img.Image faceImage = img.copyCrop(originalImage, x, y, width, height);

      Utils.printLog('Cropped Image Successfully.');
      return faceImage;
    } catch (e) {
      Utils.printLog('Error cropping face: $e');
      return null;
    }
  }


  dispose() {
    print('Disposing Face Detector...');
    _faceDetector.close();
    print('Face Detector disposed.');
  }
}