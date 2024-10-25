import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart'
as PermissionHandler;

import '../utils/utils.dart';

class GeoLocatorService {
  // GeoLocatorService();

  // make this class single ton
  static final GeoLocatorService _instance = GeoLocatorService._internal();

  factory GeoLocatorService() {
    return _instance;
  }

  GeoLocatorService._internal();

  static Future<bool> _checkService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await Geolocator.openLocationSettings();
    }

    return serviceEnabled;
  }

  static Future<bool> hasLocationPermission({bool enableToast = true}) async {
    LocationPermission status = await checkLocationPermissionStatus();

    if (status == LocationPermission.denied) {
      if (enableToast) {
        Utils.showToast("Please enable location service and try again");
      }
      status = await Geolocator.requestPermission();
    }

    return status == LocationPermission.always ||
        status == LocationPermission.whileInUse;
  }

  static Future<LocationPermission> checkLocationPermissionStatus() async {
    await _checkService();
    return await Geolocator.checkPermission();
  }

  static Future<bool> getPermission() async {
    LocationPermission status = await checkLocationPermissionStatus();
    if (status == LocationPermission.denied) {
      status = await Geolocator.requestPermission();
    } else if (status != LocationPermission.always &&
        status != LocationPermission.whileInUse) {
      await PermissionHandler.openAppSettings();
    }

    return status == LocationPermission.always ||
        status == LocationPermission.whileInUse;
  }

  static Future<Position> getCurrentLocation() async {
    late Position position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } on Exception catch (e) {
      Utils.printLog('getCurrentLocation geolocation error :: $e');
    }
    Utils.printLog('getCurrentLocation geolocation :: $position');
    return position;
  }

  static Future<Position?> getCurrentCoords({bool enableToast = true}) async {
    bool status = false;
    Position? position;
    if (!(await hasLocationPermission(enableToast: enableToast))) {
      await getPermission();
      status = await hasLocationPermission(enableToast: false);
    } else {
      status = true;
    }

    if (status) {
      position = await getCurrentLocation();
    }
    Utils.printLog('getCurrentCoords geolocation :: $position $status');
    return position;
  }

  static double getDistanceBetweenToPoints(double? latitudeFrom,
      double? longitudeFrom, double latitudeTo, double longitudeTo) {
    if (latitudeFrom == null || longitudeFrom == null) {
      return 0.0;
    }

    double rad = pi / 180;
    // Calculate distance from latitude and longitude
    double theta = longitudeFrom - longitudeTo;
    double dist = sin(latitudeFrom * rad) * sin(latitudeTo * rad) +
        cos(latitudeFrom * rad) * cos(latitudeTo * rad) * cos(theta * rad);
    final value = acos(dist) / rad * 60 * 1.853;
    return double.parse(value.toStringAsFixed(2));
  }
}
