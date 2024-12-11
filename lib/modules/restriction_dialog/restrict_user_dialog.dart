import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:online/utils/utils.dart';



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



//profile controller

// Function to get the current position (latitude, longitude)
  Future<Position> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Show dialog and exit if services are disabled
        await showProfileLocationAlert(
          context,
          message: "Please enable location services to proceed",
          bottomMessage: "Location services are required for this feature.",
          showButton: true, // Show 'Enable Location' button
        );

        throw Exception('Location services are disabled.');
      }

      // Check location permissions
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied. Cannot request permissions.');
      }

      // Get current position
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {

      rethrow; // Propagate the exception
    }
  }

// Function to show an alert dialog when location services are disabled
  Future<void> showProfileLocationAlert(BuildContext context,
      {String message = "Please enable location service and try again",
      String bottomMessage = "We are only available in Specified region.",
      bool showButton = false}) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap the button
      builder: (BuildContext context) {
        // Automatically close the dialog after 2 seconds
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });

        return AlertDialog(
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
                    onPressed: () async {
                      // Open location settings
                      await Geolocator.openLocationSettings();
                      Navigator.pop(context); // Close dialog after button press
                    },
                    child: const Text("Enable Location"),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }