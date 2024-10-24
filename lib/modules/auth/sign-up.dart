import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:online/services/camera.service.dart';
import 'package:online/services/face_detector_service.dart';
import 'package:online/widgets/FacePainter.dart';
import 'package:online/widgets/camera_header.dart';

import '../../locator.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  String? imagePath;
  Face? faceDetected;
  Size? imageSize;

  bool _detectingFaces = false;
  bool pictureTaken = false;
  bool _initializing = false;
  bool _bottomSheetVisible = false;

  // Service injection
  final FaceDetectorService _faceDetectorService = locator<FaceDetectorService>();
  final CameraService _cameraService = locator<CameraService>();

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
      try {
        await _cameraService.cameraController?.stopImageStream();
        await Future.delayed(const Duration(milliseconds: 500));

        XFile? file = await _cameraService.takePicture();
        imagePath = file?.path;

        setState(() {
          _bottomSheetVisible = true;
          pictureTaken = true;
        });

        return true;
      } catch (e) {
        print("Error capturing image: $e");
        return false;
      }
    }
  }

  _frameFaces() {
    imageSize = _cameraService.getImageSize();

    _cameraService.cameraController?.startImageStream((image) async {
      if (_detectingFaces) return;

      _detectingFaces = true;

      try {
        await _faceDetectorService.detectFacesFromImage(image);
        if (_faceDetectorService.faces.isNotEmpty) {
          setState(() {
            faceDetected = _faceDetectorService.faces[0];
          });
        } else {
          setState(() {
            faceDetected = _faceDetectorService.faces[0];
          });
        }

        _detectingFaces = false;
      } catch (e) {
        print('Error in face detection: $e');
        _detectingFaces = false;
      }
    });
  }

  _onBackPressed() {
    Navigator.of(context).pop();
  }

  _reload() {
    setState(() {
      _bottomSheetVisible = false;
      pictureTaken = true;
    });
    _start();
  }

  @override
  Widget build(BuildContext context) {
    const double mirror = math.pi;
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
              child: Container(
                width: width,
                height: width * _cameraService.cameraController!.value.aspectRatio,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
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
            "SIGN UP",
            onBackPressed: _onBackPressed,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _bottomSheetVisible ? null : onShot, // Call onShot when pressed
        tooltip: 'Capture', // Tooltip for the button
        child: const Icon(Icons.camera_alt), // Icon for the button
      ),
    );
  }
}
