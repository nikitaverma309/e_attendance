// import 'dart:io';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class CameraScreen extends StatefulWidget {
//   const CameraScreen({super.key});
//
//   @override
//   State<CameraScreen> createState() => _CameraScreenState();
// }
//
// class _CameraScreenState extends State<CameraScreen>
//     with WidgetsBindingObserver, TickerProviderStateMixin {
//   CameraController? controller;
//   String error='';
//
//   FaceDetector faceDetector = FaceDetector(
//     options: FaceDetectorOptions(
//       enableClassification: true,
//       enableContours: true,
//       enableTracking: true,
//       enableLandmarks: true,
//       performanceMode: Platform.isAndroid
//           ? FaceDetectorMode.fast
//           : FaceDetectorMode.accurate,
//     ),
//   );
//
//   final orientations = {
//     DeviceOrientation.portraitUp: 0,
//     DeviceOrientation.landscapeLeft: 90,
//     DeviceOrientation.portraitDown: 180,
//     DeviceOrientation.landscapeRight: 270,
//   };
//
//   initialize() async {
//     controller = CameraController(
//       cameras[1],
//       ResolutionPreset.medium,
//       imageFormatGroup: Platform.isAndroid
//           ? ImageFormatGroup.nv21
//           : ImageFormatGroup.bgra8888,
//     );
//     if (mounted) setState(() {});
//     initializeCameraController(controller!.description);
//     if (mounted) setState(() {});
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     initialize();
//   }
//
//   @override
//   void dispose() {
//     faceDetector.close();
//     if (controller != null) controller!.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     final CameraController? cameraController = controller;
//     if (cameraController == null || !cameraController.value.isInitialized) {
//       return;
//     }
//
//     if (state == AppLifecycleState.inactive) {
//       cameraController.dispose();
//     } else if (state == AppLifecycleState.resumed) {
//       initialize();
//     }
//   }
//
//   Future<void> initializeCameraController() async {
//     try {
//       await controller!.initialize();
//       controller!.setFlashMode(FlashMode.off);
//       // If the controller is updated then update the UI.
//       controller!.addListener(() {
//         if (mounted) setState(() {});
//         controller!.startImageStream(_processCameraImage).then((value) {});
//       });
//       if (mounted) setState(() {});
//     } on CameraException catch (e) {
//       switch (e.code) {
//         case 'CameraAccessDenied':
//           Get.back();
//           cameraDialog();
//           break;
//         case 'CameraAccessDeniedWithoutPrompt':
//           Get.back();
//           cameraDialog();
//           break;
//         case 'CameraAccessRestricted':
//           Get.back();
//           cameraDialog();
//           break;
//         default:
//           Get.back();
//           EasyLoading.showError(e.description!);
//           break;
//       }
//     }
//     if (mounted) setState(() {});
//   }
//
//   cameraDialog() {
//     Get.defaultDialog(
//       title: 'Camera Access',
//       middleText:
//       'Looks like you have not provided permission to camera completely. Enable it in the settings.',
//       onConfirm: () async {
//         Get.back();
//         await openAppSettings();
//       },
//     );
//   }
//
//   clearCaptured(String message) {
//     debugPrint(message);
//     imageFile = null;
//     error = message;
//     if (mounted) setState(() {});
//     return;
//   }
//
//   void _processCameraImage(CameraImage image) {
//     final inputImage = inputImageFromCameraImage(image);
//     if (inputImage == null) return;
//     checkImage(inputImage);
//   }
//
//   checkImage(InputImage inputImage) async {
//     List<Face> faces = await faceDetector.processImage(inputImage);
//     debugPrint('faces: $faces');
//     if (faces.isEmpty) {
//       clearCaptured('No faces detected in the image.');
//     }
//     if (faces.length > 1) {
//       clearCaptured(
//         'Multiple faces detected. Please try capturing a single face.',
//       );
//     }
//     // Handle the detected faces
//     for (Face face in faces) {
//       if (face.leftEyeOpenProbability != null &&
//           face.rightEyeOpenProbability != null) {
//         final leftEyeOpen = face.leftEyeOpenProbability! > 0.5;
//         final rightEyeOpen = face.rightEyeOpenProbability! > 0.5;
//         if (leftEyeOpen && rightEyeOpen) {
//           error = 'Click capture to save this image';
//           if (mounted) setState(() {});
//           return;
//         } else if (!leftEyeOpen && !rightEyeOpen) {
//           clearCaptured('Both eyes are closed!');
//         } else if (leftEyeOpen && !rightEyeOpen) {
//           clearCaptured('Left eye is open, right eye is closed.');
//         } else if (!leftEyeOpen && rightEyeOpen) {
//           clearCaptured('Right eye is open, left eye is closed.');
//         }
//       } else {
//         clearCaptured(
//           'Looks like either one or both eyes have not been captured properly. Please try again.',
//         );
//       }
//     }
//   }
//
//
//   InputImage? inputImageFromCameraImage(CameraImage image) {
//     final camera = cameras[1];
//     final sensorOrientation = camera.sensorOrientation;
//     InputImageRotation? rotation;
//     if (Platform.isIOS) {
//       rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
//     } else if (Platform.isAndroid) {
//       var rotationCompensation =
//       orientations[controller!.value.deviceOrientation];
//       if (rotationCompensation == null) return null;
//       if (camera.lensDirection == CameraLensDirection.front) {
//         // front-facing
//         rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
//       } else {
//         // back-facing
//         rotationCompensation =
//             (sensorOrientation - rotationCompensation + 360) % 360;
//       }
//       rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
//     }
//     if (rotation == null) return null;
//
//     // get image format
//     final format = InputImageFormatValue.fromRawValue(image.format.raw);
//
//     if (format == null ||
//         (Platform.isAndroid && format != InputImageFormat.nv21) ||
//         (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;
//
//     // since format is constraint to nv21 or bgra8888, both only have one plane
//     if (image.planes.length != 1) return null;
//     final plane = image.planes.first;
//
//     // compose InputImage using bytes
//     return InputImage.fromBytes(
//       bytes: plane.bytes,
//       metadata: InputImageMetadata(
//         size: Size(image.width.toDouble(), image.height.toDouble()),
//         rotation: rotation, // used only in Android
//         format: format, // used only in iOS
//         bytesPerRow: plane.bytesPerRow, // used only in iOS
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Capture Your Selfie'),
//       ),
//       bottomNavigationBar: controller == null
//           ? null
//           : Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(error),
//           SizedBox(height:30),
//           ElevatedButton(
//             child: Text('Capture'),
//             onPressed: () async {
//               await controller!.takePicture().then((value) {});
//             },
//           ),
//           SizedBox(height:20),
//         ],
//       ),
//       body: controller == null
//           ? Center(child: Text('Need to access camera to capture selfie'))
//           : CameraPreview(controller!),
//     );
//   }
// }