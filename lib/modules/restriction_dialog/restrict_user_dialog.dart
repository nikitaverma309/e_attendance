import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:online/module_controllers.dart';
import 'package:online/utils/utils.dart';

Future<void> showRestrictionAlert(BuildContext context,
    {String message = 'As of now we do not support your location.',
    bottomMessage = 'Thank you for your interest.'}) async {
  return showDialog<void>(
      context: Utils.appNavigatorKey.currentContext!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return PopScope(
            canPop: false,
            child: AlertDialog(
              key: geoFencingService.alertDialogKey,
              title: Text(
                message,
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const Icon(Icons.location_off, size: 50),
                    Text(
                      bottomMessage,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ));
      });
}

Future<void> showLocationAlert(BuildContext context,
    {String message = "Please enable location service and try again",
    bottomMessage = "We are only available in Specified region.",
    bool showButton = false}) async {
  return showDialog<void>(
      context: Utils.appNavigatorKey.currentContext!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return PopScope(
            canPop: false,
            child: AlertDialog(
              key: Utils.locationDialogKey,
              title: Text(
                message,
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const Icon(Icons.location_off, size: 50),
                    const SizedBox(height: 20),
                    Text(
                      bottomMessage,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    if (showButton) ...[
                      ElevatedButton(
                        onPressed: () {
                          Geolocator.openLocationSettings();
                        },
                        child: const Text("Continue"),
                      )
                    ]
                  ],
                ),
              ),
            ));
      });
}
