import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:online/locator.dart';
import 'package:online/modules/auth/login/login_camera_view.dart';
import 'package:online/services/camera.service.dart';
import 'package:online/services/face_detector_service.dart';
import 'package:online/services/image_converter.dart';
import 'package:online/utils/utils.dart';
import 'package:online/widgets/camera_widgets/FacePainter.dart';
import 'package:online/widgets/camera_widgets/camera_header.dart';

class LoginCameraTwo extends StatefulWidget {
  final String attendanceId;
  const LoginCameraTwo({super.key, required this.attendanceId});

  @override
  LoginCameraTwoState createState() => LoginCameraTwoState();
}

class LoginCameraTwoState extends State<LoginCameraTwo> {
  String? imagePath;
  Face? faceDetected;
  Size? imageSize;
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
        print("Error capturing image: $e");
        return false;
      }
    }
  }

  _frameFaces() {
    imageSize = _cameraService.getImageSize();
    _cameraService.cameraController?.startImageStream((cameraImage) async {
      try {
        await _faceDetectorService.detectFacesFromImage(cameraImage);
        if (_faceDetectorService.faces.length == 1) {
          if (mounted) {
            setState(() {
              faceDetected = _faceDetectorService.faces[0];
            });
            isFaceDetected(Utils.isValidFace(faceDetected));
          }
        } else {
          if (mounted) {
            isFaceDetected(false);
            setState(() {
              faceDetected = null;
            });
          }
        }

        if (_faceDetectorService.captureImage) {
          _faceDetectorService.currentImage = cameraImage;
          _faceDetectorService.captureImage = false;
          Utils.printLog('Capturing new image...');
          final imageFromCamera = convertCameraImage(cameraImage);
          final File imgFile = await convertImageToFile(imageFromCamera);
          if (mounted) {
            Get.off(() => LoginCameraViewTwo(
                imageFile: imgFile, attendanceId: widget.attendanceId));
          }
        }
      } catch (e) {
        print('Error in face detection: $e');
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

  static double mirror = math.pi;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    late Widget body;
    if (_initializing) {
      body = const Center(child: CircularProgressIndicator());
    } else if (pictureTaken && imagePath != null) {
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
                height: _cameraService.cameraController != null
                    ? width * _cameraService.cameraController!.value.aspectRatio
                    : 0, // Avoid using null aspect ratio
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    if (_cameraService.cameraController != null)
                      CameraPreview(_cameraService.cameraController!),
                    if (faceDetected != null)
                      CustomPaint(
                        painter: FacePainter(
                          face: faceDetected!,
                          imageSize: imageSize!,
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
            "Login with face",
            onBackPressed: _onBackPressed,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(() {
        return Visibility(
          visible: isFaceDetected.value,
          child: ElevatedButton(
            onPressed: faceDetected != null ? onShot : null,
            child: const Icon(Icons.camera_alt),
          ),
        );
      }),
    );
  }
}
