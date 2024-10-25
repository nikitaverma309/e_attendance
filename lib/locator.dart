import 'package:get_it/get_it.dart';
import 'package:online/services/camera.service.dart';
import 'package:online/services/face_detector_service.dart';
import 'package:online/services/ml_service.dart';
import 'package:online/utils/utils.dart';
import 'modules/restriction_dialog/dialog_manager.dart';
import 'modules/restriction_dialog/loading_manager.dart';


final serviceLocator = GetIt.instance;

void setupServices() {
  serviceLocator.registerLazySingleton<CameraService>(() => CameraService());
  serviceLocator
      .registerLazySingleton<FaceDetectorService>(() => FaceDetectorService());
  serviceLocator.registerLazySingleton<MLService>(() => MLService());
  serviceLocator.registerSingleton<LoadingManager>((LoadingManager()));
  serviceLocator.registerSingleton<DialogManager>((DialogManager(
    Utils.appNavigatorKey,
    serviceLocator<LoadingManager>(),
  )));
}
