import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class CameraService {
  CameraController? _cameraController;
  CameraController? get cameraController => _cameraController;

  InputImageRotation? _cameraRotation;
  InputImageRotation? get cameraRotation => _cameraRotation;

  String? _imagePath;
  String? get imagePath => _imagePath;

  Future<void> initialize() async {
    if (_cameraController != null) return;
    CameraDescription description = await _getCameraDescription();
    await _setupCameraController(description: description);
    print("Camera _cameraController: $_cameraController");
    print("Camera description: $description");
    _cameraRotation = rotationIntToImageRotation(
      description.sensorOrientation,

    );
    print("Camera rotation: $_cameraRotation");
  }

  // Future<CameraDescription> _getCameraDescription() async {
  //   List<CameraDescription> cameras = await availableCameras();
  //   print("Available cameras: $cameras");
  //   return cameras.firstWhere((CameraDescription camera) =>
  //       camera.lensDirection == CameraLensDirection.front);
  // }
  Future<CameraDescription> _getCameraDescription() async {
    print("Fetching available cameras...");
    List<CameraDescription> cameras = await availableCameras();
    print("Available cameras: $cameras");

    CameraDescription selectedCamera = cameras.firstWhere(
          (CameraDescription camera) =>
      camera.lensDirection == CameraLensDirection.front,
    );
    print("Selected front camera: $selectedCamera");
    return selectedCamera;
  }
  Future _setupCameraController({
    required CameraDescription description,
  }) async {
    _cameraController = CameraController(
      description,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await _cameraController?.initialize();
  }

  InputImageRotation rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 90:
        return InputImageRotation.rotation90deg;
      case 180:
        return InputImageRotation.rotation180deg;
      case 270:
        return InputImageRotation.rotation270deg;
      default:
        return InputImageRotation.rotation0deg;
    }
  }

  Future<XFile?> takePicture() async {
    assert(_cameraController != null, 'Camera controller not initialized');
    await _cameraController?.stopImageStream();
    XFile? file = await _cameraController?.takePicture();
    _imagePath = file?.path;
    print("Picture taken. Image path: $_imagePath");
    return file;
  }

  Size getImageSize() {
    assert(_cameraController != null, 'Camera controller not initialized');
    assert(
        _cameraController!.value.previewSize != null, 'Preview size is null');
    return Size(
      _cameraController!.value.previewSize!.height,
      _cameraController!.value.previewSize!.width,
    );
  }

  dispose() async {
    await _cameraController?.dispose();
    _cameraController = null;
  }
}

