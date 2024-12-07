import 'package:get_it/get_it.dart';
import 'package:online/services/camera.service.dart';
import 'package:online/services/face_detector_service.dart';

final serviceLocator = GetIt.instance;

void setupServices() {
  serviceLocator.registerLazySingleton<CameraService>(() => CameraService());
  serviceLocator
      .registerLazySingleton<FaceDetectorService>(() => FaceDetectorService());
}
