
import 'package:get_it/get_it.dart';
import 'package:online/services/camera.service.dart';
import 'package:online/services/face_detector_service.dart';

final locator = GetIt.instance;

void setupServices() {
  locator.registerLazySingleton<CameraService>(() => CameraService());
  locator.registerLazySingleton<FaceDetectorService>(() => FaceDetectorService());

}
