import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:online/feature_showcase_page.dart';
import 'package:poly_geofence_service/poly_geofence_service.dart';

import 'package:permission_handler/permission_handler.dart'
as PermissionHandler;

import '../../locator.dart';
import '../../module_controllers.dart';
import '../../services/geofencing/controller/geofencing_service.dart';
import '../../services/geolocator_service.dart';
import '../../utils/utils.dart';
import '../restriction_dialog/loading_manager.dart';
import '../restriction_dialog/restrict_user_dialog.dart';

class SplashScreenOne extends StatefulWidget {
  const SplashScreenOne({Key? key}) : super(key: key);

  @override
  State<SplashScreenOne> createState() => _SplashScreenOneState();
}

class _SplashScreenOneState extends State<SplashScreenOne>
    with WidgetsBindingObserver {
  LoadingManager loadingManager = serviceLocator<LoadingManager>();

  final locationDialogKey = GlobalKey();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        hideLocationDialog();
        await Future.delayed(const Duration(milliseconds: 500));
        checkLocationAndNavigate();
        break;

      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkLocationAndNavigate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillStartForegroundTask(
      onWillStart: () async {
        return geoFencingService.polyGeofenceService.isRunningService;
      },
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'geofence_service_notification_channel',
        channelName: 'Geofence Service Notification',
        channelDescription:
        'This notification appears when the geofence service is running in the background.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        isSticky: false,
      ),
      iosNotificationOptions: const IOSNotificationOptions(),
      foregroundTaskOptions: const ForegroundTaskOptions(),
      notificationTitle: 'Geofence Service is running',
      notificationText: 'Tap to return to the app',
      child: StreamBuilder<PolyGeofence>(
          stream: geoFencingService.streamController.stream,
          builder: (context, snapshot) {
            return Scaffold(
              // backgroundColor: primaryColor,
              body: Center(
                child: Column(
                  children: [
                    SizedBox(height: size.height / 3),
                    Container(
                      height: 210,
                      width: 210,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(180),
                      ),
                      child: const Icon(
                        Icons.location_on,
                        size: 100,
                        color: Colors.red,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            );
          }),
    );
  }

  initGeoLocation() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      geoFencingService.initServices(context);
    });
  }

  pageNavigation() async {
    Utils.showToast("Please wait while we check your location");
    Position? currentLocation;
    try {
      currentLocation = await GeoLocatorService.getCurrentCoords();
    } on Exception catch (e) {
      Utils.printLog("exception $e");
    }

    bool isUserInLocation = false;

    if (currentLocation == null) {
      Utils.showToast("Please enable location service and try again");
      isUserInLocation = false;
    } else {
      isUserInLocation = GeoFencingService.isUserInDefinedBoundary(
        LatLng(currentLocation.latitude, currentLocation.longitude),
      );
    }

    if (!isUserInLocation) {
      if (geoFencingService.alertDialogKey.currentContext == null) {
        loadingManager.showLoading();
      }
    } else {
      if (geoFencingService.alertDialogKey.currentContext != null) {
        Navigator.of(geoFencingService.alertDialogKey.currentContext!).pop();
      }
      await Future.delayed(const Duration(seconds: 2));
      Widget screen = const FeatureShowCasePage();
      initGeoLocation();
      if(mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => screen,
            ));
      }
    }
  }

  checkLocationAndNavigate() async {
    final permissionStatus = await PermissionHandler.Permission.location.status;
    if (permissionStatus != PermissionHandler.PermissionStatus.granted) {
      if (permissionStatus ==
          PermissionHandler.PermissionStatus.permanentlyDenied) {
        showLocationDialog(showButton: true);
      } else {
        PermissionHandler.Permission.location.request().then((value) async {
          if (value.isGranted) {
            pageNavigation();
          } else {
            showLocationDialog();
          }
        });
      }

      return;
    } else {
      hideLocationDialog();
      pageNavigation();
    }
  }

  showLocationDialog({bool showButton = false}) async {
    if (Utils.locationDialogKey.currentContext == null) {
      showLocationAlert(Utils.appNavigatorKey.currentContext!,
          showButton: showButton);
    }
  }

  hideLocationDialog() {
    if (Utils.locationDialogKey.currentContext != null) {
      Navigator.of(Utils.locationDialogKey.currentContext!).pop();
    }
  }
}
