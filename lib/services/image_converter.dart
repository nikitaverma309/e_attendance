import 'dart:io';

import 'package:image/image.dart' as imglib;
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

Future<File> convertCameraImageToFile(CameraImage image) async {
  imglib.Image? convertedImage;
  if (image.format.group == ImageFormatGroup.yuv420) {
    convertedImage = _convertYUV420(image);
  } else if (image.format.group == ImageFormatGroup.bgra8888) {
    convertedImage = _convertBGRA8888(image);
  }
  if (convertedImage != null) {
    // Encode the image to JPEG format
    final jpegBytes = imglib.encodeJpg(convertedImage);
    // Get temporary directory and save the file
    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/camera_image.jpeg';
    final file = File(imagePath);

    return await file.writeAsBytes(jpegBytes);
  }

  throw Exception('Image format not supported');
}

imglib.Image convertToImage(CameraImage image) {
  try {
    if (image.format.group == ImageFormatGroup.yuv420) {
      return _convertYUV420(image);
    } else if (image.format.group == ImageFormatGroup.bgra8888) {
      return _convertBGRA8888(image);
    }
    throw Exception('Image format not supported');
  } catch (e) {
    print("ERROR:$e");
  }
  throw Exception('Image format not supported');
}

/// Convert CameraImage BGRA8888 to an imglib.Image
imglib.Image _convertBGRA8888(CameraImage image) {
  // Extract the plane's bytes (raw image data)
  final bgraBytes = image.planes[0].bytes;

  // Convert raw bytes into an imglib.Image
  return imglib.Image.fromBytes(
    width: image.width,
    height: image.height,
    bytes: bgraBytes.buffer, // Convert Uint8List to ByteBuffer
    format: imglib.Format.uint8,
  );

 }
imglib.Image _convertYUV420(CameraImage image) {
  final width = image.width;
  final height = image.height;

  final yPlane = image.planes[0].bytes;
  final uPlane = image.planes[1].bytes;
  final vPlane = image.planes[2].bytes;

  // Create an empty imglib.Image with proper dimensions
  final img = imglib.Image(width: width, height: height);

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      final yValue = yPlane[y * width + x] & 0xFF;
      final uvIndex = (y ~/ 2) * (width ~/ 2) + (x ~/ 2);

      final uValue = uPlane[uvIndex] & 0xFF;
      final vValue = vPlane[uvIndex] & 0xFF;

      // Convert YUV to RGB
      final r = (yValue + 1.402 * (vValue - 128)).clamp(0, 255).toInt();
      final g = (yValue - 0.344136 * (uValue - 128) - 0.714136 * (vValue - 128))
          .clamp(0, 255)
          .toInt();
      final b = (yValue + 1.772 * (uValue - 128)).clamp(0, 255).toInt();

      img.setPixel(x, y, imglib.ColorInt8.rgb(r, g, b));
    }
  }
  return img;
}

/*imglib.Image _convertBGRA8888(CameraImage image) {
  return imglib.Image.fromBytes(
    image.width,
    image.height,
    image.planes[0].bytes,
    format: imglib.Format.bgra,
  );
}

imglib.Image _convertYUV420(CameraImage image) {
  int width = image.width;
  int height = image.height;
  var img = imglib.Image(width, height);
  const int hexFF = 0xFF000000;
  final int uvyButtonStride = image.planes[1].bytesPerRow;
  final int? uvPixelStride = image.planes[1].bytesPerPixel;
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      final int uvIndex =
          uvPixelStride! * (x / 2).floor() + uvyButtonStride * (y / 2).floor();
      final int index = y * width + x;
      final yp = image.planes[0].bytes[index];
      final up = image.planes[1].bytes[uvIndex];
      final vp = image.planes[2].bytes[uvIndex];
      int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
      int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
          .round()
          .clamp(0, 255);
      int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
      img.data[index] = hexFF | (b << 16) | (g << 8) | r;
    }
  }

  return img;
}*/
/*

imglib.Image convertCameraImage(CameraImage image) {
  var img = convertToImage(image);
  return imglib.copyRotate(img, -90); // घुमाव करें जैसा आवश्यक हो
}

*/
imglib.Image convertCameraImage(CameraImage image) {
  var img = convertToImage(image);
  return imglib.copyRotate(img, angle: -90); // Pass the required 'angle' parameter
}

Future<File> convertImageToFile(imglib.Image image) async {
  // Encode the image to JPEG format
  final jpegBytes = imglib.encodeJpg(image);
  // Get temporary directory and save the file
  final directory = await getTemporaryDirectory();
  final getRandomName = DateTime.now().millisecondsSinceEpoch;
  final imagePath = '${directory.path}/camera_image_$getRandomName.jpeg';
  final file = File(imagePath);
  return await file.writeAsBytes(jpegBytes);
}