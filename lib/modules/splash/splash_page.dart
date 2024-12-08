import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:online/feature_showcase_page.dart';
import 'package:online/modules/restriction_dialog/restrict_user_dialog.dart';
import 'package:online/services/geolocator_service.dart';
import 'package:online/utils/utils.dart';

import 'package:permission_handler/permission_handler.dart'
    as PermissionHandler;


class SplashScreenOne extends StatefulWidget {
  const SplashScreenOne({super.key});

  @override
  State<SplashScreenOne> createState() => _SplashScreenOneState();
}

class _SplashScreenOneState extends State<SplashScreenOne>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {

  final locationDialogKey = GlobalKey();
  late AnimationController _controller;
  late Animation<double> _animation;

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
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );

    _controller.forward();
    checkLocationAndNavigate();
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff2193b0), // Light blue
              Color(0xff6dd5ed), // Sky blue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _animation,
                child: ClipOval(
                  child: Image.asset(
<<<<<<< HEAD
                    "assets/icon/edu.png",
=======
                    "assets/icon/higher.png",
>>>>>>> 73707ac735af1804bd6daf6a49eb13ae46407c7c
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  pageNavigation() async {
    Utils.showToast("Please wait while we check your location");
    Position? currentLocation;
    try {
      currentLocation = await GeoLocatorService.getCurrentCoords();
      Utils.printLog("currentLocation $currentLocation");
    } on Exception catch (e) {
      Utils.printLog("exception $e");
    }

    await Future.delayed(const Duration(seconds: 2));
    Widget screen = const FeatureShowCasePage();

    // initGeoLocation();
    if (mounted) {
      Get.offAll(() => screen);
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
}
