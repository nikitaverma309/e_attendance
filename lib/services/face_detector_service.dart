import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:online/locator.dart';
import 'package:online/utils/utils.dart';
import 'package:image/image.dart' as img;
import 'package:online/services/image_converter.dart';
import 'package:image/image.dart' as imglib;
import 'camera.service.dart';

/*class FaceDetectorService {
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
      // FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate),

      FaceDetectorOptions(
          // performanceMode: FaceDetectorMode.fast,  // Try this for better performance
          // minFaceSize: 0.1,
         // performanceMode: FaceDetectorMode.accurate
          // enableContours:true,
        //abhi ka usg update
        performanceMode: FaceDetectorMode.fast,
        minFaceSize: 0.15,
        enableClassification: true,
        enableContours: true,
        enableTracking: true,
          ),
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


  Future<imglib.Image?> cropFaceFromImage(CameraImage cameraImage) async {
    try {
      InputImageData firebaseImageMetadata = InputImageData(
        imageRotation:
            _cameraService.cameraRotation ?? InputImageRotation.rotation0deg,
        inputImageFormat:
            InputImageFormatValue.fromRawValue(cameraImage.format.raw) ??
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

      final int x = (boundingBox.left.toInt() - extraWidth)
          .clamp(0, originalImage.width - 1);
      final int y = (boundingBox.top.toInt() - extraHeight)
          .clamp(0, originalImage.height - 1);
      final int width = (boundingBox.width.toInt() + 2 * extraWidth)
          .clamp(0, originalImage.width - x);
      final int height = (boundingBox.height.toInt() + 2 * extraHeight)
          .clamp(0, originalImage.height - y);

      if (width <= 0 || height <= 0) {
        Utils.printLog('Invalid crop dimensions: width=$width, height=$height');
        return null;
      }

      final img.Image faceImage =
          img.copyCrop(originalImage, x, y, width, height);

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
}*/
class FaceDetectorService {
  final CameraService _cameraService = serviceLocator<CameraService>();
  late FaceDetector _faceDetector;
  CameraImage? currentImage;
  bool captureImage = false;
  bool isProcessing = false; // Add this flag
  List<Face> _faces = [];

  List<Face> get faces => _faces;
  bool get faceDetected => _faces.isNotEmpty;

  void initialize() {
    Utils.printLog('Initializing Face Detector...');
    _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        performanceMode: FaceDetectorMode.fast,
        minFaceSize: 0.15,
        enableClassification: true,
        enableContours: true,
        enableTracking: true,
      ),
    );
    Utils.printLog('Face Detector Initialized');
  }
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
      enableClassification: true, // Enable classification for detecting emotions
      enableTracking:
      true,
    ),
  );


  bool isProcessing = false;

  Future<void> detectFacesFromImage(CameraImage image) async {
    if (isProcessing) return; // Skip if already processing
    isProcessing = true; // Lock the processing

    try {
      // Convert CameraImage to InputImage
      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      // Create InputImage for Face Detection
      InputImage inputImage = InputImage.fromBytes(
        bytes: bytes,
        inputImageData: InputImageData(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          imageRotation: InputImageRotation
              .rotation0deg, // Adjust based on camera orientation
          inputImageFormat:
              InputImageFormat.yuv_420_888, // Common format for CameraImage
        ),
      );

      // Perform Face Detection
      final faces = await _faceDetector.processImage(inputImage);

      if (faces.isNotEmpty) {
        print('Faces detected: ${faces.length}');

        // Iterate through each detected face
        for (Face face in faces) {
          final Rect boundingBox = face.boundingBox;
          final double? rotX = face.headEulerAngleX; // Head is tilted up/down
          final double? rotY =
              face.headEulerAngleY; // Head is rotated left/right
          final double? rotZ = face.headEulerAngleZ; // Head is tilted sideways

          // Print head rotations
          print('Rotation X: $rotX, Y: $rotY, Z: $rotZ');

          // Access landmarks if enabled in FaceDetectorOptions
          final FaceLandmark? leftEar =
              face.landmarks[FaceLandmarkType.leftEar];
          if (leftEar != null) {
            final Point<int> leftEarPos = leftEar.position;
            print('Left ear position: $leftEarPos');
          }

          // Access classification details like smiling probability
          if (face.smilingProbability != null) {
            final double? smileProb = face.smilingProbability;
            print('Smile Probability: $smileProb');
          }

          // Access tracking ID if tracking is enabled
          if (face.trackingId != null) {
            final int? id = face.trackingId;
            print('Tracking ID: $id');
          }

          // You can also crop or further process the detected face here
          // For example: Crop the face if it's a valid face
          if (validateFace(face)) {
            print('Valid face detected, processing...');
            // Crop face logic (example)
            final croppedImage = await cropFaceFromImage(image);
            if (croppedImage != null) {
              print('Face cropped and processed successfully.');
            }
          }
        }
      } else {
        print('No faces detected');
      }
    } catch (e) {
      print('Error detecting faces: $e');
    } finally {
      isProcessing = false; // Reset the flag
    }
  }

  bool validateFace(Face face) {
    // Implement your custom validation logic here (e.g., size, position, etc.)
    return true;
  }

  Future<dynamic> cropFaceFromImage(CameraImage image) async {
    // Implement your face cropping logic here
    // This could use the bounding box from the face to crop the image accordingly
    return null; // Placeholder
  }

  void dispose() {
    _faceDetector.close();
  }

