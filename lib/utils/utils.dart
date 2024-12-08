import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:nb_utils/nb_utils.dart';

class Utils {

  static final Logger _logger = Logger();
  static final appNavigatorKey = GlobalKey<NavigatorState>();
  static final locationDialogKey = GlobalKey();

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

  static Future<void> selectDate(BuildContext context,
      TextEditingController controller) async {
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

  static Future<DateTime?> showDatePickerDialog(BuildContext context,
      DateTime selectedDate) async {
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
      backgroundColor: Colors.green,
      // Success color
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
      backgroundColor: Colors.red,
      // Error color
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
        // Parse UTC time string to DateTime
        DateTime parsedDate = DateTime.parse(dateTime).toLocal();
        // Format to local time with AM/PM
        return DateFormat('hh:mm:ss a').format(parsedDate);
      } else if (dateTime is DateTime) {
        // If it's already a DateTime object, convert to local time
        DateTime localDate = dateTime.toLocal();
        return DateFormat('hh:mm:ss a').format(localDate);
      } else {
        return 'Invalid Date';
      }
    } catch (e) {
      return 'Invalid Date';
    }
  }
  static String maskEmail(String email) {
    // Assuming the email is in the form "example@example.com"
    List<String> parts = email.split('@');
    String maskedEmail = parts[0].substring(0, 2) + '*' * (parts[0].length - 4) + parts[0].substring(parts[0].length - 4) + '@' + parts[1];
    return maskedEmail;
  }

  // Method to mask the contact number
  static String maskContact(String contact) {
    // Assuming contact is a phone number, e.g., "9876543210"
    String maskedContact = contact.substring(0, 2) + '*' * (contact.length - 6) + contact.substring(contact.length - 4);
    return maskedContact;
  }
}