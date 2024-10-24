import 'dart:math';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as imglib;
import 'dart:ui'; // Size को आयात करें
import 'image_converter.dart';

class MLService {
  final FaceDetector _faceDetector = GoogleMlKit.vision.faceDetector();
  List<double> _predictedData = [];
  List<double> get predictedData => _predictedData;

  /// कैमरा इमेज को प्रोसेस करें और चेहरे की पहचान करें।
  Future<void> processImage(CameraImage cameraImage) async {
    // CameraImage को imglib.Image में कन्वर्ट करें
    imglib.Image img = _convertCameraImage(cameraImage);

    // InputImageData तैयार करें
    final inputImageData = InputImageData(
      size: Size(img.width.toDouble(), img.height.toDouble()), // Size का उपयोग
      imageRotation: InputImageRotation.rotation90deg, // सही नाम का उपयोग करें
      inputImageFormat: InputImageFormat.yuv_420_888,
      planeData: [],
    );

    // InputImage तैयार करें
    final inputImage = InputImage.fromBytes(
      bytes: img.getBytes(),
      inputImageData: inputImageData,
    );

    // चेहरे की पहचान करें
    final faces = await _faceDetector.processImage(inputImage);

    // प्रत्येक पहचाने गए चेहरे को प्रोसेस करें
    for (final face in faces) {
      await _preProcess(cameraImage, face);
    }
  }

  /// चेहरे को क्रॉप करें और इमेज प्रोसेसिंग करें।
  Future<void> _preProcess(CameraImage image, Face faceDetected) async {
    imglib.Image croppedImage = _cropFace(image, faceDetected);
    imglib.Image img = imglib.copyResizeCropSquare(croppedImage, 112);

    Float32List imageAsList = imageToByteListFloat32(img);
    _predictedData = imageAsList.toList(); // स्टोर करें प्रोसेस्ड डेटा
  }

  /// चेहरे के बाउंडिंग बॉक्स से इमेज को क्रॉप करें।
  imglib.Image _cropFace(CameraImage image, Face faceDetected) {
    final boundingBox = faceDetected.boundingBox;

    // Face bounding box से क्रॉपिंग की गई छवि प्राप्त करें
    return imglib.copyCrop(
      convertToImage(image),
      boundingBox.left.toInt(),
      boundingBox.top.toInt(),
      boundingBox.width.toInt(),
      boundingBox.height.toInt(),
    );
  }

  /// CameraImage को imglib.Image में बदलें।
  imglib.Image _convertCameraImage(CameraImage image) {
    // CameraImage को imglib.Image में बदलने की विधि।
    var img = convertToImage(image);
    return imglib.copyRotate(img, -90); // घुमाव करें जैसा आवश्यक हो
  }

  /// इमेज को Float32List में बदलें।
  Float32List imageToByteListFloat32(imglib.Image image) {
    var convertedBytes = Float32List(1 * 112 * 112 * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;

    for (var i = 0; i < 112; i++) {
      for (var j = 0; j < 112; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (imglib.getRed(pixel) - 128) / 128;
        buffer[pixelIndex++] = (imglib.getGreen(pixel) - 128) / 128;
        buffer[pixelIndex++] = (imglib.getBlue(pixel) - 128) / 128;
      }
    }
    return convertedBytes;
  }


  double _euclideanDistance(List<double>? e1, List<double>? e2) {
    if (e1 == null || e2 == null) throw Exception("Null argument");

    double sum = 0.0;
    for (int i = 0; i < e1.length; i++) {
      sum += (e1[i] - e2[i]) * (e1[i] - e2[i]);
    }
    return sqrt(sum);
  }

  /// संसाधनों को रिलीज़ करें।
  void dispose() {
    _faceDetector.close(); // Face detector को बंद करें
  }
}