/*  Future<void> detectFacesFromImage(CameraImage image) async {
    if (isProcessing) return; // Skip if already processing
    isProcessing = true; // Lock the processing

    try {
      InputImageData firebaseImageMetadata = InputImageData(
        imageRotation: _cameraService.cameraRotation ?? InputImageRotation.rotation0deg,
        inputImageFormat: InputImageFormatValue.fromRawValue(image.format.raw) ?? InputImageFormat.yuv_420_888,
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

      if (_faces.isNotEmpty) {
        print('Faces detected: ${_faces.length}');
        Face detectedFace = _faces.first;

        // Validate and Crop Face
        if (validateFace(detectedFace)) {
          print("Valid face detected. Cropping...");
          final croppedImage = await cropFaceFromImage(image);
          if (croppedImage != null) {
            Utils.printLog("Face cropped and processed successfully.");
            // Process the cropped image (e.g., save or upload)
          }
        } else {
          print("Face not valid.");
        }
      } else {
        print("No faces detected.");
      }
    } catch (e) {
      print("Error detecting faces: $e");
    } finally {
      isProcessing = false; // Reset the flag
    }
  }*/

  bool validateFace(Face face) {
    // Custom validation logic (e.g., size, position)
    return face.boundingBox.width > 100 && face.boundingBox.height > 100;
  }

  Future<imglib.Image?> cropFaceFromImage(CameraImage cameraImage) async {
    try {
      final face = _faces.first;
      final boundingBox = face.boundingBox;

      final img.Image originalImage = convertCameraImage(cameraImage);

      const double expansionFactor = 0.2;
      final int extraWidth = (boundingBox.width * expansionFactor).toInt();
      final int extraHeight = (boundingBox.height * expansionFactor).toInt();

      final int x = (boundingBox.left.toInt() - extraWidth)
          .clamp(0, originalImage.width - 1);
      final int y = (boundingBox.top.toInt() - extraHeight)
          .clamp(0, originalImage.height - 1);
      final int width = (boundingBox.width.toInt() + 2 * extraWidth)
          .clamp(0, originalImage.width - x);
      final int height = (boundingBox.height.toInt() + 2 * extraHeight)
          .clamp(0, originalImage.height - y);

      if (width <= 0 || height <= 0) {
        Utils.printLog('Invalid crop dimensions: width=$width, height=$height');
        return null;
      }

      final img.Image faceImage =
          img.copyCrop(originalImage, x, y, width, height);

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
