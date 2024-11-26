import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:poly_geofence_service/models/lat_lng.dart';

class Utils {
  static final Dio dio = Dio();
  static final Logger _logger = Logger();
  static final appNavigatorKey = GlobalKey<NavigatorState>();
  static final locationDialogKey = GlobalKey();
  static const restrictionBoundary = mantralayaBoundary;

  static const mantralayaBoundary = <LatLng>[
    LatLng(21.158931909764362, 81.79338743898444),
    LatLng(21.155982756084015, 81.80244959814013),
    LatLng(21.157840766288288, 81.80265393662432),
    LatLng(21.159336685763435, 81.80217374118587),
    LatLng(21.160432413367175, 81.80140747186852),
    LatLng(21.161661524243797, 81.79951734088797),
    LatLng(21.161813971393144, 81.79738200372515),
    LatLng(21.16097551012939, 81.79501167730604),
    LatLng(21.158931909764362, 81.79338743898444)
  ];

  static const cgCollegeBoundary = <LatLng>[
    LatLng(21.23567896190194, 81.64654275821994),
    LatLng(21.236286600576733, 81.64723829773033),
    LatLng(21.235568715344527, 81.6479036913849),
    LatLng(21.23504216324301, 81.64716074322916),
    LatLng(21.235691718251033, 81.64651965681747),
    LatLng(21.23567896190194, 81.64654275821994)
  ];

  static printLog(String message) {
    if (kDebugMode) {
      print(message);
    }
  }

  static showToast(String message) {
    toast(message);
  }

  static void loggerLog(String message,
      {String? error, Level level = Level.debug}) {
    if (kDebugMode) {
      Logger.level = level;
      if (error != null) {
        _logger.e(message, error: error);
      } else {
        _logger.d(message);
      }
    }
  }

  static setHeader() {
    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    return header;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? validateRequired(String? value) {
    return (value == null || value.isEmpty) ? 'Required' : null;
  }

  static Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      controller.text = formattedDate;
    }
  }

  static Future<DateTime?> showDatePickerDialog(
      BuildContext context, DateTime selectedDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      // Date selected, return pickedDate
      return pickedDate;
    } else {
      // No date selected, return null
      return null;
    }
  }

  static Uint8List getImageFromBase64(String img) {
    Uint8List _bytes;
    _bytes = const Base64Decoder().convert(img);
    return _bytes;
  }

  static bool isValidFace(Face? face) {
    bool isValid = false;
    try {
      if (face == null) {
        return false;
      }
      if ((face.headEulerAngleY!) > 10 || (face.headEulerAngleY!) < -10) {
        isValid = false;
      } else {
        isValid = true;
      }
    } catch (e) {
      isValid = false;
    }
    return isValid;
  }

  String formatDate(DateTime? date) {
    if (date != null) {
      // return DateFormat('dd/MM/yyyy').format(date);
      return "";
    } else {
      return 'dd/MM/yyyy';
    }
  }

  static void showSuccessToast({
    required String message,
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM,
    int timeInSecForIosWeb = 1,
    double fontSize = 16.0,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: Colors.green, // Success color
      textColor: Colors.white,
      fontSize: fontSize,
    );
  }

  static void showErrorToast({
    required String message,
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM,
    int timeInSecForIosWeb = 1,
    double fontSize = 16.0,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: Colors.red, // Error color
      textColor: Colors.white,
      fontSize: fontSize,
    );
  }



  static String formatDay(dynamic dateTime) {
    try {
      if (dateTime is String) {
        // If it's a string, parse it to DateTime
        DateTime parsedDate = DateTime.parse(dateTime);
        return DateFormat('dd/MM/yyyy ').format(parsedDate);
      } else if (dateTime is DateTime) {
        // If it's already a DateTime object
        return DateFormat('dd/MM/yyyy ').format(dateTime);
      } else {
        // If dateTime is not valid
        return 'Invalid Date';
      }
    } catch (e) {
      return 'Invalid Date';
    }
  }
  static String formatTime(dynamic dateTime) {
    try {
      if (dateTime is String) {
        // If it's a string, parse it to DateTime
        DateTime parsedDate = DateTime.parse(dateTime);
        return DateFormat('HH:mm:ss').format(parsedDate);
      } else if (dateTime is DateTime) {
        // If it's already a DateTime object
        return DateFormat('HH:mm:ss').format(dateTime);
      } else {
        // If dateTime is not valid
        return 'Invalid Date';
      }
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
