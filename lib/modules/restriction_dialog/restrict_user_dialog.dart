import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';



Future<void> showRestrictionAlert(BuildContext context,
    {String message = 'Your location does not match the required location.',
      String bottomMessage = 'Please try again from the specified location.'}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap button
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          message,
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Icon(Icons.error_outline, size: 50),
              const SizedBox(height: 20),
              Text(
                bottomMessage,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
Future<void> showLocationAlert(BuildContext context,
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

Future<Position> determinePosition(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await showLocationAlert(
      context,
      message: "Please enable location services to proceed",
      bottomMessage: "Location services are required for this feature.",
      showButton: true, // Show 'Continue' button to open settings
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
}
