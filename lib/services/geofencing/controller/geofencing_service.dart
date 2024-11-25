import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:online/locator.dart';
import 'package:online/module_controllers.dart';
import 'package:online/modules/restriction_dialog/loading_manager.dart';
import 'package:online/utils/utils.dart';
import 'package:poly_geofence_service/poly_geofence_service.dart';

class GeoFencingService extends GetxController {
  final alertDialogKey = GlobalKey();

  LoadingManager loadingManager = serviceLocator<LoadingManager>();

  @override
  void dispose() {
    super.dispose();
    polyGeofenceService.removeLocationChangeListener(_onLocationChanged);
    streamController.close();
  }

  void initServices(BuildContext context) async {
    polyGeofenceService.addStreamErrorListener(_onError);
    polyGeofenceService.addLocationChangeListener(_onLocationChanged);
    polyGeofenceService.start(_polyGeofenceList).catchError(_onError);
  }

  final streamController = StreamController<PolyGeofence>();

  final polyGeofenceService = PolyGeofenceService.instance.setup(
    interval: 5000,
    accuracy: 80,
    loiteringDelayMs: 60000,
    statusChangeDelayMs: 10000,
    allowMockLocations: kDebugMode,
    printDevLog: kDebugMode,
  );

  final _polyGeofenceList = <PolyGeofence>[
    PolyGeofence(
      id: 'testing_loc',
      data: {
        'address': 'colorado',
        'about': 'Testing that user is out of location or not',
      },
      polygon: Utils.restrictionBoundary,
    ),
  ];

  void _onLocationChanged(Location location) {
    final isUserInLocation =
        isUserInDefinedBoundary(LatLng(location.latitude, location.longitude));
    if (!isUserInLocation) {
      if (alertDialogKey.currentContext == null) {
        loadingManager.showLoading();
      }
    } else {
      if (geoFencingService.alertDialogKey.currentContext != null) {
        Navigator.of(geoFencingService.alertDialogKey.currentContext!).pop();
      }
    }
  }

  static bool isUserInDefinedBoundary(LatLng location) {
    bool isUserInLocation = false;
    try {
      isUserInLocation = PolyUtils.containsLatLng(
          LatLng(location.latitude, location.longitude),
          Utils.restrictionBoundary);
    } on Exception catch (e) {
      Utils.printLog('error: $e');
      return false;
    }
    return isUserInLocation || kDebugMode;
  }

  void _onError(error) {
    final errorCode = getErrorCodesFromError(error);
    if (errorCode == null) {
      Utils.printLog('Undefined error: $error');
      return;
    }

    Utils.printLog('ErrorCode: $errorCode');
  }
}
