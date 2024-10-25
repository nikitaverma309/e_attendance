import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:poly_geofence_service/models/lat_lng.dart';

class Utils {
  static final Dio dio = Dio();
  static final Logger _logger = Logger();

  static final appNavigatorKey = GlobalKey<NavigatorState>();
  static final locationDialogKey = GlobalKey();
  static final restrictionBoundary = coloradoBoundary;

  static const coloradoBoundary = <LatLng>[
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

  // static showSuccessInSnackBar(BuildContext context, String title) async {
  //   try {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       duration: const Duration(seconds: 3),
  //       behavior: SnackBarBehavior.floating,
  //       backgroundColor: Colors.white,
  //       content: Container(
  //         decoration: Shape.submitContainerRed(context),
  //         child: Row(
  //           children: <Widget>[
  //             const Icon(
  //               Icons.check,
  //               size: 40,
  //               color: AppColors.white,
  //             ),
  //             Expanded(
  //               child: Container(
  //                   padding: const EdgeInsets.only(left: 10.0),
  //                   child: Text(
  //                     title,
  //                     overflow: TextOverflow.clip,
  //                     style: const TextStyle(fontWeight: FontWeight.bold),
  //                   )),
  //             )
  //           ],
  //         ),
  //       ),
  //     ));
  //   } catch (e) {
  //     // Handling the exception, but not using 'e'
  //   }
  // }

  // static showError(BuildContext context, String title) async {
  //   try {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         duration: const Duration(seconds: 1),
  //         behavior: SnackBarBehavior.floating,
  //         backgroundColor: Colors.transparent,
  //         elevation: 0,
  //         content: Container(
  //           margin: const EdgeInsets.symmetric(
  //               horizontal: 20, vertical: 10), // Adjust margin as needed
  //           decoration: Shape.errorContainerRed(context),
  //           child: Card(
  //             elevation: 0,
  //             color: Colors.transparent,
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 10.0),
  //               child: Row(
  //                 children: <Widget>[
  //                   const Icon(
  //                     Icons.close,
  //                     size: 40,
  //                     color: AppColors.white,
  //                   ),
  //                   const SizedBox(width: 10),
  //                   Expanded(
  //                     child: Text(
  //                       title,
  //                       overflow: TextOverflow.clip,
  //                       style: const TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           color: AppColors.white),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   } catch (e) {
  //     // Handling the exception, but not using 'e'
  //   }
  // }


  static Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // Set the first date limit
      lastDate: DateTime.now(), // Set the last date limit
    );

    if (pickedDate != null) {
      // Format the date to a readable string
      String formattedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      // Set the formatted date to the controller
      controller.text = formattedDate;
    }
  }
  Future<DateTime?> showDatePickerDialog(
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

  String formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd/MM/yyyy').format(date);
    } else {
      return 'dd/MM/yyyy';
    }
  }
}
