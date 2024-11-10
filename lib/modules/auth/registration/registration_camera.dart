import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:online/locator.dart';
import 'package:online/modules/auth/registration/registration_camera_view.dart';
import 'package:online/services/camera.service.dart';
import 'package:online/services/face_detector_service.dart';
import 'package:online/services/image_converter.dart';
import 'package:online/utils/utils.dart';
import 'package:online/widgets/camera_widgets/FacePainter.dart';
import 'package:online/widgets/camera_widgets/camera_header.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  String? imagePath;
  Face? faceDetected;
  Size? imageSize;
  bool _detectingFaces = false;
  bool pictureTaken = false;
  bool _initializing = false;
  RxBool isFaceDetected = false.obs;

  // Service injection
  final FaceDetectorService _faceDetectorService =
      serviceLocator<FaceDetectorService>();
  final CameraService _cameraService = serviceLocator<CameraService>();
  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _cameraService.dispose();
    super.dispose();
  }

  _start() async {
    setState(() => _initializing = true);
    await _cameraService.initialize();
    _faceDetectorService.initialize();
    setState(() => _initializing = false);
    _frameFaces();
  }

  Future<bool> onShot() async {
    if (faceDetected == null) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('No face detected!'),
          );
        },
      );
      return false;
    } else {
      _faceDetectorService.captureImage = true;
      try {
        return true;
      } catch (e) {
        Utils.printLog("Error capturing image: $e");
        return false;
      }
    }
  }

  _frameFaces() {
    imageSize = _cameraService.getImageSize();
    _cameraService.cameraController?.startImageStream((cameraImage) async {
      if (_detectingFaces) return;
      _detectingFaces = true;
      try {
        await _faceDetectorService.detectFacesFromImage(cameraImage);
        if (_faceDetectorService.faces.length == 1) {
          if (mounted) {
            setState(() {
              faceDetected = _faceDetectorService.faces[0];
            });
          }
        } else {
          if (mounted) {
            setState(() {
              faceDetected = null;
            });
          }
        }
        _detectingFaces = false;

        if (_faceDetectorService.captureImage) {
          _faceDetectorService.currentImage = cameraImage;
          _faceDetectorService.captureImage = false;
          Utils.printLog('Capturing new image...');
          final imageFromCamera = convertCameraImage(cameraImage);
          final File imgFile = await convertImageToFile(imageFromCamera);
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegistrationCameraViewTwo(
                  imageFile: imgFile,
                ),
              ),
            );
          }
        }
      } catch (e) {
        Utils.printLog('Error in face detection: $e');
        _detectingFaces = false;
      }
    });
  }

  _onBackPressed() {
    Navigator.of(context).pop();
  }

  _reload() {
    setState(() {
      // _bottomSheetVisible = false;
      pictureTaken = true;
    });
    _start();
  }

  final double mirror = math.pi;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    late Widget body;
    if (_initializing) {
      body = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (pictureTaken) {
      body = SizedBox(
        width: width,
        height: height,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(mirror),
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.file(File(imagePath!)),
          ),
        ),
      );
    } else {
      body = Transform.scale(
        scale: 1.0,
        child: AspectRatio(
          aspectRatio: MediaQuery.of(context).size.aspectRatio,
          child: OverflowBox(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: SizedBox(
                width: width,
                height:
                    width * _cameraService.cameraController!.value.aspectRatio,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    CameraPreview(_cameraService.cameraController!),
                    if (faceDetected != null)
                      CustomPaint(
                        painter: FacePainter(
                          face: faceDetected!,
                          imageSize: imageSize!,
                          onFaceDetected: (userDetected) {
                            Utils.printLog('User detected: $userDetected');
                            isFaceDetected(userDetected);
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          body,
          CameraHeader(
            "SIGN UP",
            onBackPressed: _onBackPressed,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(() {
        return Visibility(
          visible: faceDetected != null && isFaceDetected.value,
          child: ElevatedButton(
            onPressed: faceDetected == null ? null : onShot,
            child: const Icon(Icons.camera_alt),
          ),
        );
      }),
    );
  }
}
