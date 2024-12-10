// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
//
// import '../widgets/camera_widgets/FacePainter.dart';
//
// class CameraScreen extends StatefulWidget {
//   const CameraScreen({super.key});
//
//   @override
//   State<CameraScreen> createState() => _CameraScreenState();
// }
//
// class _CameraScreenState extends State<CameraScreen> {
//   CameraController? controller;
//   late List<CameraDescription> cameras;
//   FaceDetector? faceDetector;
//   bool isProcessing = false;
//   String error = '';
//
//   Face? detectedFace;
//   Size? imageSize;
//   bool isFaceAccurate = false; // चेहरा सही स्थिति में है या नहीं
//
//   @override
//   void initState() {
//     super.initState();
//     initializeCamera();
//     faceDetector = FaceDetector(
//       options: FaceDetectorOptions(
//         enableLandmarks: true,
//         enableClassification: true,
//         performanceMode: FaceDetectorMode.accurate,
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     faceDetector?.close();
//     controller?.dispose();
//     super.dispose();
//   }
//
//   Future<void> initializeCamera() async {
//     cameras = await availableCameras();
//     controller = CameraController(
//       cameras[1], // Front-facing camera
//       ResolutionPreset.high,
//       enableAudio: false,
//     );
//
//     try {
//       await controller!.initialize();
//       controller!.startImageStream(_processCameraImage);
//       setState(() {});
//     } catch (e) {
//       setState(() {
//         error = 'Camera initialization failed: $e';
//       });
//     }
//   }
//
//   void _processCameraImage(CameraImage image) async {
//     if (isProcessing) return;
//     isProcessing = true;
//
//     final inputImage = inputImageFromCameraImage(image);
//     if (inputImage == null) {
//       isProcessing = false;
//       return;
//     }
//
//     try {
//       final faces = await faceDetector!.processImage(inputImage);
//
//       if (faces.isNotEmpty) {
//         setState(() {
//           detectedFace = faces.first;
//           imageSize = Size(image.width.toDouble(), image.height.toDouble());
//           isFaceAccurate = detectedFace!.headEulerAngleY! >= -10 &&
//               detectedFace!.headEulerAngleY! <= 10; // चेहरा सही स्थिति में है
//         });
//       } else {
//         setState(() {
//           detectedFace = null;
//           isFaceAccurate = false;
//           error = 'No face detected. Please try again!';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         error = 'Face detection failed: $e';
//       });
//     } finally {
//       isProcessing = false;
//     }
//   }
//
//   InputImage? inputImageFromCameraImage(CameraImage image) {
//     final format = InputImageFormatValue.fromRawValue(image.format.raw);
//     if (format == null) return null;
//
//     return InputImage.fromBytes(
//       bytes: image.planes.first.bytes,
//       metadata: InputImageMetadata(
//         size: Size(image.width.toDouble(), image.height.toDouble()),
//         rotation: InputImageRotation.rotation0deg, // Adjust based on your device orientation
//         format: format,
//         bytesPerRow: image.planes.first.bytesPerRow,
//       ),
//     );
//   }
//
//   Future<void> captureImage() async {
//     if (controller == null || !controller!.value.isInitialized) return;
//
//     try {
//       final XFile image = await controller!.takePicture(); // इमेज कैप्चर करें
//       setState(() {
//         error = 'Image captured: ${image.path}';
//       });
//     } catch (e) {
//       setState(() {
//         error = 'Failed to capture image: $e';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Face Detection Camera'),
//         centerTitle: true,
//       ),
//       body: controller == null || !controller!.value.isInitialized
//           ? Center(
//         child: Text(
//           error.isEmpty ? 'Initializing Camera...' : error,
//           textAlign: TextAlign.center,
//         ),
//       )
//           : Stack(
//         children: [
//           CameraPreview(controller!),
//           if (detectedFace != null && imageSize != null)
//             CustomPaint(
//               painter: FacePainter(
//                 imageSize: imageSize!,
//                 face: detectedFace!,
//               ),
//               size: MediaQuery.of(context).size,
//             ),
//           if (error.isNotEmpty)
//             Positioned(
//               bottom: 80,
//               left: 0,
//               right: 0,
//               child: Center(
//                 child: Text(
//                   error,
//                   style: const TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           Positioned(
//             bottom: 20,
//             right: 20,
//             child: FloatingActionButton(
//               onPressed: isFaceAccurate ? captureImage : null, // चेहरा सही है तो ही सक्रिय
//               backgroundColor: isFaceAccurate ? Colors.green : Colors.grey,
//               child: const Icon(Icons.camera),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
